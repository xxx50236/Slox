//
//  ExprExprVisitor.swift
//  SLox
//
//  Created by CB on 2021/5/25.
//

import Foundation

protocol ExprVisitor {
    
    associatedtype R
    
    func visitBinary(_ binary: Binary) throws -> R
    
    func visitGroup(_ group: Group) throws -> R
    
    func visitLiteral(_ literal: Literal) throws -> R
    
    func visitUnary(_ unary: Unary) throws -> R
    
}
