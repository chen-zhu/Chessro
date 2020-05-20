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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadChessScene()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)//.
        //print("Chessboard!", chessBoard.ChessBoard)
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
    
}
