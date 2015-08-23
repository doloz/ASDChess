//
//  ASDPiece.swift
//  ASDChess
//
//  Created by Alex on 24.08.15.
//  Copyright (c) 2015 Alex. All rights reserved.
//

import Foundation

/** Represents piece on chess board (without respect to color) */
public enum ASDPiece {
    case Pawn, Knight, Bishop, Rook, Queen, King
    
    /** Can pawn be promoted to this piece? */
    public var isPromotable: Bool {
        switch self {
            case .Pawn, .King: return false
            default: return true
        }
    }
}