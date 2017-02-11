//
//  ItunesAPI.swift
//  Relax
//
//  Created by Jo Albright on 1/11/16.
//  Copyright (c) 2016 Jo Albright. All rights reserved.
//


import Foundation


// Documentation : https://www.apple.com/itunes/affiliates/resources/documentation/itunes-store-web-service-search-api.html

private let _i = ItunesAPI()

open class ItunesAPI: API {
    
    open override class func session() -> ItunesAPI { return _i }
    
    open override func start() {
        
        baseURL = "https://itunes.apple.com/"
        
    }

    public enum Endpoints: String {
        
        /// Search using "term" parameter
        case search
        
        /// Lookup entity (artist, album, etc) using "id" (or another) parameter
        case lookup
        
        
        public var endpoint: Endpoint { return _endpoints[self]! }
        
        var _endpoints: [Endpoints:Endpoint] {
            
            return [
                
                .search : Endpoint(path: "search"),
                .lookup : Endpoint(path: "lookup")
                
            ]
            
        }
        
    }
    
}
