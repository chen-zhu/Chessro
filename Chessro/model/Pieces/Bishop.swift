//
//  Bishop.swift
//  Chessro
//
//  Created by Stone Zhu on 5/18/20.
//  Copyright © 2020 Stone Zhu. All rights reserved.
//

import Foundation
import RealityKit

class Bishop: ChessPiece{
    var row: Int
       
    var column: Int
       
    var PieceColor: color
    
    var type: pieceType
    
    var killed: Bool
    
    var ARObject: Entity?
    
    var firstMove = true
    
    init(setColor: color, r_pos: Int, c_pos: Int) {
        self.PieceColor = setColor
        self.type = .bishop
        self.killed = false
        self.ARObject = Entity()
        self.row = r_pos
        self.column = c_pos
    }
    
    func validStep(chessBoard: ChessBoard) -> Array<SIMD2<Int>>{
        var result: Array<SIMD2<Int>> = []
        
        // Goes to top-left
        var checkRow = row + 1
        var checkCol = column - 1
        while checkRow < 8 && checkCol >= 0 {
            if let piece = chessBoard.ChessBoard[checkRow][checkCol] {
                if piece.PieceColor != PieceColor {
                    result.append([checkRow, checkCol])
                }
                break
            } else {
                result.append([checkRow, checkCol])
            }
            checkRow += 1
            checkCol -= 1
        }
        
        // Goes to top-right
        checkRow = row + 1
        checkCol = column + 1
        while checkRow < 8 && checkCol < 8 {
            if let piece = chessBoard.ChessBoard[checkRow][checkCol] {
                if piece.PieceColor != PieceColor {
                    result.append([checkRow, checkCol])
                }
                break
            } else {
                result.append([checkRow, checkCol])
            }
            checkRow += 1
            checkCol += 1
        }
        
        // Goes to bottom-right
        checkRow = row - 1
        checkCol = column + 1
        while checkRow >= 0 && checkCol < 8 {
            if let piece = chessBoard.ChessBoard[checkRow][checkCol] {
                if piece.PieceColor != PieceColor {
                    result.append([checkRow, checkCol])
                }
                break
            } else {
                result.append([checkRow, checkCol])
            }
            checkRow -= 1
            checkCol += 1
        }
        
        // Goes to bottom-left
        checkRow = row - 1
        checkCol = column - 1
        while checkRow >= 0 && checkCol >= 0 {
            if let piece = chessBoard.ChessBoard[checkRow][checkCol] {
                if piece.PieceColor != PieceColor {
                    result.append([checkRow, checkCol])
                }
                break
            } else {
                result.append([checkRow, checkCol])
            }
            checkRow -= 1
            checkCol -= 1
        }
        
        
        return result
    }
    
    
}
