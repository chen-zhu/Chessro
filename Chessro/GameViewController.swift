//
//  GameViewController.swift
//  Chessro
//
//  Created by Stone Zhu on 5/18/20.
//  Copyright © 2020 Stone Zhu. All rights reserved.
//

import UIKit
import RealityKit
import ARKit

class GameViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    let gridSize = 0.04654
    let gridHeight = 0.0139
    
    var chessBoard = ChessBoard()
    var ChessSceneAnchor = try! Experience.loadChessScene()
    var reverseLookUp = [String: ChessPiece]()
    var movableGrids = Array<ModelEntity>()
    var tappedPiece: Entity?
    var roundNumber = 1 //mod 1 -> white, 0 -> black
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ChessSceneAnchor = try! Experience.loadChessScene()
        arView.debugOptions = [ARView.DebugOptions.showFeaturePoints, ARView.DebugOptions.showWorldOrigin, ARView.DebugOptions.showAnchorOrigins]
        arView.scene.anchors.append(ChessSceneAnchor)//.
        
        self.LinkingEntities()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.PeopleOcclusion()
        tappedPiece = nil
        //let notificationList = ChessSceneAnchor.notifications.allNotifications.filter({
        //    $0.identifier.hasPrefix("white")
        //})
        //print(notificationList)
        //let notificationList2 = ChessSceneAnchor.notifications.allNotifications.filter({
        //    $0.identifier.hasPrefix("black")
        //})
        
        //self.InstallGuesture()
        
        //print(notificationList2)
    }
    
    func PeopleOcclusion() {
        guard let config = arView.session.configuration as? ARWorldTrackingConfiguration else {
            fatalError("Unexpectedly failed to get the configuration.")
        }
        guard ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) else {
            fatalError("People occlusion is not supported on this device.")
        }
        switch config.frameSemantics {
        case [.personSegmentationWithDepth]:
            config.frameSemantics.remove(.personSegmentationWithDepth)
        default:
            config.frameSemantics.insert(.personSegmentationWithDepth)
        }
        arView.session.run(config)
    }
    
    func LinkingEntities(){
        //Link white pieces
        
        //OMG IT LOOKS SOOOO DUMMM
        //TODO: COME UP WITH A BETTER WAY TO HADNLE IT!
        //Map Piece OOD to Entity
        /*
        chessBoard.ChessBoard[0][0]?.ARObject = ChessSceneAnchor.whiterookone!;
        chessBoard.ChessBoard[0][1]?.ARObject = ChessSceneAnchor.whiteknightone!;
        chessBoard.ChessBoard[0][2]?.ARObject = ChessSceneAnchor.whitebishopone!;
        chessBoard.ChessBoard[0][3]?.ARObject = ChessSceneAnchor.whitequeen!;
        chessBoard.ChessBoard[0][4]?.ARObject = ChessSceneAnchor.whiteking!;
        chessBoard.ChessBoard[0][5]?.ARObject = ChessSceneAnchor.whitebishoptwo!;
        chessBoard.ChessBoard[0][6]?.ARObject = ChessSceneAnchor.whiteknighttwo!;
        chessBoard.ChessBoard[0][7]?.ARObject = ChessSceneAnchor.whiterooktwo!;
        
        chessBoard.ChessBoard[1][0]?.ARObject = ChessSceneAnchor.whitepawnone!;
        chessBoard.ChessBoard[1][1]?.ARObject = ChessSceneAnchor.whitepawntwo!;
        chessBoard.ChessBoard[1][2]?.ARObject = ChessSceneAnchor.whitepawnthree!;
        chessBoard.ChessBoard[1][3]?.ARObject = ChessSceneAnchor.whitepawnfour!;
        chessBoard.ChessBoard[1][4]?.ARObject = ChessSceneAnchor.whitepawnfive!;
        chessBoard.ChessBoard[1][5]?.ARObject = ChessSceneAnchor.whitepawnsix!;
        chessBoard.ChessBoard[1][6]?.ARObject = ChessSceneAnchor.whitepawnseven!;
        chessBoard.ChessBoard[1][7]?.ARObject = ChessSceneAnchor.whitepawneight!;
        
        //BLACK
        chessBoard.ChessBoard[7][0]?.ARObject = ChessSceneAnchor.blackrookone!;
        chessBoard.ChessBoard[7][1]?.ARObject = ChessSceneAnchor.blackknightone!;
        chessBoard.ChessBoard[7][2]?.ARObject = ChessSceneAnchor.blackbishopone!;
        chessBoard.ChessBoard[7][3]?.ARObject = ChessSceneAnchor.blackqueen!;
        chessBoard.ChessBoard[7][4]?.ARObject = ChessSceneAnchor.blackking!;
        chessBoard.ChessBoard[7][5]?.ARObject = ChessSceneAnchor.blackbishoptwo!;
        chessBoard.ChessBoard[7][6]?.ARObject = ChessSceneAnchor.blackknighttwo!;
        chessBoard.ChessBoard[7][7]?.ARObject = ChessSceneAnchor.blackrooktwo!;
        
        chessBoard.ChessBoard[6][0]?.ARObject = ChessSceneAnchor.blackpawnone!;
        chessBoard.ChessBoard[6][1]?.ARObject = ChessSceneAnchor.blackpawntwo!;
        chessBoard.ChessBoard[6][2]?.ARObject = ChessSceneAnchor.blackpawnthree!;
        chessBoard.ChessBoard[6][3]?.ARObject = ChessSceneAnchor.blackpawnfour!;
        chessBoard.ChessBoard[6][4]?.ARObject = ChessSceneAnchor.blackpawnfive!;
        chessBoard.ChessBoard[6][5]?.ARObject = ChessSceneAnchor.blackpawnsix!;
        chessBoard.ChessBoard[6][6]?.ARObject = ChessSceneAnchor.blackpawnseven!;
        chessBoard.ChessBoard[6][7]?.ARObject = ChessSceneAnchor.blackpawneight!;
        */
        
        //map Piece Entity to OOD
        reverseLookUp[ChessSceneAnchor.whiterookone!.name]    = chessBoard.ChessBoard[0][0]!
        reverseLookUp[ChessSceneAnchor.whiteknightone!.name]  = chessBoard.ChessBoard[0][1]!
        reverseLookUp[ChessSceneAnchor.whitebishopone!.name]  = chessBoard.ChessBoard[0][2]!
        reverseLookUp[ChessSceneAnchor.whitequeen!.name]      = chessBoard.ChessBoard[0][3]!
        reverseLookUp[ChessSceneAnchor.whiteking!.name]       = chessBoard.ChessBoard[0][4]!
        reverseLookUp[ChessSceneAnchor.whitebishoptwo!.name]  = chessBoard.ChessBoard[0][5]!
        reverseLookUp[ChessSceneAnchor.whiteknighttwo!.name]  = chessBoard.ChessBoard[0][6]!
        reverseLookUp[ChessSceneAnchor.whiterooktwo!.name]    = chessBoard.ChessBoard[0][7]!
        
        reverseLookUp[ChessSceneAnchor.whitepawnone!.name]    = chessBoard.ChessBoard[1][0]!
        reverseLookUp[ChessSceneAnchor.whitepawntwo!.name]    = chessBoard.ChessBoard[1][1]!
        reverseLookUp[ChessSceneAnchor.whitepawnthree!.name]  = chessBoard.ChessBoard[1][2]!
        reverseLookUp[ChessSceneAnchor.whitepawnfour!.name]   = chessBoard.ChessBoard[1][3]!
        reverseLookUp[ChessSceneAnchor.whitepawnfive!.name]   = chessBoard.ChessBoard[1][4]!
        reverseLookUp[ChessSceneAnchor.whitepawnsix!.name]    = chessBoard.ChessBoard[1][5]!
        reverseLookUp[ChessSceneAnchor.whitepawnseven!.name]  = chessBoard.ChessBoard[1][6]!
        reverseLookUp[ChessSceneAnchor.whitepawneight!.name]  = chessBoard.ChessBoard[1][7]!
        
        reverseLookUp[ChessSceneAnchor.blackrookone!.name]    = chessBoard.ChessBoard[7][0]!
        reverseLookUp[ChessSceneAnchor.blackknightone!.name]  = chessBoard.ChessBoard[7][1]!
        reverseLookUp[ChessSceneAnchor.blackbishopone!.name]  = chessBoard.ChessBoard[7][2]!
        reverseLookUp[ChessSceneAnchor.blackqueen!.name]      = chessBoard.ChessBoard[7][3]!
        reverseLookUp[ChessSceneAnchor.blackking!.name]       = chessBoard.ChessBoard[7][4]!
        reverseLookUp[ChessSceneAnchor.blackbishoptwo!.name]  = chessBoard.ChessBoard[7][5]!
        reverseLookUp[ChessSceneAnchor.blackknighttwo!.name]  = chessBoard.ChessBoard[7][6]!
        reverseLookUp[ChessSceneAnchor.blackrooktwo!.name]    = chessBoard.ChessBoard[7][7]!
        
        reverseLookUp[ChessSceneAnchor.blackpawnone!.name]    = chessBoard.ChessBoard[6][0]!
        reverseLookUp[ChessSceneAnchor.blackpawntwo!.name]    = chessBoard.ChessBoard[6][1]!
        reverseLookUp[ChessSceneAnchor.blackpawnthree!.name]  = chessBoard.ChessBoard[6][2]!
        reverseLookUp[ChessSceneAnchor.blackpawnfour!.name]   = chessBoard.ChessBoard[6][3]!
        reverseLookUp[ChessSceneAnchor.blackpawnfive!.name]   = chessBoard.ChessBoard[6][4]!
        reverseLookUp[ChessSceneAnchor.blackpawnsix!.name]    = chessBoard.ChessBoard[6][5]!
        reverseLookUp[ChessSceneAnchor.blackpawnseven!.name]  = chessBoard.ChessBoard[6][6]!
        reverseLookUp[ChessSceneAnchor.blackpawneight!.name]  = chessBoard.ChessBoard[6][7]!
    }
    
    // MARK: - ChessBoard Coordinate Translate
    /**
     This function auto translates the array index (row, col) to the actual coordinate on the AR sense ChessBoard.
     */
    func translate_pos(row: Int, col: Int) -> SIMD3<Float>{
        let offset = 3.50
        
        let calc_row = Float(row) - Float(offset)
        let calc_col = Float(col) - Float(offset)
        let y = 0 + Float(gridHeight)
        
        return SIMD3(calc_col * Float(gridSize), y, 0 - calc_row * Float(gridSize))
    }
    
    /**
     This function auto translates the array index (row, col) to the actual coordinate on the AR sense ChessBoard.
     */
    func translate_index(x: Float, y: Float, z: Float) -> SIMD2<Int>{
        let offset = 3.50
        
        var row = 0
        var col = 0
        
        col = Int(round(x/Float(gridSize) + Float(offset))) 
        row = Int(round(-z/Float(gridSize) + Float(offset)))
        
        return SIMD2(row, col)
    }
    
    
    // MARK: - Movable Grids
    
    func drawMovableGrid(pos: SIMD3<Float>){
        let model = ModelEntity(mesh: .generatePlane(width: Float(gridSize - 0.01), depth: Float(gridSize - 0.01), cornerRadius: 0.7), materials: [SimpleMaterial.init(color: UIColor(red: 1, green: 0.7137, blue: 0, alpha: 0.8), isMetallic: false)])
        ChessSceneAnchor.addChild(model)
        model.position = pos
        movableGrids.append(model)
    }
    
    func deleteMovableGrid(){
        while !movableGrids.isEmpty {
            guard let removed = movableGrids.popLast() else { return }
            ChessSceneAnchor.removeChild(removed)
        }
    }
    
    // MARK: - Moving Chess Pieces
    
    func moveChessPiece(chessPiece: Entity, to_row: Int, to_col: Int, newMove: Bool = true){
        //1. update transform
        var PieceOOD = reverseLookUp[chessPiece.name]
        var transform = chessPiece.transform
        transform.translation = self.translate_pos(row: to_row, col: to_col)
        tappedPiece!.move(to: transform, relativeTo: chessPiece.parent, duration: 0.5)
        
        //1.5 perform killing if enemy exist.
        self.tryKillChessPiece(chessPiece: chessPiece, to_row: to_row, to_col: to_col)
        
        //2. Update Chessboard OOD ONLY IF CORD CHANGES!
        if(PieceOOD!.row != to_row || PieceOOD!.column != to_col){
            chessBoard.changeChessPieceIndex(old_row: PieceOOD!.row, old_col: PieceOOD!.column, new_row: to_row, new_col: to_col)
        }
        
        //3. update piece OOD
        PieceOOD!.row = to_row
        PieceOOD!.column = to_col
        
        //only update if the move is a new move!
        if newMove {
            PieceOOD!.firstMove = false
            roundNumber += 1
        }
    }
    
    /**
     Look up the AR entity by OOD (that uses ChesPiece protocol!)
     Protocol does not allow us to do direct search!
     */
    func entityNameByOOD(OOD: ChessPiece) -> Entity?{
        for item in reverseLookUp {
            if(
                item.value.PieceColor == OOD.PieceColor
                && item.value.column == OOD.column
                && item.value.row == OOD.row
                && item.value.type == OOD.type
            ){
                return ChessSceneAnchor.findEntity(named: item.key)
            }
        }
        return nil
    }
    
    
    /**
     Some pieces on the chessboard might have inaccurate position. Enforece the frontend to check pos for each pieces
     */
    //TODO: This is too expensive to put in place
    func cleanChessboard(){
        
    }
    
    
    // MARK: - Killing Chess Pieces
    
    /**
     Before moving pieces here, kill the existing piece first. Ow, no killing, just setting variables!
     */
    func tryKillChessPiece(chessPiece: Entity, to_row: Int, to_col: Int){
        //TODO: Add animation here!
        let sittingOOD = chessBoard.ChessBoard[to_row][to_col]
        let PieceOOD = reverseLookUp[chessPiece.name]
        if(sittingOOD != nil && sittingOOD?.PieceColor != PieceOOD?.PieceColor){
            var sittingEntity = self.entityNameByOOD(OOD: sittingOOD as! ChessPiece)
            sittingEntity!.isEnabled = false
        }
    }
    
    /**
     Check if the current round allows white/black to make a move.
     @return true if tap is invalid!
     */
    func invalidRound(tappedPieceOOD: ChessPiece) -> Bool{
        let tappedColor = tappedPieceOOD.PieceColor
        
        let modeResult = roundNumber % 2
        
        //if mod returns 1 and tapped piece has color white, then "NOT" invalid!
        if(modeResult == 1 && tappedColor == .white){
            return false
        } else if(modeResult == 0 && tappedColor == .black){
            return false
        } else {
            return true
        }
    }
    
    
}
