//
//  ASDMoveResult.swift
//  ASDChess
//
//  Created by Alex on 29.08.15.
//  Copyright (c) 2015 Alex. All rights reserved.
//

import Foundation

public enum ASDMoveResult {
    case Completed, CompletedWithCheckmate, CompletedWithStalemate,  Impossible, ForbiddenCastling, KingIsLeftUnderCheck
    
    public var isCompleted: Bool {
        switch self {
            case .Completed, .CompletedWithCheckmate, .CompletedWithStalemate: return true
            default: return false
        }
    }
}