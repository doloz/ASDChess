//
//  ASDPiece.swift
//  ASDChess
//
//  Created by Alex on 24.08.15.
//  Copyright (c) 2015 Alex. All rights reserved.
//

import Foundation

public enum ASDPiece: Int, Printable {
    case Pawn, Knight, Bishop, Rook, Queen, King
    public var isPromotable: Bool {
        switch self {
            case .Pawn, .King: return false
            default: return true
        }
    }
    
    public var description: String {
        let piecesString = "♟♞♝♜♛♚"
        let raw = self.rawValue
        return piecesString[raw]
    }
    
    public typealias ASDDirections = [(dx: Int, dy: Int)]
    
    public var directions: ASDDirections {
        let bishopDirections: ASDDirections = [(1, 1), (1, -1), (-1, 1), (-1, -1)]
        let rookDirections: ASDDirections = [(1, 0), (-1, 0), (0, 1), (0, -1)]
        let queenDirections = bishopDirections + rookDirections
        
        switch self {
            case .Knight:
                return [
                    (2, 1), (2, -1), (-2, 1), (-2, -1),
                    (1, 2), (1, -2), (-1, 2), (-1, -2)
                ]
            case .Bishop: return bishopDirections
            case .Rook: return rookDirections
            case .Queen, .King: return queenDirections
            
            case .Pawn: return []
        }
    }
}
