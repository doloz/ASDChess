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
        let cell = ASDCell(cellString: "d2")!
        let otherCell = ASDCell(x: 4, y: 3)
        println(cell.x, cell.y)
        println(cell)
        println(cell == otherCell)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

