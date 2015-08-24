import Foundation

/** Represents cell on chess board */
public struct ASDCell: Printable {
    var x: Int = 1
    var y: Int = 1
    
    public init? (cellString: String) {
        if (count(cellString) != 2) { return nil }
        let colString: String = cellString[0]
        let rowString: String = cellString[1]
        
        let allCols = "abcdefgh" as NSString
        let location = allCols.rangeOfString(colString).location
        let x = location + 1
        let y = (rowString as NSString).integerValue
        if !setIfValid(x: x, y: y) { return nil }
    }
    
    public init? (x: Int, y: Int) {
        if !setIfValid(x: x, y: y) { return nil }
    }
    
    private mutating func setIfValid(#x: Int, y: Int) -> Bool {
        if !checkRange(x) { return false }
        if !checkRange(y) { return false }
        self.x = x
        self.y = y
        return true
    }
    
    private func checkRange(n: Int) -> Bool {
        return 1 <= n && n <= 8
    }
    
    var cellSet: ASDCellSet {
        return ASDCellSet()
    }
    
    public var description: String {
        let allCols = "abcdefgh"
        return allCols[x - 1] + "\(y)"
    }
}
