//
//  CodeGenerator.swift
//  myBitsyCompiler
//
//  Created by Coltin Kifer on 2/21/18.
//  Copyright © 2018 Coltin Kifer. All rights reserved.
//

import Foundation

/**
 * Handles implementation details of the given intermediate representation
 * aka the compilation target
 */
protocol IntermediateBuilder {
    
    /**
     * Returns the external shell command for producing a binary executable from the
     * intermediate/target code
     *
     * - parameter forFinalPath: The final path of the binary executable to generate
     */
    func buildCommand(forFinalPath path: String) -> String
    
    // get the appropriate extension for compilation target ex: .bitsy
    var intermediateExtention: String { get }
}

extension IntermediateBuilder {
    
    // The final path of the binary executable to be executed
    func intermediatePath(forFinalPath path: String) -> String {
        return path + intermediateExtention
    }
}

// conditions in Bitsy - IFN, IFZ, IFP
enum CodeGenCondition {
    case positive, negative, zero
}

/**
 * The mathematical operations that will need to be performed when generating
 * target code
 */
enum CodeGenOperation {
    case add, subtract, multiply, divide, modulus
}

// code generation

protocol CodeGenerator: IntermediateBuilder {
    
    // code emitter to give instructions to
    
    
    // emits code that must be before all other code
    func header()
    
    // emits code that must be after all other code in target language
    func footer()
    
    /**
     * Emits code defining a branch condition based on the state of the register.
     * Subsequent code *should* execute if the register matches the condition type.
     *
     * - parameter type: Execute subsequent code if the state of the register
     *                   matches this condition
     */
    func startCondition(type: CodeGenCondition)
    
    // start of conditional branch
    func elseCondition()
    
    // end of conditional brnach
    func endCondition()
    
    // beginning of a repeating set of instructions
    func loopOpen()
    
    // defines the end of a loop
    func loopEnd()
    
    // exits a repeating set of instructions
    func breakLoop()
    
    // emits code akin to a standard out with a return character at the end
    func print()
    
    /**
     * Emits code which pauses to take input from STDIN and loads the integer value
     * into memory addressable by a name
     *
     * - Note: input other than a stream of digits, optionally prepended with +/-,
     *         should load a value of 0
     *
     *  - parameter variableName: The 'address' to load the input
     */
    func read(variableName name: String)
    
    /**
     * Loads the addressed value into the register. A given address is always
     * initialized with 0.
     *
     * - parameter variableName: The name of the 'address' from which to load input
     */
    func load(variableName name: String)
    
    /**
     * Loads an integer literal into the register
     *
     *  - parameter integerValue: digit characters of the integer to load
     */
    func load(integerValue value: String)
    
    /**
     * Stores the current value of the register into the 'address' identified
     *
     * - parameter variableName: The identifying name of the 'address' to write
     */
    func set(variableName name: String)
    
    /**
     * Push the current register value onto the stack
     */
    func push()
    

    /**
     * Pop a value off the top of the stack, perform an operation with that value
     * and the register (in that order), and place the result back in the register
     *
     * - parameter andPerform: The mathematical operation to perform
     */
    func pop(andPerform operation: CodeGenOperation)
    
    /**
     * Reverse the sign of the value in the register
     */
    func negate()
}

extension CodeGenerator {
    func emitLine(_ code: String = "") {
        
    }
    
    // finalize the intermediate code in target language to produce binary
    func finalize() {
        
    }
}
