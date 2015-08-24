//
//  ViewController.swift
//  ASDChess
//
//  Created by Alex on 24.08.15.
//  Copyright (c) 2015 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let cell: ASDCell = "e2"
        println(cell.cellSet)
        let f3: ASDCell = "f3"
        let set = ASDCellSet(startingCell: cell, directions: ASDPiece.Queen.directions, longRanged: false, unincludableObstacles: ASDCellSet(cell: "d2"))

        
        
        println(set)
        
        var field = ASDField.initial
        var cp = ASDColoredPiece(piece: .Pawn, color: .Black)
        field["e2"] = cp
        field["e4"] = ASDColoredPiece(piece: .Queen, color: .White)
        println(field)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

