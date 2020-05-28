//
//  Rook.swift
//  Chessro
//
//  Created by Stone Zhu on 5/18/20.
//  Copyright © 2020 Stone Zhu. All rights reserved.
//

import Foundation
import RealityKit

class Rook: ChessPiece{
    
    var row: Int
          
    var column: Int
          
    var PieceColor: color
    
    var type: pieceType
    
    var killed: Bool
    
    var ARObject: Entity
    
    var firstMove = true
    
    init(setColor: color, r_pos: Int, c_pos: Int) {
        self.PieceColor = setColor
        self.type = .rook
        self.killed = false
        self.ARObject = Entity()
        self.row = r_pos
        self.column = c_pos
    }
    
    func validStep(chessBoard: ChessBoard) -> Array<SIMD2<Int>>{
        var result: Array<SIMD2<Int>> = []
        
        // Goes up
        var checkRow = self.row + 1
        while checkRow < 8 {
            if let piece = chessBoard.ChessBoard[checkRow][column] {
                if piece.PieceColor != PieceColor {
                    result.append([checkRow, column])
                }
                break
            } else {
                result.append([checkRow, column])
            }
            checkRow += 1
        }
        
        // Goes down
        checkRow = self.row - 1
        while checkRow >= 0 {
            if let piece = chessBoard.ChessBoard[checkRow][column] {
                if piece.PieceColor != PieceColor {
                    result.append([checkRow, column])
                }
                break
            } else {
                result.append([checkRow, column])
            }
            checkRow -= 1
        }
        
        // Goes right
        var checkCol = self.column + 1
        while checkCol < 8 {
            if let piece = chessBoard.ChessBoard[row][checkCol] {
                if piece.PieceColor != PieceColor {
                    result.append([row, checkCol])
                }
                break
            } else {
                result.append([row, checkCol])
            }
            checkCol += 1
        }
        
        // Goes left
        checkCol = self.column - 1
        while checkCol >= 0 {
            if let piece = chessBoard.ChessBoard[row][checkCol] {
                if piece.PieceColor != PieceColor {
                    result.append([row, checkCol])
                }
                break
            } else {
                result.append([row, checkCol])
            }
            checkCol -= 1
        }
        
        return result
        
    }
    
    
}
