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
        
        performMoveChain(["e2", "e4", "e7", "e6", "e4", "e5", "d7", "d5"])
    }


    @IBAction func performPresses(sender: AnyObject) {
        var move = ASDMove(from: ASDCell(cellString: fromField.text)!, to: ASDCell(cellString: toField.text)!)

        let newPosition = position.performMove(move)
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
    
    func performMoveChain(chain:[String]) {
        for var i = 0; i < chain.count; i = i + 2 {
            let fromString = chain[i]
            let toString = chain[i + 1]
            let move = ASDMove(from: ASDCell(cellString: fromString)!, to: ASDCell(cellString: toString)!, pawnPromotionPiece: .Queen)
            position = position.performMove(move)!
            appendText("\(move)")
            appendText("\(position.field)")
            
        }
    }

    @IBOutlet weak var toField: UITextField!
    
    @IBOutlet weak var fromField: UITextField!
    
    @IBOutlet weak var textView: UITextView!
}

