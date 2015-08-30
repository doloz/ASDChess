//
//  ASDColor.swift
//  ASDChess
//
//  Created by Alex on 24.08.15.
//  Copyright (c) 2015 Alex. All rights reserved.
//

import Foundation

/** Represents white and black color of pieces */
public enum ASDColor {
    case White, Black
    
    /** Opposite color */
    public var opposite: ASDColor {
        return self == .White ? .Black : .White
    }
    
    public var pawnYDirection: Int {
        let dy: Int
        switch self {
            case .White: dy = +1
            case .Black: dy = -1
        }
        return dy
    }
    
    public var pawnAttackDirections: ASDDirections {
        let dy = pawnYDirection
        return [(1, dy), (-1, dy)]
    }
    
    public var pawnMoveDirections: ASDDirections {
       let dy = pawnYDirection
       return [(0, dy), (0, 2*dy)]
    }
    
    public var rowIndexForPieces: Int {
        return self == .White ? 1 : 8
    }
    
    public var rowIndexForPawns: Int {
        return rowIndexForPieces + pawnYDirection
    }
}
