//
//  InstagramTests.swift
//  Relax
//
//  Created by Jo Albright on 1/14/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest

class InstagramTests: XCTestCase {

    override func setUp() {
        super.setUp()
        
        InstagramAPI.session().start()
        
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
