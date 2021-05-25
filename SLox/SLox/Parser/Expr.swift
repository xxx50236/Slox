//
//  Expr.swift
//  SLox
//
//  Created by ChenBin on 2021/5/10.
//

import Foundation

protocol Expr {
    
    func accept<V: ExprVisitor>(visitor v: V) throws -> V.R
    
}

struct Binary: Expr {
    let left: Expr
    let op: Token
    let right: Expr
    
    func accept<V>(visitor v: V) throws -> V.R where V : ExprVisitor {
        try v.visitBinary(self)
    }
}

struct Group: Expr {
    let expr: Expr
    
    func accept<V>(visitor v: V) throws -> V.R where V : ExprVisitor {
        try v.visitGroup(self)
    }
}

struct Unary: Expr {
    let op: Token
    let right: Expr
    
    func accept<V>(visitor v: V) throws -> V.R where V : ExprVisitor {
        try v.visitUnary(self)
    }
}

struct Literal: Expr {
    let value: Any
    
    func accept<V>(visitor v: V) throws -> V.R where V : ExprVisitor {
        try v.visitLiteral(self)
    }
}

struct NilLiteral: ExpressibleByNilLiteral {
    init(nilLiteral: ()) {}
}

