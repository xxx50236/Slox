//
//  StmtVisitor.swift
//  SLox
//
//  Created by CB on 2021/5/25.
//

import Foundation

protocol StmtVisitor {
    
    func visitExpressionStmt(_ stmt: Expression) throws

    func visitPrintStmt(_ stmt: Print) throws
}
