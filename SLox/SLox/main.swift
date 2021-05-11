//
//  main.swift
//  SLox
//
//  Created by CB on 2021/4/15.
//

import Foundation

func repeatf(input: @escaping (Int) -> Int, n: Int) -> (Int) -> Int {
    if n == 1 {
        return input
    }
    
    return { x in input(repeatf(input: input, n: n - 1)(x))  }
}


let a = repeatf(input: { x in
    x * x
}, n: 5)(2)

print("Hello, World!")

let scan = Scanner("var a = \"slox is language\"")
let token = scan.scanTokens()

print(token)

