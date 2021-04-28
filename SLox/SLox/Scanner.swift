//
//  Scanner.swift
//  SLox
//
//  Created by CB on 2021/4/19.
//

import Foundation

class Scanner {
    
    private let source: [Character]
    private var tokens: [Token] = []
    
    private var start = 0
    private var current = 0
    private var line = 1
    
    init(_ source: String) {
        self.source = Array(source)
    }
    
}

extension Scanner {
    
    func scanTokens() -> [Token] {
        
        while !isAtEnd() {
            start = current
            scanToken()
        }
        
        return tokens
        
    }
    
    private func isAtEnd() -> Bool {
        return current >= source.count
    }
            
}

extension Scanner {
    
    private func scanToken() {
        
        let c = advance()
        
        switch c {
        case "(":
            addToken(type: .leftParen)
        case ")":
            addToken(type: .rightParen)
        case "{":
            addToken(type: .leftBrace)
        case "}":
            addToken(type: .rightBrace)
        case ",":
            addToken(type: .comma)
        case ".":
            addToken(type: .dot)
        case "-":
            addToken(type: .minus)
        case "+":
            addToken(type: .plus)
        case ";":
            addToken(type: .semicolon)
        case "*":
            addToken(type: .star)
        default:
            SLox.error(line: line, message: "Unexpected character.")
        }
        
    }
    
    private func advance() -> Character {
        defer {
            current += 1
        }
        
        return source[current]
    }
    
    private func addToken(type: Token.TokenType) {
        addToken(type: type, literal: nil)
    }
    
    private func addToken(type: Token.TokenType, literal: CustomStringConvertible?) {
        let text = String(source[start..<current])
        let token = Token(type: type, lexeme: text, literal: literal, line: line)
        tokens.append(token)
    }
    
}
