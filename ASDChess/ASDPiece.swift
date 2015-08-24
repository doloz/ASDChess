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
}
