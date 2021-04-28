//
//  Token.swift
//  SLox
//
//  Created by CB on 2021/4/19.
//

import Foundation

struct Token {
    let type: TokenType
    let lexeme: String
    let literal: CustomStringConvertible?
    let line: Int
    
}

extension Token: CustomStringConvertible {
    var description: String {
        return [
            type.rawValue,
            lexeme,
            literal?.description ?? ""
        ].joined(separator: " ")
    }
}

extension Token {
    
    enum TokenType: String {
        
        // Single-character tokens.
        case leftParen
        case rightParen
        case leftBrace
        case rightBrace
        case comma
        case dot
        case minus
        case plus
        case semicolon
        case slash
        case star
        
        // One or two character tokens.
        case bang
        case bangEqual
        case equal
        case equalEqual
        case greater
        case greaterEqual
        case less
        case lessEqual
        
        // Literals.
        case identifier
        case string
        case number
        
        // Keywords
        case `and`
        case `class`
        case `else`
        case `false`
        case `true`
        case `fun`
        case `for`
        case `if`
        case `nil`
        case `or`
        case `print`
        case `return`
        case `super`
        case `this`
        case `var`
        case `while`
        
    }
    
}
