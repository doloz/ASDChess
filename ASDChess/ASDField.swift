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
    
    public static let initial = { () -> (ASDField) in
        var f = ASDField()
        for i in 1...8 {
            f[ASDCell(x: i, y: 2)!] = ASDColoredPiece(piece: .Pawn, color: .White)
            f[ASDCell(x: i, y: 7)!] = ASDColoredPiece(piece: .Pawn, color: .Black)
        }
        let pieces: [ASDPiece] = [.Rook, .Knight, .Bishop, .Queen, .King, .Bishop, .Knight, .Rook]
        for i in 1...8 {
            let piece = pieces[i - 1]
            f[ASDCell(x: i, y: 1)!] = ASDColoredPiece(piece: piece, color: .White)
            f[ASDCell(x: i, y: 8)!] = ASDColoredPiece(piece: piece, color: .Black)
        }
        return f
    }()
    
}