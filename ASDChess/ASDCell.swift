import Foundation


public struct ASDCell {
    var x = 1
    var y = 1
    
    public init? (cellString: String) {
        if (count(cellString) != 2) { return nil }
        let colString: String = cellString[0]
        let rowString: String = cellString[1]
        
    }
    
    public init? (x: Int, y: Int) {
        if !checkRange(x) { return nil }
        if !checkRange(y) { return nil }
        self.x = x
        self.y = y
    }
    
    private func checkRange(n: Int) -> Bool {
        return 1 <= n && n <= 8
    }
    
    var cellSet: ASDCellSet {
        return ASDCellSet()
    }
}
