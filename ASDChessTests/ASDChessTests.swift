//
//  ASDChessTests.swift
//  ASDChessTests
//
//  Created by Alex on 24.08.15.
//  Copyright (c) 2015 Alex. All rights reserved.
//

import UIKit
import Foundation
import XCTest
import ASDChess


class ASDChessTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCell() {
        XCTAssert(ASDCell(x: 10, y: 1) == nil)
        XCTAssert(ASDCell(cellString: "q3") == nil)
        let c1 = ASDCell(cellString: "d2")!
        let c2 = ASDCell(x: 4, y: 2)!
        let c3 = ASDCell(x: 4, y: 3)!
        XCTAssertEqual(c1, c2)
        XCTAssertNotEqual(c1, c3)
    }
    
    func testPiece() {
        XCTAssert(ASDPiece.King.isPromotable == false)
        XCTAssert(ASDPiece.Queen.isPromotable == true)
    }
    
    func testColor() {
        XCTAssert(ASDColor.White.opposite == .Black)
    }
    
    func testDirections() {
        let d1: ASDDirection = (dx: 0, dy: 1)
        let d2: ASDDirection = (dx: 2, dy: -1)
        let c1 = ASDCell(cellString: "e2")!
        let c2 = ASDCell(cellString: "h8")!
        XCTAssert(c1.move(d1) == ASDCell(cellString: "e3"))
        XCTAssert(c1.move(d2) == ASDCell(cellString: "g1"))
        XCTAssert(c2.move(d2) == nil)
    }
    
}
