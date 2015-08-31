//
//  ViewController.swift
//  ASDChess
//
//  Created by Alex on 24.08.15.
//  Copyright (c) 2015 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var position = ASDPosition()
    override func viewDidLoad() {
        super.viewDidLoad()
        let cell: ASDCell = "e2"
        println(cell.cellSet)
        let f3: ASDCell = "f3"
        let set = ASDCellSet(startingCell: cell, directions: ASDPiece.Queen.directions, longRanged: false, unincludableObstacles: ASDCellSet(cell: "d2"))

        
        
        println(set)
        
        var field = ASDField.initial
        field["e4"] = field["e2"]!
        field["e2"] = nil
        var cp = ASDColoredPiece(piece: .Pawn, color: .Black)
        let attacked = field.cellsAttackedByColor(.White)
        println(attacked)
        println(field)
    }


    @IBAction func performPresses(sender: AnyObject) {
        var move = ASDMove(from: ASDCell(cellString: fromField.text)!, to: ASDCell(cellString: toField.text)!)

        let (newPosition, result) = position.performMove(move)
        if (newPosition != nil) {
            position = newPosition!
            appendText("\(move)")
            appendText("\(newPosition!.field)")
            
        } else {
            appendText("Incorrect move")
        }
        
        var lastRange = NSRange()
            lastRange.location = (textView.text as NSString).length
            lastRange.length = 1;
            textView.scrollRangeToVisible(lastRange)
        view.endEditing(true)
    }
    
    func appendText(text: String) {
        textView.text = textView.text + text + "\n"
    }

    @IBOutlet weak var toField: UITextField!
    
    @IBOutlet weak var fromField: UITextField!
    
    @IBOutlet weak var textView: UITextView!
}

