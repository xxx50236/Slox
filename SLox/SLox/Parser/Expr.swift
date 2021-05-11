//
//  Expr.swift
//  SLox
//
//  Created by ChenBin on 2021/5/10.
//

import Foundation

protocol Expr {
    
    func accept<V: Visitor>(visitor v: V) -> V.R
    
}

protocol Visitor {
    
    associatedtype R
    
    func visitBinary(_ binary: Binary) -> R
    
    func visitGroup(_ group: Group) -> R
    
    func visitLiteral(_ literal: Literal) -> R
    
    func visitUnary(_ unary: Unary) -> R
    
}

struct Binary: Expr {
    let left: Expr
    let op: Token
    let right: Expr
    
    func accept<V>(visitor v: V) -> V.R where V : Visitor {
        v.visitBinary(self)
    }
}

struct Group: Expr {
    let expr: Expr
    
    func accept<V>(visitor v: V) -> V.R where V : Visitor {
        v.visitGroup(self)
    }
}

struct Literal: Expr {
    let value: Any
    
    func accept<V>(visitor v: V) -> V.R where V : Visitor {
        v.visitLiteral(self)
    }
}

struct Unary: Expr {
    let op: Token
    let right: Expr
    
    func accept<V>(visitor v: V) -> V.R where V : Visitor {
        v.visitUnary(self)
    }
}

