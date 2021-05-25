//
//  SLox.swift
//  SLox
//
//  Created by CB on 2021/4/19.
//

import Foundation

class SLox {
    
    static private(set) var hadError = false
    static private(set) var hadRuntimeError = false
    
}

// MARK: Run Code
extension SLox {
    
    func runCode(_ code: String) {
        
        let scanner = Scanner(code)
        let tokens = scanner.scanTokens()
        
        let parser = Parser(tokens: tokens)
        let exp = parser.parse()
        
        if SLox.hadError {
            return
        }
        
        
        
    }
    
}

// MARK: Error Report
extension SLox {
    
    static func error(line: Int, message: String) {
        report(line: line, where: "", message: message)
    }
        
    static func error(token: Token, message: String) {
        report(line: token.line, where: "at '\(token.lexeme)'", message: message)
    }
    
    static func runtimeError(_ error: RuntimeError) {
        print("\(error.message)")
        print("[line \(error.token.line)]")
        hadRuntimeError = true
    }
    
    static private func report(line: Int, where: String, message: String) {
        print("[line \(line) ] Error \(`where`): \(message)")
        hadError = true
    }
    
}
