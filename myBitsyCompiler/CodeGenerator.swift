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
