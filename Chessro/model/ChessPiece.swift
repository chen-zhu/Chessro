//
//  ChessPiece.swift
//  Chessro
//
//  Created by Stone Zhu on 5/18/20.
//  Copyright © 2020 Stone Zhu. All rights reserved.
//

import Foundation
import ARKit
import RealityKit

protocol ChessPiece {
    
    var h: Int { get set }
    
    var v: Int { get set }
    
    var PieceColor: color{ get set }
    
    var type: pieceType{ get set }
    
    var killed: Bool{ get set }
    
    /**
     make sure to pass the reference from reality composer to this variable!
     */
    var ARObject: Entity{ get set }
    
    /**
        This function will return a list of valid move for the current chess piece
     */
    func validStep(from_x: Int, from_y: Int)
    
}

extension ChessPiece {
    
}
