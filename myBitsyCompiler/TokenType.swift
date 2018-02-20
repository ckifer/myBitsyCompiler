//
//  TokenType.swift
//  myBitsyCompiler
//
//  Created by Coltin Kifer on 2/15/18.
//  Copyright © 2018 Coltin Kifer. All rights reserved.
//

import Foundation

// TOKEN TYPE
enum TokenType: String {
    case whitespace
    case variable
    
    case integer
    case comment
    
    case leftParen = "("
    case rightParen = ")"
    
    case plus = "+"
    case minus = "-"
    case multiply = "*"
    case divide = "/"
    case modulus = "%"
    case assignment = "="
    case begin = "BEGIN"
    case end = "END"
    case ifP = "IFP"
    case ifZ = "IFZ"
    case ifN = "IFN"
    case elseKey = "ELSE"
    case loop = "LOOP"
    case breakKey = "BREAK"
    case print = "PRINT"
    case read = "READ"
}


extension TokenType {
    /**
     * All `TokenType`s which are considered Bitsy operators
     */
    static var operators: [TokenType] = [.plus, .minus, .multiply, .divide, .modulus, .assignment]
}
