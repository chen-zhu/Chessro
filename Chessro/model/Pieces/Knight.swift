//
//  Knight.swift
//  Chessro
//
//  Created by Stone Zhu on 5/18/20.
//  Copyright © 2020 Stone Zhu. All rights reserved.
//

import Foundation
import RealityKit

class Knight: ChessPiece{
    var row: Int
    
    var column: Int
    
    var PieceColor: color
    
    var type: pieceType
    
    var killed: Bool
    
    var ARObject: Entity?
    
    var firstMove = true
    
    init(setColor: color, r_pos: Int, c_pos: Int) {
        self.PieceColor = setColor
        self.type = .knight
        self.killed = false
        self.ARObject = Entity()
        self.row = r_pos
        self.column = c_pos
    }
    
    func validStep(chessBoard: ChessBoard) -> Array<SIMD2<Int>>{
        var result: Array<SIMD2<Int>> = []

        let position_mocking: [SIMD2<Int>] = [
           [row - 2, column - 1],
           [row - 2, column + 1],
           [row + 2, column - 1],
           [row + 2, column + 1],
           [row - 1, column - 2],
           [row - 1, column + 2],
           [row + 1, column - 2],
           [row + 1, column + 2]
        ]

        for pos in position_mocking {
           if (0...7).contains(pos[0]) && (0...7).contains(pos[1]) {
               let piece = chessBoard.ChessBoard[pos[0]][pos[1]]
               if piece == nil {
                   result.append(pos)
               } else if(piece != nil && piece?.PieceColor != PieceColor){
                   result.append(pos)
               }
           }
        }
        
        return result
    }
    
    
}
