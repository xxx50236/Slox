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
    
    private func expression() throws -> Expr {
        return try equality()
    }
        
}

extension Parser {
    
    private func equality() throws -> Expr {
        
        var expr = try comparison()
        
        while match(types: .bangEqual, .equalEqual),
              let op = previous()  {
            
            let right = try comparison()
            
            expr = Binary(left: expr, op: op, right: right)
        }
        
        return expr
    }
    
}

extension Parser {
    
    private func comparison() throws -> Expr {
        var expr = try term()
        
        while match(types: .greater, .greaterEqual, .less, .lessEqual),
              let op = previous() {
            
            let right = try term()
            expr = Binary(left: expr, op: op, right: right)
        }
        
        return expr
    }
    
}

extension Parser {
    
    private func term() throws -> Expr {
        
        var expr = try factor()
        
        while match(types: .minus, .plus), let op = previous() {
            let right = try factor()
            expr = Binary(left: expr, op: op, right: right)
        }
        
        return expr
        
    }
    
}

extension Parser {
    
    private func factor() throws -> Expr {
        
        var expr = try unary()
        
        while match(types: .slash, .star), let op = previous() {
            let right = try unary()
            expr = Binary(left: expr, op: op, right: right)
        }
        
        return expr
        
    }
    
}

extension Parser {
    
    private func unary() throws -> Expr {
        if match(types: .bang, .minus), let op = previous() {
            let expr = try unary()
            return Unary(op: op, right: expr)
        }
        
        return try primary()
    }
    
}

extension Parser {
    
    private func primary() throws -> Expr {
        
        if match(types: .false) {
            return Literal(value: false)
        } else if match(types: .true) {
            return Literal(value: true)
        } else if match(types: .nil) {
            return Literal(value: nil)
        }
        
        if match(types: .number, .string) {
            return Literal(value: previous()?.literal)
        }
        
        if match(types: .leftParen) {
            let expr = try expression()
            
            try consume(type: .rightParen, message: "Expect ')' after expression.")
            return Group(expr: expr)
        }
        
        throw ParserError()
    }
    
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
    
    @discardableResult
    private func consume(type: Token.TokenType, message: String) throws -> Token? {
        if check(type: type) {
            return advance()
        }
        
        throw error(token: peek()!, message: message)
    }
    
}

extension Parser {
    
    private func error(token: Token, message: String) -> ParserError {
        SLox.error(token: token, message: message)
        return ParserError()
    }
    
}
