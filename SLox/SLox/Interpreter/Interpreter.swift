//
//  Interpreter.swift
//  SLox
//
//  Created by ChenBin on 2021/5/17.
//

import Foundation

class Interpreter {
    
    func interprert(expr: Expr) {
        
        do {
            let value = try evaluate(expr: expr)
            print(stringify(ob: value))
        } catch {
            
            if let e = error as? RuntimeError {
                SLox.runtimeError(e)
            }
            
        }
        
    }
    
}

// Interpreter expression
extension Interpreter: Visitor {

    func visitBinary(_ binary: Binary) throws -> Any? {
        guard let left = try evaluate(expr: binary.left), let right = try evaluate(expr: binary.right) else {
            return nil
        }
        
        let opType = binary.op.type
        
        switch opType {
        
        case .bangEqual, .equalEqual:
            if let l = left as? Double, let r = right as? Double {
                return opType == .bangEqual ? !isEqual(l, r) : isEqual(l, r)
            } else if let l = left as? Bool, let r = right as? Bool {
                return opType == .bangEqual ? !isEqual(l, r) : isEqual(l, r)
            } else if let l = left as? String, let r = right as? String {
                return opType == .bangEqual ? !isEqual(l, r) : isEqual(l, r)
            } else {
                throw RuntimeError(token: binary.op, message: "Operands must be two numbers or two strings or Bools")
            }
        case .greater:
            try checkNumberOperands(opt: binary.op, left: left, right: right)
            return (left as! Double) > (right as! Double)
        case .greaterEqual:
            try checkNumberOperands(opt: binary.op, left: left, right: right)
            return (left as! Double) >= (right as! Double)
        case .less:
            try checkNumberOperands(opt: binary.op, left: left, right: right)
            return (left as! Double) < (right as! Double)
        case .lessEqual:
            try checkNumberOperands(opt: binary.op, left: left, right: right)
            return (left as! Double) <= (right as! Double)
        case .minus:
            try checkNumberOperands(opt: binary.op, left: left, right: right)
            return (left as! Double) - (right as! Double)
        case .plus:
            if let l = left as? Double, let r = right as? Double {
                return l + r
            } else if let l = left as? String, let r = right as? String {
                return l + r
            } else {
                throw RuntimeError(token: binary.op, message: "Operands must be two numbers or two strings.")
            }
        case .slash:
            try checkNumberOperands(opt: binary.op, left: left, right: right)
            return (left as! Double) / (right as! Double)
        case .star:
            try checkNumberOperands(opt: binary.op, left: left, right: right)
            return (left as! Double) * (right as! Double)
            
        default:
            return nil
        }
    }
    
    func visitGroup(_ group: Group) throws -> Any? {
        return try evaluate(expr: group.expr)
    }
    
    func visitUnary(_ unary: Unary) throws -> Any? {
                
        guard let right = try evaluate(expr: unary.right) else {
            return nil
        }
        
        if unary.op.type == .minus {
            try checkNumberOperand(opt: unary.op, operand: right)
            let rightValue = right as! Double
            return -rightValue
        } else if unary.op.type == .bang {
            return !isTruthy(ob: right)
        }
        
        return nil
    }
    
    func visitLiteral(_ literal: Literal) throws -> Any? {
        return literal.value
    }
    
}

// Util
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
    
    private func evaluate(expr: Expr) throws -> Any? {
        return try expr.accept(visitor: self)
    }
    
    private func checkNumberOperand(opt: Token, operand: Any) throws {
        
        if operand is Double {
            return
        }
        
        throw RuntimeError(token: opt, message: "Operand must be a number.")
    }
    
    private func checkNumberOperands(opt: Token, left: Any, right: Any) throws {
        
        if left is Double && right is Double {
            return
        }
        
        throw RuntimeError(token: opt, message: "Operands must be a numbers.")
    }
    
    private func stringify(ob: Any?) -> String {
        
        guard let o = ob else {
            return ""
        }
        
        if o is NilLiteral {
            return "nil"
        }
        
        if let number = o as? Double {
            return String(number)
        }
        
        if let str = ob as? String {
            return str
        }
        
        if let bool = ob as? Bool {
            return String(bool)
        }
        
        return ""
    }
}
