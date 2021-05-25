//
//  Expr.swift
//  SLox
//
//  Created by ChenBin on 2021/5/10.
//

import Foundation

protocol Expr {
    
    func accept<V: Visitor>(visitor v: V) throws -> V.R
    
}

protocol Visitor {
    
    associatedtype R
    
    func visitBinary(_ binary: Binary) throws -> R
    
    func visitGroup(_ group: Group) throws -> R
    
    func visitLiteral(_ literal: Literal) throws -> R
    
    func visitUnary(_ unary: Unary) throws -> R
    
}

struct Binary: Expr {
    let left: Expr
    let op: Token
    let right: Expr
    
    func accept<V>(visitor v: V) throws -> V.R where V : Visitor {
        try v.visitBinary(self)
    }
}

struct Group: Expr {
    let expr: Expr
    
    func accept<V>(visitor v: V) throws -> V.R where V : Visitor {
        try v.visitGroup(self)
    }
}

struct Unary: Expr {
    let op: Token
    let right: Expr
    
    func accept<V>(visitor v: V) throws -> V.R where V : Visitor {
        try v.visitUnary(self)
    }
}

struct Literal: Expr {
    let value: Any
    
    func accept<V>(visitor v: V) throws -> V.R where V : Visitor {
        try v.visitLiteral(self)
    }
}

struct NilLiteral: ExpressibleByNilLiteral {
    init(nilLiteral: ()) {}
}

