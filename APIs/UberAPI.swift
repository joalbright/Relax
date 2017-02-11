//
//  UberAPI.swift
//  Relax
//
//  Created by Jo Albright on 1/12/16.
//  Copyright (c) 2016 Jo Albright. All rights reserved.
//


import Foundation


// Documentation : https://developer.uber.com

private let _u = UberAPI()

open class UberAPI: API {
    
    open override class func session() -> UberAPI { return _u }
    
    open override func start() {
        
        baseURL = "https://api.uber.com/"
        authURL = "https://login.uber.com/oauth/v2/"
        authHeader = "Authorization: Bearer"
        authTokenKey = "Uber"
        authBasic = [
            
            "client_id" : UBER_CLIENT_ID,
            "client_secret" : UBER_CLIENT_SECRET,
            "access_token":"ACCESS_TOKEN"
            
        ]
        
    }
    
    open override func loginDetails() -> (auth: Endpoint, authCode: Endpoint) {
        
        var auth = Endpoints.auth.endpoint
        
        auth.parameters = [
            
            "client_id" : UBER_CLIENT_ID,
            "response_type" : "code",
            "redirect_uri" : "https://code.jo2.co"
            
        ]
        
        var authCode = Endpoints.authCode.endpoint
        
        authCode.parameters = [
            
            "client_id" : UBER_CLIENT_ID,
            "client_secret" : UBER_CLIENT_SECRET,
            "redirect_uri" : "https://code.jo2.co",
            "grant_type" : "authorization_code"
            
        ]
        
        return (auth, authCode)
        
    }
    
    public enum Endpoints: String {
        
        // Auth
        
        case auth
        case authCode
        
        // Products
        
        /// List products
        case products
        /// Get product details
        case productId
        
        // Estimates
        
        /// Get price estimates
        case estimatePrice
        /// Get time estimates
        case estimateTime
        
        // User
        
        /// Get user history for version 1.2
        case userHistory_1_2
        /// Get user history for version 1.1
        case userHistory_1_1
        /// Get user info
        case userInfo
        
        // Requests
        
        /// Create ride request
        case createRideRequest
        /// Get ride details
        case getRideDetails
        /// Get ride estimate
        case getRideEstimate
        /// Cancel ride request
        case cancelRideRequest
        /// Get tracking map
        case getTrackingMap
        /// Get receipt
        case getRideReceipt
        
        // Reminders
        
        /// Create ride reminder
        case createRideReminder
        /// Get ride reminder details
        case getReminderDetails
        /// Update ride reminder details
        case updateReminderDetails
        /// Cancel ride reminder
        case cancelReminder
        
        
        public var endpoint: Endpoint { return _endpoints[self]! }
        
        var _endpoints: [Endpoints:Endpoint] {
            
            return [
                
                // Auth
                
                .auth : Endpoint(path: "authorize", requiredParameters: ["client_id","response_type","redirect_uri"]),
                .authCode : Endpoint(path: "token", requiredParameters: ["client_id","client_secret","grant_type","redirect_uri","code"]),
                
                // Products
                
                .products : Endpoint(path: "v1/products", requiresUser: true),
                .productId : Endpoint(path: "v1/products/:product_id", requiresUser: true),
                
                // Estimates
                
                .estimatePrice : Endpoint(path: "v1/estimates/price", requiresUser: true),
                .estimateTime : Endpoint(path: "v1/estimates/time", requiresUser: true),
                
                // User
                
                .userHistory_1_1 : Endpoint(path: "v1.1/history", requiresUser: true),
                .userHistory_1_2 : Endpoint(path: "v1.2/history", requiresUser: true),
                .userInfo: Endpoint(path: "v1/me", requiresUser: true),
                
                // Requests
                
                .createRideRequest : Endpoint(path: "v1/requests", method: .POST, requiresUser: true),
                .getRideDetails : Endpoint(path: "v1/requests/:request_id", requiresUser: true),
                .getRideEstimate : Endpoint(path: "v1/requests/estimate", method: .POST, requiresUser: true),
                .cancelRideRequest : Endpoint(path: "v1/requests/:request_id", method: .DELETE, requiresUser: true),
                .getTrackingMap : Endpoint(path: "v1/requests/:request_id/map", requiresUser: true),
                .getRideReceipt : Endpoint(path: "v1/requests/:request_id/receipts", requiresUser: true),
                
                // Reminders
                
                .createRideReminder : Endpoint(path: "v1/reminders", method: .POST, requiresUser: true),
                .getReminderDetails : Endpoint(path: "v1/reminders/:reminder_id", requiresUser: true),
                .updateReminderDetails : Endpoint(path: "v1/reminders/:reminder_id", method: .PATCH, requiresUser: true),
                .cancelReminder : Endpoint(path: "v1/reminders/:reminder_id", method: .DELETE, requiresUser: true)
                
            ]
            
        }
        
    }
    
}



