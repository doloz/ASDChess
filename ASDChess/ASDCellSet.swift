import Foundation

public struct ASDCellSet {
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
    
    
}