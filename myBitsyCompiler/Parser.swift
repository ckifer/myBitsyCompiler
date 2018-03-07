//
//  Parser.swift
//  myBitsyCompiler
//
//  Created by Coltin Kifer on 3/7/18.
//  Copyright © 2018 Coltin Kifer. All rights reserved.
//

import Foundation

class Parser {
    fileprivate let tokens: Tokenizer
    fileprivate let generator: CodeGenerator
    
    init(tokens: Tokenizer, generator: CodeGenerator) {
        self.tokens = tokens
        self.generator = generator
        
        if currentToken.isSkippable {
            advanceToken()
        }
    }
    
    func parse(){
        program()
    }
}
    
    // methods for convenience
    private extension Parser {
        
        // access current token
        var currentToken: Token { return tokens.current }
        
        // advance to something that isn't whitespace or a comment
        func advanceToken(){
            guard tokens.hasMore else {
                return
            }
            tokens.advance()
            
            while currentToken.isSkippable {
                tokens.advance()
            }
        }
        
        @discardableResult
        func match(tokenType type: TokenType, andTerminate terminate: Bool = false) -> String {
            guard currentToken.type == type else {
                print("[ERROR] Expecting \(type.rawValue) but received \(currentToken.value)")
                exit(EX_DATAERR)
            }
            
            if terminate {
                return currentToken.value
            }
            
            let value = currentToken.value
            advanceToken()
            return value
        }
}

private extension Parser {
    
    static func ifCondition(forTokenType type: TokenType) -> CodeGenCondition {
        switch type {
        case .ifP:
            return .positive
        case .ifN:
            return .negative
        case .ifZ:
            return .zero
        default:
            fatalError("Unexpected non-IF code: \(type)")
        }
    }
    
    static func codeOp(forTokenType type: TokenType) -> CodeGenOperation {
        switch type {
        case .plus:
            return .add
        case .minus:
            return .subtract
        case .multiply:
            return .multiply
        case .divide:
            return .divide
        case .modulus:
            return .modulus
        default:
            fatalError("Unexpected non-operator code: \(type)")
        }
    }
}

// MARK: Begin recursive descent

private extension Parser {
    
    // top level entry for recursive descent parser
    func program() {
        
    }
    
}
        
        
        

// MARK: Convenience Token Extensions
private extension Token {
    
    /** Is this `Token` one which has no effect on the execution of the program? */
    var isSkippable: Bool { return self.type == .whitespace || self.type == .comment }
    
    /** Is this `Token` one which denominates the end of block? */
    var isBlockEnd: Bool { return self.type == .end || self.type == .elseKey }
    
    /** Is this `Token` a mathematical operator with addition precedence */
    var isAdditionOperator: Bool { return self.type == .plus || self.type == .minus }
    
    /** Is this `Token` a mathematical operator with mutiplication precedence */
    var isMultiplicationOperator: Bool { return self.type == .multiply || self.type == .divide || self.type == .modulus }
}

