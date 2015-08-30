//
//  ASDMove.swift
//  ASDChess
//
//  Created by Alex on 26.08.15.
//  Copyright (c) 2015 Alex. All rights reserved.
//

import Foundation

public struct ASDMove: Printable {
    public let from: ASDCell
    public let to: ASDCell
    public let pawnPromotionPiece: ASDPiece?
    
    public var delta: ASDDirection {
        return (to.x - from.x, to.y - from.y)
    }
    
    public var distance: Int {
        let delta = self.delta
        return max(abs(delta.dx), abs(delta.dy))
    }
    
    public var description: String {
        var result = "\(from)-\(to)"
        if pawnPromotionPiece != nil {
            result += "(\(pawnPromotionPiece))"
        }
        return result
    }
}