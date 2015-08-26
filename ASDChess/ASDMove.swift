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
    
    public var description: String {
        var result = "\(from)-\(to)"
        if pawnPromotionPiece != nil {
            result += "(\(pawnPromotionPiece))"
        }
        return result
    }
}