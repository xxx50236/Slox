//
//  SLox.swift
//  SLox
//
//  Created by CB on 2021/4/19.
//

import Foundation

class SLox {
    
    static private(set) var hadError = false
    
}

// MARK: Run Code
extension SLox {
    
    func runCode(_ code: String) {
        
        let scanner = Scanner(code)
        let tokens = scanner.scanTokens()
        
        for token in tokens {
            print(token)
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
    
    static private func report(line: Int, where: String, message: String) {
        print("[line \(line) ] Error \(`where`): \(message)")
        hadError = true
    }
    
}