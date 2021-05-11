//
//  ScannerTest.swift
//  TestSLox
//
//  Created by ChenBin on 2021/5/10.
//

import XCTest
@testable import SLox

class ScannerTest: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        
        let scan = Scanner("var a = \"slox is language\"")
        let token = scan.scanTokens()
        
        XCTAssert(token[0].type == .var)
        
        
    }

}
