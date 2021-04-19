//
//  SLox.swift
//  SLox
//
//  Created by CB on 2021/4/19.
//

import Foundation

class SLox {
    
    func runCode(_ code: String) {
        
        let scanner = Scanner(code)
        let tokens = scanner.scanTokens()
        
        for token in tokens {
            print(token)
        }
        
        
        
    }
    
}
