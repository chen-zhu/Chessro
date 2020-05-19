//
//  Pawn.swift
//  Chessro
//
//  Created by Stone Zhu on 5/18/20.
//  Copyright © 2020 Stone Zhu. All rights reserved.
//

import Foundation
import RealityKit

class Pawn: ChessPiece{
    var h: Int
    
    var v: Int
    
    var PieceColor: color
    
    var type: pieceType
    
    var killed: Bool
    
    var ARObject: Entity
    
    init(setColor: color, h_po: Int, v_po: Int) {
        self.PieceColor = setColor
        self.type = .pawn
        self.killed = false
        self.ARObject = Entity()
        self.h = h_po
        self.v = v_po
    }
    
    func validStep(from_x: Int, from_y: Int) {
        //balabala~
        //give a list of available postion that we can move to~
        
    }
    
    
}
