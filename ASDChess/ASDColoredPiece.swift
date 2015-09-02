import Foundation

public struct ASDColoredPiece: Printable, Equatable {
    var piece: ASDPiece
    var color: ASDColor
    
    public init(piece: ASDPiece, color: ASDColor) {
        self.piece = piece
        self.color = color
    }
    
    public var description: String {
        let blackPieces = "♟♞♝♜♛♚"
        let whitePieces = "♙♘♗♖♕♔"
        let raw = piece.rawValue
        let pieces = color == .White ?
            whitePieces : blackPieces
        return pieces[raw]
    }
    
    public var attackDirections: ASDDirections {
        if piece != .Pawn {
            return piece.directions
        } else {
            return color.pawnAttackDirections
        }
    }
    
    public func possibleCellsToMoveFromCell(cell: ASDCell) -> ASDCellSet {
        var result = ASDCellSet()
        var directions: ASDDirections
        let attackDirections = self.attackDirections
        switch self.piece {
            case .Pawn:
                var pawnMoveDirections = cell.y == self.color.rowIndexForPawns ? self.color.pawnMoveDirections :
                    [self.color.pawnMoveDirections.first!]
                directions = attackDirections + pawnMoveDirections
            case .King:
                var kingCastlingDirections = cell.y == self.color.rowIndexForPieces ? [(dx: -2, dy: 0), (dx: 2, dy: 0)] : []
                directions = attackDirections + kingCastlingDirections
            default:
                directions = attackDirections
        }
        return ASDCellSet(startingCell: cell, directions: directions, longRanged: piece.isLongRanged, obstacles: ASDCellSet.empty)
    }
}

public func == (lhs: ASDColoredPiece, rhs: ASDColoredPiece) -> Bool {
    return lhs.piece == rhs.piece && lhs.color == rhs.color
}