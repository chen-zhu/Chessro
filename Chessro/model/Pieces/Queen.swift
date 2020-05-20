//
//  Queen.swift
//  Chessro
//
//  Created by Stone Zhu on 5/18/20.
//  Copyright © 2020 Stone Zhu. All rights reserved.
//

import Foundation
import RealityKit

class Queen: ChessPiece{
    var row: Int
    
    var column: Int
    
    var PieceColor: color
    
    var type: pieceType
    
    var killed: Bool
    
    var ARObject: Entity
    
    init(setColor: color, r_pos: Int, c_pos: Int) {
        self.PieceColor = setColor
        self.type = .queen
        self.killed = false
        self.ARObject = Entity()
        self.row = r_pos
        self.column = c_pos
    }
    
    /**
     Queen combines the power of Rook and Bishop
     */
    func validStep(chessBoard: ChessBoard) -> Array<SIMD2<Int>>{
        var result: Array<SIMD2<Int>> = []
        
        /**
         Rook pattern: 
         */
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
        
        
        /**
         Bishop Pattern
         */
        
        // Goes to top-left
        checkRow = row + 1
        checkCol = column - 1
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
