//
//  GithubTests.swift
//  Relax
//
//  Created by Jo Albright on 1/12/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest

//client_id=CLIENT_ID&client_secret=CLIENT_SECRET

class FoursquareTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        FoursquareAPI.session().start()
        
    }
    
    func testVenuesSearchRequest() {
        
        let expectation = self.expectation(description: #function + " asynchronous request")
        
        let session = FoursquareAPI.session
        
        // setup endpoint
        
        var atlanta = FoursquareAPI.Endpoints.venuesSearch.endpoint
        
        atlanta.parameters = ["near": "atlanta", "query": "coffee"]
        
        // run request
        
        session().request(atlanta) {
            
            XCTAssertNil($0.1, #function + " error \($0.1)")
            
            XCTAssertNotNil($0.0, #function + " info nil")
            
            expectation.fulfill()
            
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
        
    }
    
}
