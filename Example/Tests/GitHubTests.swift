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
        
        session().request(profile) {
            
            XCTAssertNil($0.1, #function + " error \($0.1)")
            
            XCTAssertNotNil($0.0, #function + " info nil")
            
            expectation.fulfill()
            
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testSearchUsersRequest() {
        
        let expectation = self.expectation(description: #function + " asynchronous request")
        
        let githubAPI = GitHubAPI.session
        
        // setup endpoint
        
        var profile = GitHubAPI.Endpoints.searchUsers.endpoint
        
        profile.parameters = ["q" : "joalbright"]
        
        // run request
        
        githubAPI().request(profile) {
            
            XCTAssertNil($0.1, #function + " error \($0.1)")
            
            XCTAssertNotNil($0.0, #function + " info nil")
            
            expectation.fulfill()
            
        }
        
        self.waitForExpectations(timeout: 10, handler: nil)
        
    }
    
}
