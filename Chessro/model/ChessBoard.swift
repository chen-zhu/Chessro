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
        loadBoard()
    }
    
    //TODO: figure out a way to map ARKit board to the ChessBoard!
    
    
    func loadBoard(){
        //WHITE
        ChessBoard[0][0] = Rook(    setColor: .white, h_po: 0, v_po: 0);
        ChessBoard[0][1] = Knight(  setColor: .white, h_po: 0, v_po: 1);
        ChessBoard[0][2] = Bishop(  setColor: .white, h_po: 0, v_po: 2);
        ChessBoard[0][3] = Queen(   setColor: .white, h_po: 0, v_po: 3);
        ChessBoard[0][4] = King(    setColor: .white, h_po: 0, v_po: 4);
        ChessBoard[0][5] = Bishop(  setColor: .white, h_po: 0, v_po: 5);
        ChessBoard[0][6] = Knight(  setColor: .white, h_po: 0, v_po: 6);
        ChessBoard[0][7] = Rook(    setColor: .white, h_po: 0, v_po: 7);
        
        //WHITE Pawns
        ChessBoard[1][0] = Pawn(    setColor: .white, h_po: 1, v_po: 0);
        ChessBoard[1][1] = Pawn(    setColor: .white, h_po: 1, v_po: 1);
        ChessBoard[1][2] = Pawn(    setColor: .white, h_po: 1, v_po: 2);
        ChessBoard[1][3] = Pawn(    setColor: .white, h_po: 1, v_po: 3);
        ChessBoard[1][4] = Pawn(    setColor: .white, h_po: 1, v_po: 4);
        ChessBoard[1][5] = Pawn(    setColor: .white, h_po: 1, v_po: 5);
        ChessBoard[1][6] = Pawn(    setColor: .white, h_po: 1, v_po: 6);
        ChessBoard[1][7] = Pawn(    setColor: .white, h_po: 1, v_po: 7);
        
        //BLACK
        ChessBoard[7][0] = Rook(    setColor: .black, h_po: 7, v_po: 0);
        ChessBoard[7][1] = Knight(  setColor: .black, h_po: 7, v_po: 1);
        ChessBoard[7][2] = Bishop(  setColor: .black, h_po: 7, v_po: 2);
        ChessBoard[7][3] = Queen(   setColor: .black, h_po: 7, v_po: 3);
        ChessBoard[7][4] = King(    setColor: .black, h_po: 7, v_po: 4);
        ChessBoard[7][5] = Bishop(  setColor: .black, h_po: 7, v_po: 5);
        ChessBoard[7][6] = Knight(  setColor: .black, h_po: 7, v_po: 6);
        ChessBoard[7][7] = Rook(    setColor: .black, h_po: 7, v_po: 7);
        
        //BLACK Pawns
        ChessBoard[6][0] = Pawn(    setColor: .black, h_po: 6, v_po: 0);
        ChessBoard[6][1] = Pawn(    setColor: .black, h_po: 6, v_po: 1);
        ChessBoard[6][2] = Pawn(    setColor: .black, h_po: 6, v_po: 2);
        ChessBoard[6][3] = Pawn(    setColor: .black, h_po: 6, v_po: 3);
        ChessBoard[6][4] = Pawn(    setColor: .black, h_po: 6, v_po: 4);
        ChessBoard[6][5] = Pawn(    setColor: .black, h_po: 6, v_po: 5);
        ChessBoard[6][6] = Pawn(    setColor: .black, h_po: 6, v_po: 6);
        ChessBoard[6][7] = Pawn(    setColor: .black, h_po: 6, v_po: 7);
        
        for i in 2...5 {
            for t in 0...7 {
                ChessBoard[i][t] = nil;
            }
        }
    }
    
    
    
}


