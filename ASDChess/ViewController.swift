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
        let cell = ASDCell(cellString: "e2")!
        println(cell.cellSet)
        let f3 = ASDCell(cellString: "f3")!
        let set = ASDCellSet(startingCell: cell, directions: ASDPiece.Queen.directions, longRanged: false, unincludableObstacles: ASDCellSet(cell: f3))

        
        
        println(set)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

