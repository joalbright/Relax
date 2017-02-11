//
//  ItunesTests.swift
//  Relax
//
//  Created by Jo Albright on 1/12/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest

class ItunesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        ItunesAPI.session().start()
        
    }
    
    func testSearchRequest() {
        
        let expectation = self.expectation(description: #function + " asynchronous request")
        
        // singleton Itunes API
        
        let session = ItunesAPI.session
        
        // setup endpoint
        
        var search = ItunesAPI.Endpoints.search.endpoint
        
        search.parameters = ["term" : "daft+punk"]
        
        // run request
        
        session().request(search) {
            
            XCTAssertNil($0.1, #function + " error \($0.1)")
            
            XCTAssertNotNil($0.0, #function + " info nil")
            
            expectation.fulfill()
            
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testLookupRequest() {
        
        let expectation = self.expectation(description: #function + " asynchronous request")
        
        // singleton Itunes API
        
        let itunesAPI = ItunesAPI.session
        
        // setup endpoint
        
        var search = ItunesAPI.Endpoints.lookup.endpoint
        
        search.parameters = ["id" : "5468295"]
        
        // run request
        
        itunesAPI().request(search) {
            
            XCTAssertNil($0.1, #function + " error \($0.1)")
            
            XCTAssertNotNil($0.0, #function + " info nil")
            
            expectation.fulfill()
            
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
        
    }
    
}
