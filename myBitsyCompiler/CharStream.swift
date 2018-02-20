//
//  CharStream.swift
//  myBitsyCompiler
//
//  Created by Coltin Kifer on 2/16/18.
//  Copyright © 2018 Coltin Kifer. All rights reserved.
//

import Foundation

/**
 * Convenient interface for advancing one Char at a time
 * over a String
 */
struct CharStream {
    fileprivate let string: String
    fileprivate var index: String.Index
    
    /**
     init a char stream
     - paremeter string: string to iterate over
    **/
    init(string: String) {
        self.string = string
        self.index = string.startIndex
    }
    
    // look at the current character
    var current: Character {
        return string[index]
    }
    
    // are there more chacters to the current string?
    var hasMore: Bool {
        return index != string.endIndex
    }
    
    // if there is more in the string advance to next character
    mutating func advance() {
        guard hasMore else { return }
        index = string.index(after: index)
    }

}
