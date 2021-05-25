//
//  Stmt.swift
//  SLox
//
//  Created by CB on 2021/5/25.
//

import Foundation

protocol Stmt {
    
    func accept<V: StmtVisitor>(visitor v: V) throws
    
}

struct Expression: Stmt {

    let expr: Expr
    
    func accept<V>(visitor v: V) throws where V : StmtVisitor {
        try v.visitExpressionStmt(self)
    }
    
}

struct Print: Stmt {

    let expr: Expr
    
    func accept<V>(visitor v: V) throws  where V : StmtVisitor {
        try v.visitPrintStmt(self)
    }
    
}
