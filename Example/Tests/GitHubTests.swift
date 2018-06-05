//
//  GithubTests.swift
//  Relax
//
//  Created by Jo Albright on 1/12/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest

class GitHubTests: XCTestCase {
    
    override func setUp() {
        super.setUp()

        GitHubAPI.session().start()
    
    }
    
    func testUserNameRequest() {
        
        let expectation = self.expectation(description: #function + " asynchronous request")
        
        let session = GitHubAPI.session
        
        // setup endpoint
        
        var profile = GitHubAPI.Endpoints.usersNamed.endpoint
        
        profile.pathpieces = ["username" : "joalbright"]
        
        // run request
        
        session().request(profile) { info, error in
            
            XCTAssertNil(error, #function + " error \(String(describing: error))")
            XCTAssertNotNil(info, #function + " info nil")
            
            expectation.fulfill()
            
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testSearchUsersRequest() {
        
        let expectation = self.expectation(description: #function + " asynchronous request")
        
        let session = GitHubAPI.session
        
        // setup endpoint
        
        var profile = GitHubAPI.Endpoints.searchUsers.endpoint
        
        profile.parameters = ["q" : "joalbright"]
        
        // run request
        
        session().request(profile) { info, error in
            
            XCTAssertNil(error, #function + " error \(String(describing: error))")
            XCTAssertNotNil(info, #function + " info nil")
            
            expectation.fulfill()
            
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
        
    }
    
}
