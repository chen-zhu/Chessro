//
//  GameViewController+Tapping.swift
//  Chessro
//
//  Created by Stone Zhu on 5/30/20.
//  Copyright © 2020 Stone Zhu. All rights reserved.
//

import UIKit
import RealityKit
import ARKit

extension GameViewController: UIGestureRecognizerDelegate {
    
    // MARK: - Tapping Guesture
    @IBAction func Tapping(_ sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: arView)
        
        if let piece = arView.entity(at: tapLocation){
            let OOD = reverseLookUp[piece.name]
            
            //If OOD can be found, then ppl tapped on the ChessPiece!
            if(OOD != nil){
                print("[DEBUG] Tapped Piece pos", piece.position, "\n\n")
                //1. enforce location anyway!
                piece.position = self.translate_pos(row: OOD!.row, col: OOD!.column)
                
                //2. if still tapping itself, then remove!
                if piece == tappedPiece{
                    tappedPiece = nil
                    self.deleteMovableGrid()
                    return
                }
                
                //Detect if the tapped piece is killable or not.
                if(tappedPiece != nil){
                    let OldtappedOOD = reverseLookUp[tappedPiece!.name]
                    let OldtappedMovableSet = OldtappedOOD!.validStep(chessBoard: chessBoard)
                    if(OldtappedMovableSet.contains(SIMD2(OOD!.row, OOD!.column))){
                        print("[DEBUG] Tapping - Allowed to kill!")
                        self.moveChessPiece(chessPiece: tappedPiece!, to_row: OOD!.row, to_col: OOD!.column)
                        
                        //actually we can stop here~
                        self.deleteMovableGrid()
                        tappedPiece = nil
                        return
                    }
                }
                
                //ELSE, NOT KILLABLE, THEN reselect Chesspiece here!
                //3. trigger the backend
                let notification = ChessSceneAnchor.notifications.allNotifications.filter({
                    $0.identifier.hasPrefix(piece.name)
                })
                notification.first?.post()
                
                //4. draw movable grid on the board!
                let movableSet = OOD!.validStep(chessBoard: chessBoard)
                self.deleteMovableGrid()
                if movableSet.count > 0{
                    tappedPiece = piece
                    for pair in movableSet{
                        self.drawMovableGrid(pos: self.translate_pos(row: pair.x, col: pair.y))
                    }
                }
                
            
            } else {
                //Else, it is possible that user tapped on the chessboard and making move!
                let piece = arView.entity(at: tapLocation)
                
                //If tapping on board, move to that position!
                if(piece?.name == "board" && tappedPiece != nil){
                    //Raycast!
                    let result = arView.raycast(from: tapLocation, allowing: .existingPlaneGeometry, alignment: .any).first
                    
                    if(result != nil){
                        //let notification = ChessSceneAnchor.notifications.allNotifications.filter({
                        //    $0.identifier.hasPrefix(tappedPiece!.name)
                        //})
                        
                        let resultAnchor = AnchorEntity(world: result!.worldTransform)
                        arView.scene.addAnchor(resultAnchor)
                        let pos = resultAnchor.position(relativeTo: ChessSceneAnchor)
                        arView.scene.removeAnchor(resultAnchor)
                        
                        let PieceOOD = reverseLookUp[tappedPiece!.name]
                        let movableSet = PieceOOD!.validStep(chessBoard: chessBoard)
                        let tapped_index = self.translate_index(x: pos.x, y: pos.y, z: pos.z)
                        
                        if(movableSet.contains(tapped_index)){
                            self.moveChessPiece(chessPiece: tappedPiece!, to_row: tapped_index.x, to_col: tapped_index.y)
                        }
                        
                        self.deleteMovableGrid()
                        tappedPiece = nil
                    }
                }
                
            }
        }
        
    }
    
    
    // MARK: - Dragging Guesture
    //var draggingEntity: Entity?
    @IBAction func Dragging(_ sender: UIPanGestureRecognizer) {
        let tapLocation = sender.location(in: arView)
        let piece = arView.entity(at: tapLocation)
        if piece != nil {
            _ = reverseLookUp[piece!.name]
                        
            switch sender.state {
                case .began:
                    print("Object began to move")
                    self.deleteMovableGrid()
                    if(piece!.name != "board"){
                        tappedPiece = piece
                    }
                case .changed:
                    print("Moving object position changed")
                    if(tappedPiece != nil){
                        let result = arView.raycast(from: tapLocation, allowing: .existingPlaneGeometry, alignment: .any).first
                        
                        //no need to move by the grid here!
                        if(result != nil){
                            //One stupid way to translate worldTransform to position
                            let resultAnchor = AnchorEntity(world: result!.worldTransform)
                            arView.scene.addAnchor(resultAnchor)
                            var pos = resultAnchor.position(relativeTo: ChessSceneAnchor)
                            arView.scene.removeAnchor(resultAnchor)
                            
                            pos.y = Float(gridHeight) + 0.01
                            var transform = tappedPiece!.transform
                            transform.translation = pos
                            tappedPiece!.move(to: transform, relativeTo: tappedPiece!.parent)
                        }
                    }
                case .cancelled, .failed, .ended:
                    print("Done moving object")
                    if(tappedPiece != nil){
                        //1. put down object!
                        let PieceOOD = reverseLookUp[tappedPiece!.name]
                        let movableSet = PieceOOD!.validStep(chessBoard: chessBoard)
                        let tapped_index = self.translate_index(x: tappedPiece!.position.x, y: tappedPiece!.position.y, z: tappedPiece!.position.z)
                        
                        if(movableSet.contains(tapped_index)){
                            self.moveChessPiece(chessPiece: tappedPiece!, to_row: tapped_index.x, to_col: tapped_index.y)
                        } else {
                            print("resume original position!")
                            self.moveChessPiece(chessPiece: tappedPiece!, to_row: PieceOOD!.row, to_col: PieceOOD!.column, newMove: false)
                        }
                    }
                    //2. reset object
                    self.deleteMovableGrid()
                    tappedPiece = nil
                default:
                    break
            }
        }
    }
    

}
