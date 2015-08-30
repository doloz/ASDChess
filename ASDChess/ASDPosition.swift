//
//  ASDPosition.swift
//  ASDChess
//
//  Created by Alex on 26.08.15.
//  Copyright (c) 2015 Alex. All rights reserved.
//

import Foundation

public struct ASDPosition {
    public var turn = ASDColor.White
    public var castlingRights: [ASDColor : [Bool]] = [
        .White : [true, true],
        .Black : [true, true]
    ]
    public var enPassantPawn: ASDCell? = nil
    public var field: ASDField = ASDField.initial
    
//    public init() {}
    
    public func canMakeMove(move: ASDMove) -> Bool {
        return false
    }
    
    private func performMoveUnsafely(move: ASDMove) -> (ASDPosition?, ASDMoveResult) {
        let impossible: (ASDPosition?, ASDMoveResult) = (nil, .Impossible)
        if move.to == move.from { return impossible }
        if field[move.from] == nil { return impossible }
        let coloredPiece = field[move.from]!
        var hasTarget = false
        if let targetColoredPiece = field[move.to] {
            if targetColoredPiece.color == coloredPiece.color {
                return impossible
            }
            hasTarget = true
        }

        let piece = coloredPiece.piece
        let color = coloredPiece.color
        var newPosition = ASDPosition()
        newPosition.turn = turn.opposite
        newPosition.field = field
        newPosition.castlingRights = castlingRights
        newPosition.enPassantPawn = nil
        if piece.isRegular {
            let result = newPosition.performRegularMove(move)
            if result.isCompleted {
                return (newPosition, result)
            } else {
                return (nil, result)
            }
        } else {
            if piece == .King {
                switch move.distance {
                    case 1:
                        let result = newPosition.performRegularMove(move)
                        if result.isCompleted {
                            newPosition.forbidCastlingForColor(color)
                            return (newPosition, result)
                        } else {
                            return (nil, result)
                        }
                    case 2:
                        let result = newPosition.performCastling(coloredPiece.color, sign: move.delta.dx)
                        if result.isCompleted {
                            newPosition.forbidCastlingForColor(color)
                            return (newPosition, result)
                        } else {
                            return (nil, result)
                        }
                    default: return impossible
                }
                
            } else {
                // Pawn
            }
        }
        
        // TODO: Отслеживать ходы ладьи
        return (newPosition, .Completed)
    }
    
    private mutating func performRegularMove(move: ASDMove) -> ASDMoveResult {
        if field.cellsAttackedByPieceAtCell(move.from).contains(move.to) {
            field[move.to] = field[move.from]!
            field[move.from] = nil
            return .Completed
        } else {
            return .Impossible
        }
    }
    
    private mutating func performCastling(color: ASDColor, sign: Int) -> ASDMoveResult {
        let step = sign < 0 ? -1 : 1
        let x = sign < 0 ? 1 : 8
        let y = color == .White ? 1 : 8
        let castlingIndex = sign < 0 ? 0 : 1
        let castlingRight = (castlingRights[color]!)[castlingIndex]
        if !castlingRight {
            return .ForbiddenCastling
        }
        let rookCell = ASDCell(x: x, y: y)!
        let kingCell = ASDCell(x: 5, y: y)!
        if field[rookCell] != ASDColoredPiece(piece: .Rook, color: color) || field[kingCell] != ASDColoredPiece(piece: .King, color: color) {
            return .Impossible
        }
        
        field[rookCell] = nil
        field[kingCell] = nil
        // TODO: Добавить проверку на шах и на то, чтобы между королем и ладьей не было фигур
        let directionForRook: ASDDirection = (dx: step, dy: 0)
        let directionForKing: ASDDirection = (dx: 2*step, dy: 0)
        let newCellForRook = kingCell.move(directionForRook)!
        let newCellForKing = kingCell.move(directionForKing)!
        
        let otherColor = color.opposite
        if field.isCellUnderAttack(kingCell, byColor: otherColor) ||
            field.isCellUnderAttack(newCellForRook, byColor: otherColor) ||
            field.isCellUnderAttack(newCellForKing, byColor: otherColor) ||
            field[newCellForKing] != nil ||
            field[newCellForRook] != nil {
            return .Impossible
        }
        
        field[newCellForKing] = ASDColoredPiece(piece: .King, color: color)
        field[newCellForRook] = ASDColoredPiece(piece: .Rook, color: color)
        return .Completed
    }
    
    private mutating func forbidCastlingForColor(color: ASDColor) {
        castlingRights[color] = [false, false]
    }
    
    public func performMove(move: ASDMove) -> (ASDPosition?, ASDMoveResult) {
        let impossible: (ASDPosition?, ASDMoveResult) = (nil, .Impossible)
        if move.to == move.from { return impossible }
        if field[move.from] == nil { return impossible }
        let coloredPiece = field[move.from]!
        var hasTarget = false
        if let targetColoredPiece = field[move.to] {
            if targetColoredPiece.color == coloredPiece.color {
                return impossible
            }
            hasTarget = true
        }
        if coloredPiece.color != turn { return impossible }
        
        let moveType: ASDMoveType
        
        let piece = coloredPiece.piece
        
        switch piece {
            case .Pawn:
                if hasTarget {
                    moveType = .Regular
                } else {
                
                }
            default: moveType = .Regular
        }
        switch move {
//            case let m where m.
            default: return impossible
        }
    }
    
    
}