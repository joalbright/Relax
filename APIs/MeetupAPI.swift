//
//  MeetupAPI.swift
//  Relax
//
//  Created by Jo Albright on 1/12/16.
//  Copyright (c) 2016 Jo Albright. All rights reserved.
//


import Foundation


// Documentation : http://www.meetup.com/meetup_api/

open class MeetupAPI: API {
    
    public enum Endpoints: String {
        
        // Auth
        
        case auth
        case authCode
        
        
        public var endpoint: Endpoint { return _endpoints[self]! }
        
        var _endpoints: [Endpoints:Endpoint] {
            
            return [
                
                // Auth
                
                .auth : Endpoint(path: "authenticate", requiredParameters: ["client_id","response_type","redirect_uri"]),
                .authCode : Endpoint(path: "access_token", requiredParameters: ["client_id","client_secret","grant_type","redirect_uri","code"]),
                
            ]
            
        }
        
    }
    
}
