import Foundation

public struct ASDCellSet: Printable {
    public private(set) var storage: UInt64 = 0
    
    private func transform2dTo1d(x: Int, _ y: Int) -> Int {
        return (x - 1) * 8 + (y - 1)
    }
    
    private func transform1dTo2d(n: Int) -> (x: Int, y: Int) {
        let x = (n / 8) + 1
        let y = (n % 8) + 1
        return (x, y)
    }
    
    public init(cell: ASDCell) {
        let n = transform2dTo1d(cell.x, cell.y)
        storage = UInt64(1 << n)
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