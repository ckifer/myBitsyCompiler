//
//  Token.swift
//  myBitsyCompiler
//
//  Created by Coltin Kifer on 2/15/18.
//  Copyright © 2018 Coltin Kifer. All rights reserved.
//

import Foundation


protocol Token {
    var type: TokenType { get }
    
    
    var value: String { get }
}

// One type, arbitrary values

// string that represents an integer
struct Integer: Token {
    let type: TokenType = .variable
    let value: String
}

// represents letters and underscores that is a variable
struct Variable: Token {
    let type: TokenType = .variable
    let value: String
}

// represents a string of whitespace characters
struct Whitespace: Token {
    let type: TokenType = .whitespace
    let value: String
}

// represents characters within a comment block
struct Comment : Token {
    let type: TokenType = .comment
    let value: String
}

// Multiple types, but specific value

// represents a keyword like BEGIN/END etc.
struct Keyword: Token {
    let type: TokenType
    var value: String { return type.rawValue }
    
    init?(string: String) {
        guard let type = TokenType(rawValue: string) else {
            return nil
        }
        self.type = type
    }
}

// represents a left or right parenthesis
struct Paren: Token {
    let type: TokenType
    var value: String { return type.rawValue }
    
    init?(string: String) {
        guard let type = TokenType(rawValue: string) else {
            return nil
        }
        self.type = type
    }
}

// represents  + - * / % operators
struct Operator: Token {
    let type: TokenType
    var value: String { return type.rawValue }
    
    init?(string: String) {
        guard let type = TokenType(rawValue: string) else {
            return nil
        }
        self.type = type
    }
}


