//
//  King.swift
//  Chessro
//
//  Created by Stone Zhu on 5/18/20.
//  Copyright © 2020 Stone Zhu. All rights reserved.
//

import Foundation
import RealityKit

class King: ChessPiece{
    var row: Int
       
    var column: Int
       
    var PieceColor: color
    
    var type: pieceType
    
    var killed: Bool
    
    var ARObject: Entity?
    
    var firstMove = true
    
    init(setColor: color, r_pos: Int, c_pos: Int) {
        self.PieceColor = setColor
        self.type = .king
        self.killed = false
        self.ARObject = Entity()
        self.row = r_pos
        self.column = c_pos
    }
    
    func validStep(chessBoard: ChessBoard) -> Array<SIMD2<Int>>{
        var result: Array<SIMD2<Int>> = []
        
        for r_range in [-1, 0, 1] {
           for c_range in [-1, 0, 1] {
               let checkRow = row + r_range
               let checkCol = column + c_range
               if (0...7).contains(checkRow) && (0...7).contains(checkCol) {
                   let piece = chessBoard.ChessBoard[checkRow][checkCol]
                   if(piece == nil) {
                       result.append([checkRow, checkCol])
                   } else if(piece != nil && piece?.PieceColor != PieceColor){
                       result.append([checkRow, checkCol])
                   }
               }
           }
        }
               
        return result
    }
    
    
}
