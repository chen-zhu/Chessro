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
    
    var firstMove = true
    
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
        
        //White goes up && black piece goes downward!
        let direction = PieceColor == .white ? 1 : -1
        let checkRow = row + direction
        let checkCol = column
        
        //If the forawrd position is numm, then move!
        if chessBoard.ChessBoard[checkRow][checkCol] == nil {
            result.append([checkRow, checkCol])
            if firstMove {
                let moreStep = checkRow + direction
                if chessBoard.ChessBoard[moreStep][checkCol] == nil {
                    result.append([moreStep, checkCol])
                }
            }
        }
                
        /**
         TODO:  Need to handle En Passant case!
         */
        
        //If enemy is in diagonal direction~
        let checkLeft = checkCol - 1
        if checkLeft >= 0 {
            let piece = chessBoard.ChessBoard[checkRow][checkLeft]
            if piece != nil && piece?.PieceColor != PieceColor {
                result.append([checkRow, checkLeft])
            }
        }
        
        let checkRight = checkCol + 1
        if checkRight <= 7 {
            let piece = chessBoard.ChessBoard[checkRow][checkRight]
            if piece != nil && piece?.PieceColor != PieceColor {
                result.append([checkRow, checkRight])
            }
        }
        
        return result
    }
    
    
}
