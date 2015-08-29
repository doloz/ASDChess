//
//  ASDPosition.swift
//  ASDChess
//
//  Created by Alex on 26.08.15.
//  Copyright (c) 2015 Alex. All rights reserved.
//

import Foundation

public struct ASDPosition {
    public var turn = ASDColor.White
    public var castlingRights: [ASDColor : (Bool, Bool)]
    public var enPassantPawn: ASDCell?
    
    public func performMove(move: ASDMove) -> (ASDPosition?, ASDMoveResult) {
        return (nil, .Completed)

    }
    

}