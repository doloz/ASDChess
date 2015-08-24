import Foundation


public struct ASDCellSet: Printable, Equatable {
    public private(set) var storage: UInt64 = 0
    
    public static let empty = ASDCellSet()
    
    private func transform2dTo1d(x: Int, _ y: Int) -> Int {
        return (x - 1) * 8 + (y - 1)
    }
    
    private func transform1dTo2d(n: Int) -> (x: Int, y: Int) {
        let x = (n / 8) + 1
        let y = (n % 8) + 1
        return (x, y)
    }
    
    public func intersects(other: ASDCellSet) -> Bool {
        return (self & other).storage != 0
    }
    
    public func contains(cell: ASDCell) -> Bool {
        return self.intersects(ASDCellSet(cell: cell))
    }
    
    private init(storage: UInt64) {
        self.storage = storage
    }
    
    public init() {
        self.storage = 0
    }
    
    public init(cell: ASDCell) {
        let n = transform2dTo1d(cell.x, cell.y)
        storage = UInt64(1 << n)
    }
    
    public init(startingCell: ASDCell, directions: ASDDirections, longRanged: Bool, includableObstacles: ASDCellSet = ASDCellSet.empty, unincludableObstacles: ASDCellSet = ASDCellSet.empty) {
        assert(!includableObstacles.intersects(unincludableObstacles), "Includable and unincludable obstacles must not intersect")
        let iterations = longRanged ? 7 : 1
        var result = ASDCellSet()
        for direction in directions {
            for i in 1...iterations {
                if let cell = ASDCell(x: startingCell.x + i * direction.dx, y: startingCell.y + i * direction.dy) {
                    let cellSet = ASDCellSet(cell: cell)
                    if cellSet.intersects(includableObstacles) {
                        result = result | cellSet
                        break
                    } else if cellSet.intersects(unincludableObstacles) {
                        break
                    } else {
                        result = result | cellSet
                    }
                } else {
                    break
                }
                
            }
            
        }
        storage = result.storage
    }
    
    public var description: String {
        var result = "\n"
        let storageCopy = storage
        for i in 0..<64 {
            let (x, y) = transform1dTo2d(i)
            
        }
        
        for i in 1...8 {
            let y = 9 - i
            var next = "\(y) "
            for x in 1...8 {
                let n = transform2dTo1d(x, y)
                let one: UInt64 = 1
                let shifted: UInt64 = storage >> UInt64(n)
                let empty = shifted & one == 0
                let nextSymbol = empty ? "○" : "★"
                next += nextSymbol
            }
            result = result + next + "\n"
        }
        result += "  abcdefgh"
        return result
    }
}

public func == (lhs: ASDCellSet, rhs: ASDCellSet) -> Bool {
    return lhs.storage == rhs.storage
}

public func | (lhs: ASDCellSet, rhs: ASDCellSet) -> ASDCellSet {
    return ASDCellSet(storage: lhs.storage | rhs.storage)
}

public func & (lhs: ASDCellSet, rhs: ASDCellSet) -> ASDCellSet {
    return ASDCellSet(storage: lhs.storage & rhs.storage)
}



