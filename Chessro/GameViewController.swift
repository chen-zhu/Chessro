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
    
    var chessBoard = ChessBoard()
    var ChessSceneAnchor = try! Experience.loadChessScene()
    var reverseLookUp = [UInt64: ChessPiece]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the "Box" scene from the "Experience" Reality File
        //ChessSceneAnchor = try! Experience.loadChessScene()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(ChessSceneAnchor)//.
        
        self.LinkingEntities()
        
        print(reverseLookUp)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.PeopleOcclusion()
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
    
    
    
}
