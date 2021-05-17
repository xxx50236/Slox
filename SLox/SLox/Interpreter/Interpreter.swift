//
//  Interpreter.swift
//  SLox
//
//  Created by ChenBin on 2021/5/17.
//

import Foundation

class Interpreter {
    
}

extension Interpreter: Visitor {
    
    func visitBinary(_ binary: Binary) -> Optional<Any> {
        return 1
    }
    
    func visitGroup(_ group: Group) -> Optional<Any> {
        return evaluate(expr: group.expr)
    }
    
    func visitUnary(_ unary: Unary) -> Optional<Any> {
        
        guard let right = evaluate(expr: unary.right) else {
            return .none
        }

        switch unary.op.type {
        case .minus:
            if let rightValue = right as? Double {
                return .some(-rightValue)
            }
            return .none

        default:
            return .none
        }
        
        return .none
    }
    
    func visitLiteral(_ literal: Literal) -> Optional<Any> {
        return literal.value
    }
    
}

extension Interpreter {
    
    private func isTruthy(ob: Optional<Any>) -> Bool {
        
    }
    
    private func evaluate(expr: Expr) -> Optional<Any> {
        return expr.accept(visitor: self)
    }
    
}
