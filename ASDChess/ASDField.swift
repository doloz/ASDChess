//
//  ASDField.swift
//  ASDChess
//
//  Created by Alex on 24.08.15.
//  Copyright (c) 2015 Alex. All rights reserved.
//

import Foundation

public struct ASDField: Printable {
    public var field: [ASDCell : ASDColoredPiece] = [:]
    
    public subscript(cell: ASDCell) -> ASDColoredPiece? {
        get {
            return field[cell]
        }
        
        set(newValue) {
            field[cell] = newValue
        }
    }
    
    public var description: String {
        let result = boardString { (cell) -> (String) in
            if let cp = self.field[cell] {
                return "\(cp)"
            } else {
                return "."
            }
        }
        return result
    }
}