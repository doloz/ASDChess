//
//  StringSubscript.swift
//  ASDChess
//
//  Created by Alex on 24.08.15.
//  Copyright (c) 2015 Alex. All rights reserved.
//

import Foundation

extension String {

  subscript (i: Int) -> Character {
    return self[advance(self.startIndex, i)]
  }

  subscript (i: Int) -> String {
    return String(self[i] as Character)
  }

  subscript (r: Range<Int>) -> String {
    return substringWithRange(Range(start: advance(startIndex, r.startIndex), end: advance(startIndex, r.endIndex)))
  }
}