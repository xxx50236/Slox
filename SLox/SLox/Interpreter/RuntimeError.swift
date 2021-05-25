//
//  RuntimeError.swift
//  SLox
//
//  Created by CB on 2021/5/19.
//

import Foundation

struct RuntimeError: Error {
    
    let token: Token
    let message: String
}
