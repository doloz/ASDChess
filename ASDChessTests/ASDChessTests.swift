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
    
}
