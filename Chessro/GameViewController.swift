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
    var reverseLookUp = [UInt64: ChessPiece]()
    
    var movableGrids = Array<ModelEntity>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ChessSceneAnchor = try! Experience.loadChessScene()
        arView.scene.anchors.append(ChessSceneAnchor)//.
        
        self.LinkingEntities()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.PeopleOcclusion()
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
        
        // Not In Use ATM
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
        
        reverseLookUp[ChessSceneAnchor.whiterookone!.id]    = chessBoard.ChessBoard[0][0]!
        reverseLookUp[ChessSceneAnchor.whiteknightone!.id]  = chessBoard.ChessBoard[0][1]!
        reverseLookUp[ChessSceneAnchor.whitebishopone!.id]  = chessBoard.ChessBoard[0][2]!
        reverseLookUp[ChessSceneAnchor.whitequeen!.id]      = chessBoard.ChessBoard[0][3]!
        reverseLookUp[ChessSceneAnchor.whiteking!.id]       = chessBoard.ChessBoard[0][4]!
        reverseLookUp[ChessSceneAnchor.whitebishoptwo!.id]  = chessBoard.ChessBoard[0][5]!
        reverseLookUp[ChessSceneAnchor.whiteknighttwo!.id]  = chessBoard.ChessBoard[0][6]!
        reverseLookUp[ChessSceneAnchor.whiterooktwo!.id]    = chessBoard.ChessBoard[0][7]!
        
        reverseLookUp[ChessSceneAnchor.whitepawnone!.id]    = chessBoard.ChessBoard[1][0]!
        reverseLookUp[ChessSceneAnchor.whitepawntwo!.id]    = chessBoard.ChessBoard[1][1]!
        reverseLookUp[ChessSceneAnchor.whitepawnthree!.id]  = chessBoard.ChessBoard[1][2]!
        reverseLookUp[ChessSceneAnchor.whitepawnfour!.id]   = chessBoard.ChessBoard[1][3]!
        reverseLookUp[ChessSceneAnchor.whitepawnfive!.id]   = chessBoard.ChessBoard[1][4]!
        reverseLookUp[ChessSceneAnchor.whitepawnsix!.id]    = chessBoard.ChessBoard[1][5]!
        reverseLookUp[ChessSceneAnchor.whitepawnseven!.id]  = chessBoard.ChessBoard[1][6]!
        reverseLookUp[ChessSceneAnchor.whitepawneight!.id]  = chessBoard.ChessBoard[1][7]!
        
        reverseLookUp[ChessSceneAnchor.blackrookone!.id]    = chessBoard.ChessBoard[7][0]!
        reverseLookUp[ChessSceneAnchor.blackknightone!.id]  = chessBoard.ChessBoard[7][1]!
        reverseLookUp[ChessSceneAnchor.blackbishopone!.id]  = chessBoard.ChessBoard[7][2]!
        reverseLookUp[ChessSceneAnchor.blackqueen!.id]      = chessBoard.ChessBoard[7][3]!
        reverseLookUp[ChessSceneAnchor.blackking!.id]       = chessBoard.ChessBoard[7][4]!
        reverseLookUp[ChessSceneAnchor.blackbishoptwo!.id]  = chessBoard.ChessBoard[7][5]!
        reverseLookUp[ChessSceneAnchor.blackknighttwo!.id]  = chessBoard.ChessBoard[7][6]!
        reverseLookUp[ChessSceneAnchor.blackrooktwo!.id]    = chessBoard.ChessBoard[7][7]!
        
        reverseLookUp[ChessSceneAnchor.blackpawnone!.id]    = chessBoard.ChessBoard[6][0]!
        reverseLookUp[ChessSceneAnchor.blackpawntwo!.id]    = chessBoard.ChessBoard[6][1]!
        reverseLookUp[ChessSceneAnchor.blackpawnthree!.id]  = chessBoard.ChessBoard[6][2]!
        reverseLookUp[ChessSceneAnchor.blackpawnfour!.id]   = chessBoard.ChessBoard[6][3]!
        reverseLookUp[ChessSceneAnchor.blackpawnfive!.id]   = chessBoard.ChessBoard[6][4]!
        reverseLookUp[ChessSceneAnchor.blackpawnsix!.id]    = chessBoard.ChessBoard[6][5]!
        reverseLookUp[ChessSceneAnchor.blackpawnseven!.id]  = chessBoard.ChessBoard[6][6]!
        reverseLookUp[ChessSceneAnchor.blackpawneight!.id]  = chessBoard.ChessBoard[6][7]!
    }
    
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
    
    func drawMovableGrid(pos: SIMD3<Float>){
        let model = ModelEntity(mesh: .generatePlane(width: Float(gridSize - 0.02), depth: Float(gridSize - 0.02), cornerRadius: 0.7), materials: [SimpleMaterial.init(color: UIColor(red: 1, green: 0.7137, blue: 0, alpha: 0.8), isMetallic: true)])
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
    
    @IBAction func Tapping(_ sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: arView)
        
        if let piece = arView.entity(at: tapLocation){
            let OOD = reverseLookUp[piece.id]
            
            if(OOD != nil){
                
                //1. trigger the frontend
                let notification = ChessSceneAnchor.notifications.allNotifications.filter({
                    $0.identifier.hasPrefix(piece.name)
                })
                
                notification.first?.post()
                
                let movableSet = OOD!.validStep(chessBoard: chessBoard)
                
                self.deleteMovableGrid()
                
                for pair in movableSet{
                    self.drawMovableGrid(pos: self.translate_pos(row: pair.x, col: pair.y))
                }
                
            }
        }
        
    }
    
}
