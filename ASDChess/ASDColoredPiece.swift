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
}

public func == (lhs: ASDColoredPiece, rhs: ASDColoredPiece) -> Bool {
    return lhs.piece == rhs.piece && lhs.color == rhs.color
}