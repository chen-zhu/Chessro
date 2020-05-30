//
//  ChessBoard.swift
//  Chessro
//
//  Created by Stone Zhu on 5/18/20.
//  Copyright © 2020 Stone Zhu. All rights reserved.
//

import Foundation

/**
    Board Layout:
    
        a  b  c  d  e  f  g  h
        1  2  3  4  5  6  7  8
     8           BLACK
     7
     6
     5
     4
     3
     2
     1           WHITE
     
 */
class ChessBoard{
    //var ChessBoard: [(String, Int)] = [("a", 8), ("b", 8)]
    var ChessBoard: [[ChessPiece?]] = []
    
    init() {
        for i in 0...7 {
            ChessBoard.append( [] )
            for _ in 0...7 {
                ChessBoard[i].append(nil)
            }
        }
        
        loadBoard()
    }
    
    /**
     TODO: Mak it also handle the situation when enemy is killed
     */
    func changeChessPieceIndex(old_row: Int, old_col: Int, new_row: Int, new_col: Int){
        self.ChessBoard[new_row][new_col] = self.ChessBoard[old_row][old_col]
        self.ChessBoard[old_row][old_col] = nil
        
        print("Chessboard Old Position: ", old_row, old_col, self.ChessBoard[old_row][old_col])
        print("Chessboard New Position: ", new_row, new_col, self.ChessBoard[new_row][new_col])
    }
    
    
    func loadBoard(){
        //WHITE
        self.ChessBoard[0][0] = Rook(    setColor: .white, r_pos: 0, c_pos: 0);
        self.ChessBoard[0][1] = Knight(  setColor: .white, r_pos: 0, c_pos: 1);
        self.ChessBoard[0][2] = Bishop(  setColor: .white, r_pos: 0, c_pos: 2);
        self.ChessBoard[0][3] = Queen(   setColor: .white, r_pos: 0, c_pos: 3);
        self.ChessBoard[0][4] = King(    setColor: .white, r_pos: 0, c_pos: 4);
        self.ChessBoard[0][5] = Bishop(  setColor: .white, r_pos: 0, c_pos: 5);
        self.ChessBoard[0][6] = Knight(  setColor: .white, r_pos: 0, c_pos: 6);
        self.ChessBoard[0][7] = Rook(    setColor: .white, r_pos: 0, c_pos: 7);
        
        //WHITE Pawns
        self.ChessBoard[1][0] = Pawn(    setColor: .white, r_pos: 1, c_pos: 0);
        self.ChessBoard[1][1] = Pawn(    setColor: .white, r_pos: 1, c_pos: 1);
        self.ChessBoard[1][2] = Pawn(    setColor: .white, r_pos: 1, c_pos: 2);
        self.ChessBoard[1][3] = Pawn(    setColor: .white, r_pos: 1, c_pos: 3);
        self.ChessBoard[1][4] = Pawn(    setColor: .white, r_pos: 1, c_pos: 4);
        self.ChessBoard[1][5] = Pawn(    setColor: .white, r_pos: 1, c_pos: 5);
        self.ChessBoard[1][6] = Pawn(    setColor: .white, r_pos: 1, c_pos: 6);
        self.ChessBoard[1][7] = Pawn(    setColor: .white, r_pos: 1, c_pos: 7);
        
        //BLACK
        self.ChessBoard[7][0] = Rook(    setColor: .black, r_pos: 7, c_pos: 0);
        self.ChessBoard[7][1] = Knight(  setColor: .black, r_pos: 7, c_pos: 1);
        self.ChessBoard[7][2] = Bishop(  setColor: .black, r_pos: 7, c_pos: 2);
        self.ChessBoard[7][3] = Queen(   setColor: .black, r_pos: 7, c_pos: 3);
        self.ChessBoard[7][4] = King(    setColor: .black, r_pos: 7, c_pos: 4);
        self.ChessBoard[7][5] = Bishop(  setColor: .black, r_pos: 7, c_pos: 5);
        self.ChessBoard[7][6] = Knight(  setColor: .black, r_pos: 7, c_pos: 6);
        self.ChessBoard[7][7] = Rook(    setColor: .black, r_pos: 7, c_pos: 7);
        
        //BLACK Pawns
        self.ChessBoard[6][0] = Pawn(    setColor: .black, r_pos: 6, c_pos: 0);
        self.ChessBoard[6][1] = Pawn(    setColor: .black, r_pos: 6, c_pos: 1);
        self.ChessBoard[6][2] = Pawn(    setColor: .black, r_pos: 6, c_pos: 2);
        self.ChessBoard[6][3] = Pawn(    setColor: .black, r_pos: 6, c_pos: 3);
        self.ChessBoard[6][4] = Pawn(    setColor: .black, r_pos: 6, c_pos: 4);
        self.ChessBoard[6][5] = Pawn(    setColor: .black, r_pos: 6, c_pos: 5);
        self.ChessBoard[6][6] = Pawn(    setColor: .black, r_pos: 6, c_pos: 6);
        self.ChessBoard[6][7] = Pawn(    setColor: .black, r_pos: 6, c_pos: 7);
        
        for i in 2...5 {
            for t in 0...7 {
                ChessBoard[i][t] = nil;
            }
        }
    }
    
    
    
}


