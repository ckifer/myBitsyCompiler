//
//  Tokenizer.swift
//  myBitsyCompiler
//
//  Created by Coltin Kifer on 2/15/18.
//  Copyright © 2018 Coltin Kifer. All rights reserved.
//

import Foundation

private let CommentOpen = Character("{")

private let CommentClose = Character("}")

class Tokenizer {
    fileprivate var codeStream: CharStream
    fileprivate(set) internal var current: Token = Variable(value: "placeholder")
    
    // are there any more Tokens left?
    var hasMore: Bool { return codeStream.hasMore }
    
    // create a tokenizer
    init(code: CharStream) {
        codeStream = code
        advance()
    }
    
    // move to the next token in this stream of code
    func advance() {
        current = takeNext()
    }
    
    
    
    
}

/**
 Tokenization process. Switch statement uses the current character to predict the kind of Token that will be constructed
 
 **/
private extension Tokenizer {
    
    func takeNext() -> Token {
        switch codeStream.current {
        case isWhitespace:
            return Whitespace(value: take(matching: isWhitespace))
        default:
            fatalError("Illegal character: \"\(codeStream.current)\"")
        }
    }
    
    // Advance the code stream by one character and return it as a String
    func takeOne() -> String {
        let charString = String(codeStream.current)
        codeStream.advance()
        return charString
    }
    
    //Advance the code stream past all characters which match a given definition,
    //  and return them concatenated as a String.
    func take(matching matches:(Character) -> Bool) -> String {
        var taken = ""
        
        while matches(codeStream.current){
            taken += takeOne()
        }
        return taken
    }
    
    // find the whole comment and return it
    func takeComment() -> Token {
        let openChar = takeOne()
        guard openChar == String(CommentOpen) else {
            fatalError("Error processing comment, received \(openChar) when expecting \(CommentOpen)")
        }
        
        var commentText = ""
        
        while codeStream.current != CommentClose {
            commentText += takeOne()
        }
        
        let _ = takeOne() // comment close
        
        return Comment(value: commentText)
    }
    
    
    
    private func isWhitespace(_ char: Character) -> Bool {
        return char == "\n" || char == "\t" || char == " "
    }
    
    private func isNumber(_ char: Character) -> Bool {
        switch char {
        case "0"..."9":
            return true
        default:
            return false
        }
    }
    
    // returns true if parenthesis
    private func isParen(_ char: Character) -> Bool {
        let stringChar = String(char)
        return stringChar == TokenType.leftParen.rawValue ||
        stringChar == TokenType.rightParen.rawValue
    }
    
    private func isOperator(_ char: Character) -> Bool {
        return TokenType.operators.map { op in
            return String(char) == op.rawValue
            }.reduce(false) { acc, doesMatch in
                return acc || doesMatch
            }
    }
    
    // custom pattern matching for Characters
    private func ~= (pattern: (Character) -> (Bool), value: Character) -> Bool {
        return pattern(value)
    }
    
}
