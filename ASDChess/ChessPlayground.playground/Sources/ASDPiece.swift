//
//  ASDPiece.swift
//  ASDChess
//
//  Created by Alex on 24.08.15.
//  Copyright (c) 2015 Alex. All rights reserved.
//

import Foundation

enum ASDPiece {
    case Pawn, Knight, Bishop, Rook, Queen, King
    var isPromotable: Bool {
        switch self {
            case .Pawn, .King: return false
            default: return true
        }
    }
}
