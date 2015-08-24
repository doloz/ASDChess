//
//  ASDPrinter.swift
//  ASDChess
//
//  Created by Alex on 25.08.15.
//  Copyright (c) 2015 Alex. All rights reserved.
//

import Foundation

public func boardString(callback:(ASDCell) -> (String)) -> String {
    var result = "\n"
    for var y = 8; y >= 1; y-- {
        var next = "\(y) "
        for var x = 1; x <= 8; x++ {
            let cell = ASDCell(x: x, y: y)!
            let nextPart = callback(cell)
            next = next + nextPart
        }
        result = result + next + "\n"
    }
    result = result + "  abcdefgh"
    return result
}
