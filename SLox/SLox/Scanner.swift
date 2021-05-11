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
    
    var keywords: [String: Token.TokenType] {
        return [
            "and": .and,
            "class": .class,
            "else": .else,
            "false": .false,
            "for": .for,
            "fun": .fun,
            "if": .if,
            "nil": .nil,
            "or": .or,
            "print": .print,
            "return": .return,
            "super": .super,
            "this": .this,
            "true": .true,
            "var": .var,
            "while": .while,
        ]
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
                
}

extension Scanner {
    
    private func scanToken() {
        
        guard let c = advance() else {
            return
        }
        
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
        case "!":
            addToken(type: match(expected: "=") ? .bangEqual : .bang)
        case "=":
            addToken(type: match(expected: "=") ? .equalEqual : .equal)
        case "<":
            addToken(type: match(expected: "=") ? .lessEqual : .less)
        case ">":
            addToken(type: match(expected: "=") ? .greaterEqual : .greater)
        case "/":
            if match(expected: "/") {
                while peek() != "\n" && !isAtEnd() { advance() }
            } else {
                addToken(type: .slash)
            }
        case " ", "\r", "\t":
            break
        case "\"":
            string()
        case "\n":
            line += 1
        default:
            
            if c.isNumber {
                number()
            } else if c.isLetter || c == "_" {
                identifier()
            } else {
                SLox.error(line: line, message: "Unexpected character.")
            }
            
        }
        
    }
    
    private func string() {
        while peek() != "\"" && !isAtEnd() {
            if peek() == "\n" {
                line += 1
            }
            advance()
        }
        
        if isAtEnd() {
            SLox.error(line: line, message: "Unterminated string.")
            return
        }
        
        advance()
        
        let s = start + 1
        let c = current - 1
        let value = source[s..<c]
        addToken(type: .string, literal: String(value))
    }
    
    private func number() {
        
        while let c = peek(), c.isNumber {
            advance()
        }
        
        if let c = peek(),
           let next = peekNext(),
           next.isNumber && c == "." {
            
            // Consume the "."
            advance()
            
            while let c = peek(), c.isNumber {
                advance()
            }
            
        }
        let s = String(source[start..<current])
        addToken(type: .number, literal: Double(s))
    }
    
    private func identifier() {
        
        while let c = peek(), c.isLetter || c.isNumber {
            advance()
        }
        
        let text = String(source[start..<current])
        let type = keywords[text] ?? .identifier
        
        addToken(type: type)
        
    }
    
    @discardableResult
    private func advance() -> Character? {

        if isAtEnd() {
            return nil
        }
        
        let c = source[current]
        current += 1
        
        return c
    }
    
    private func match(expected: Character) -> Bool {
        if isAtEnd() {
            return false
        }
        
        if source[current] != expected {
            return false
        }
        
        current += 1
        return true
    }
    
    private func isAtEnd() -> Bool {
        return current >= source.count
    }
    
    private func peek() -> Character? {
        if isAtEnd() {
            return nil
        }
        
        return source[current]
    }
    
    private func peekNext() -> Character? {
        if current + 1 >= source.count {
            return nil
        }
        return source[current + 1]
    }
}

extension Scanner {
    
    private func addToken(type: Token.TokenType) {
        addToken(type: type, literal: nil)
    }
    
    private func addToken(type: Token.TokenType, literal: CustomStringConvertible?) {
        let text = String(source[start..<current])
        let token = Token(type: type, lexeme: text, literal: literal, line: line)
        tokens.append(token)
    }
    
}
