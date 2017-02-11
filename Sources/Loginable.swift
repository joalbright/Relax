//
//  Loginable.swift
//  Pods
//
//  Created by Jo Albright on 1/14/16.
//
//

import Foundation


public protocol Loginable {
    
    var session: API! { get set }
    
}

extension Loginable {
    
    public var loginDetails: (auth: Endpoint, authCode: Endpoint)! { return session.loginDetails() }
    
    public func requestToken(_ urlString: String, endpoint: Endpoint, api: API?, finished: @escaping (_ success: Bool) -> Void) {
        var endpoint = endpoint
        
        guard let code = urlString.param("code"), !code.isEmpty else { return finished(false) }
        
        endpoint.parameters["code"] = code as Any?
        
        api?.request(endpoint) {
            
            print($0)
            
            guard let info = $0.0 else { return finished(false) }
            guard let token = info["access_token"] as? String else { return finished(false) }
            
            api?.authToken = token
            finished(true)
            
        }
    
    }
    
}

extension String {
    
    func param(_ param: String) -> String? {
        
        if let urlComponents = URLComponents(string: self), let queryItems = urlComponents.queryItems {
            return queryItems.filter({ (item) in item.name == param }).first?.value
        }
        return nil
        
    }
    
}

