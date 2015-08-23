//
//  ASDColor.swift
//  ASDChess
//
//  Created by Alex on 24.08.15.
//  Copyright (c) 2015 Alex. All rights reserved.
//

import Foundation

/** Represents white and black color of pieces */
public enum ASDColor {
    case White, Black
    
    /** Opposite color */
    public var opposite: ASDColor {
        return self == .White ? .Black : .White
    }
}
