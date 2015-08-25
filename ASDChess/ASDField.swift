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
    
    public func cellsWithPiecesOfColor(color: ASDColor) -> ASDCellSet {
        var result = ASDCellSet()
        ASDCellSet.full.enumerate { (cell) -> Void in
            if let coloredPiece = self.field[cell] {
                if coloredPiece.color == color {
                    result = result | ASDCellSet(cell: cell)
                }
            } else {
                return
            }
        }
        return result
    }
    
    public func cellsAttackedByColor(color: ASDColor) -> ASDCellSet {
        let cellsWithAttackers = cellsWithPiecesOfColor(color)
        let cellsWithDefenders = cellsWithPiecesOfColor(color.opposite)
        var result = ASDCellSet()
        cellsWithAttackers.enumerate { (cell) -> Void in
            let coloredPiece = self.field[cell]!
            let piece = coloredPiece.piece
            let directions: ASDDirections
            if piece != .Pawn {
                directions = piece.directions
            } else {
                directions = color.pawnAttackDirections
            }
            let attackingCellSet = ASDCellSet(startingCell: cell, directions: directions, longRanged: piece.isLongRanged, includableObstacles: cellsWithDefenders | cellsWithAttackers)
            result = result | attackingCellSet
        }
        return result
    }
    
    public func cell(cell: ASDCell, isUnderAttackByColor color: ASDColor) -> Bool {
        let attackedCells = cellsAttackedByColor(color)
        return attackedCells.contains(cell)
    }
    
    public func find(coloredPiece: ASDColoredPiece) -> ASDCellSet {
        var result = ASDCellSet()
        ASDCellSet.full.enumerate { (cell) -> Void in
            if let otherColoredPiece = self.field[cell] {
                if otherColoredPiece == coloredPiece {
                    result = result | ASDCellSet(cell: cell)
                }
            }
        }
        return result
    }
}