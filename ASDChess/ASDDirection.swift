import Foundation

public enum ASDDirection: Int {
    case Up, UpRight, Right, DownRight,
        Down, DownLeft, Left, UpLeft
    
    func enumerate(callback: (ASDDirection) -> ()) {
        for i in 0..<8 {
            let direction = ASDDirection(rawValue: i)!
            callback(direction)
        }
    }
}