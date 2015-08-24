import Foundation

public struct ASDColoredPiece: Printable {
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
}