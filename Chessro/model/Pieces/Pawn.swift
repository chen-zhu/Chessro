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
    var row: Int
    
    var column: Int
    
    var PieceColor: color
    
    var type: pieceType
    
    var killed: Bool
    
    var ARObject: Entity
    
    init(setColor: color, r_pos: Int, c_pos: Int) {
        self.PieceColor = setColor
        self.type = .pawn
        self.killed = false
        self.ARObject = Entity()
        self.row = r_pos
        self.column = c_pos
    }
    
    func validStep(chessBoard: ChessBoard) -> Array<SIMD2<Int>>{
        var result: Array<SIMD2<Int>> = []
        
        
        
        return result
    }
    
    
}
