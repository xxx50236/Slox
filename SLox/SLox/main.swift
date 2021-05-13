//
//  main.swift
//  SLox
//
//  Created by CB on 2021/4/15.
//

import Foundation



print("Hello, World!")

let scan = Scanner("var a = \"slox is language\"")
let token = scan.scanTokens()

print(token)

