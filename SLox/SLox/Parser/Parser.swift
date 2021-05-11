//
//  Parser.swift
//  SLox
//
//  Created by CB on 2021/5/11.
//

import Foundation

class Parser {
    
    private let tokens: [Token]
    private var current = 0
    
    init(tokens: [Token]) {
        self.tokens = tokens
    }
    
}

extension Parser {
    
    private func expression() -> Expr {
        return equality()
    }
        
}

extension Parser {
    
    private func equality() -> Expr {
        
        var expr = comparison()
        
        while match(types: .bangEqual, .equalEqual),
              let op = previous()  {
            
            let right = comparison()
            
            expr = Binary(left: expr, op: op, right: right)
        }
        
        return expr
    }
    
}

extension Parser {
    
    private func comparison() -> Expr {
        var expr = term()
        
        while match(types: .greater, .greaterEqual, .less, .lessEqual),
              let op = previous() {
            
            let right = term()
            expr = Binary(left: expr, op: op, right: right)
        }
        
        return expr
    }
    
}

extension Parser {
    
    private func term() -> Expr {
        
    }
    
}

extension Parser {
    
    private func 
    
}

// MARK: Util
extension Parser {
    
    private func match(types: Token.TokenType...) -> Bool {
        for type in types {
            if check(type: type) {
                advance()
                return true
            }
        }
        
        return false
    }
    
    private func check(type: Token.TokenType) -> Bool {
        guard let t = peek() else {
            return false
        }
        return t.type == type
    }
    
    @discardableResult
    private func advance() -> Token? {
        if isAtEnd() {
            current += 1
        }
        
        return previous()
    }
    
    private func isAtEnd() -> Bool {
        current >= tokens.count
    }
    
    private func peek() -> Token? {
        
        guard !isAtEnd() else {
            return nil
        }
        
        return tokens[current]
    }
    
    private func previous() -> Token? {
        
        let i = current - 1
        
        guard i >= 0 && i < tokens.count else {
            return nil
        }
    
        return tokens[current - 1]
    }
}
