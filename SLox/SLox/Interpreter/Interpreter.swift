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
    
    func visitBinary(_ binary: Binary) -> Any? {
        guard let left = evaluate(expr: binary.left), let right = evaluate(expr: binary.right) else {
            return nil
        }
        
        let opType = binary.op.type
        
        if let leftValue = left as? Double, let rightValue = right as? Double {
            
            switch opType {
            case .minus:
                return leftValue - rightValue
            case .slash:
                return leftValue / rightValue
            case .star:
                return leftValue * rightValue
            case .plus:
                return leftValue + rightValue
            case .greater:
                return leftValue > rightValue
            case .greaterEqual:
                return leftValue >= rightValue
            case .less:
                return leftValue < rightValue
            case .lessEqual:
                return leftValue <= rightValue
            case .bangEqual:
                return !isEqual(leftValue, rightValue)
            case .equalEqual:
                return isEqual(leftValue, rightValue)
            default:
                return nil
            }
                    
        } else if let leftValue = left as? String, let rightValue = right as? String, opType == .plus {
            return leftValue + rightValue
        }
        
        return nil
    }
    
    func visitGroup(_ group: Group) -> Any? {
        return evaluate(expr: group.expr)
    }
    
    func visitUnary(_ unary: Unary) -> Any? {
                
        guard let right = evaluate(expr: unary.right) else {
            return nil
        }
        
        if let rightValue = right as? Double, unary.op.type == .minus {
            return -rightValue
        } else if unary.op.type == .bang {
            return !isTruthy(ob: right)
        } else {
            return nil
        }
        
    }
    
    func visitLiteral(_ literal: Literal) -> Any? {
        return literal.value
    }
    
}

extension Interpreter {
    
    private func isTruthy(ob: Any) -> Bool {
        
        if ob is NilLiteral {
            return false
        } else if let boolValue = ob as? Bool {
            return boolValue
        } else {
            return true
        }
        
    }
    
    private func isEqual<T: Equatable>(_ a: T?, _ b: T?) -> Bool {
        return a == b
    }
    
    private func evaluate(expr: Expr) -> Any? {
        return expr.accept(visitor: self)
    }
    
}
