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
    
    public func canMakeMove(move: ASDMove) -> Bool {
        let (position, result) = performMoveUnsafely(move)
        if !result.isCompleted {
            return false
        }
        
        if position!.field.isKingUnderCheck(turn) {
            return false
        }
        
        return true
    }
    
    public func performMove(move: ASDMove) -> (ASDPosition?, ASDMoveResult) {
        let (position, result) = performMoveUnsafely(move)
        if !result.isCompleted {
            return (position, result)
        }
        
        if position!.field.isKingUnderCheck(turn) {
            return (nil, .KingIsLeftUnderCheck)
        }
        
        return (position, .Completed)
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
                let result: ASDMoveResult
                if move.distance == 1 {
                    result = newPosition.performRegularMove(move)
                } else if move.distance == 2 {
                    result = newPosition.performCastling(coloredPiece.color, sign: move.delta.dx)
                } else {
                    return impossible
                }
                
                if result.isCompleted {
                    return (newPosition, result)
                } else {
                    return (nil, result)
                }
                
            } else {
                let delta = move.delta
                let pawnYDirection = color.pawnYDirection
                if delta.dx == 0 {
                    if delta.dy != pawnYDirection && delta.dy != 2*pawnYDirection {
                        return impossible
                    }
                    
                    if move.from.y != color.rowIndexForPawns && abs(delta.dy) == 2 {
                        return impossible
                    }
                    var y = move.from.y
                    do {
                        y = y + pawnYDirection
                        let cell = ASDCell(x: move.from.x, y: y)!
                        if field[cell] != nil {
                            return impossible
                        }
                    } while y != move.to.y
                    
                    if abs(delta.dy) == 2 {
                        newPosition.enPassantPawn = move.to
                    }
                } else if abs(delta.dx) == 1 {
                    if delta.dy != pawnYDirection {
                        return impossible
                    }
                    
                    if field[move.to] == nil {
                        if let enPassant = enPassantPawn {
                            if enPassant.move((dx: 0, dy: pawnYDirection))! == move.to {
                                newPosition.performEnPassantCapture(move)
                                return (newPosition, .Completed)
                            } else {
                                return impossible
                            }
                        } else {
                            return impossible
                        }
                    }
                    
                    let targetPiece = field[move.to]!
                    if targetPiece.color == color {
                        return impossible
                    }
                    
                    
                } else {
                    return impossible
                }
                
                newPosition.performRegularMove(move, check: false)
            }
        }
        return (newPosition, .Completed)
    }
    
    private mutating func performRegularMove(move: ASDMove, check: Bool = true) -> ASDMoveResult {
        if !field.cellsAttackedByPieceAtCell(move.from).contains(move.to) {
            if check {
                return .Impossible
            }
        }
        let coloredPiece = field[move.from]!
        field[move.from] = nil
        if coloredPiece.piece == .Pawn && move.to.y == coloredPiece.color.opposite.rowIndexForPieces {
            let newPiece = move.pawnPromotionPiece ?? .Queen
            field[move.to] = ASDColoredPiece(piece: newPiece, color: coloredPiece.color)
        } else {
            field[move.to] = coloredPiece
        }
        
        updateCastlingRights()
        return .Completed
    }
    
    private mutating func performEnPassantCapture(move: ASDMove) {
        let enPassant = enPassantPawn!
        let pawn = field[move.from]!
        field[move.from] = nil
        field[enPassant] = nil
        field[move.to] = pawn
    }
    
    private mutating func updateCastlingRights() {
        let possibleWhiteCastlings = field.possibleCastlingsForColor(.White)
        let possibleBlackCastlings = field.possibleCastlingsForColor(.Black)
        for i in 0...1 {
            castlingRights[.White]![i] = castlingRights[.White]![i] && possibleWhiteCastlings[i]
            castlingRights[.Black]![i] = castlingRights[.Black]![i] && possibleBlackCastlings[i]
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
        forbidCastlingForColor(color)
        return .Completed
    }
    
    private mutating func forbidCastlingForColor(color: ASDColor) {
        castlingRights[color] = [false, false]
    }
}