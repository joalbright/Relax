//
//  Relax.swift
//  Relax
//
//  Created by Jo Albright on 1/11/16.
//  Copyright (c) 2016 Jo Albright. All rights reserved.
//
//


import Foundation


public typealias Response = (_ info: [String:Any]?, _ error: Error?) -> Void

private let _s = URLSession.shared

open class Relax {
    
    open class func url(_ endpoint: Endpoint, api: API?) throws -> String {
        
        guard let api = api else { throw URLError.badAPI }
        guard endpoint.satisfied else { throw URLError.badParameters }
        
        let keys = api.authBasic.flatten("&") { "\($0)=\($1)" }
        let query = api.authToken.isEmpty ? endpoint.query.isEmpty ? "?" + keys : endpoint.query.contains(keys) ? endpoint.query : endpoint.query + "&" + keys : endpoint.query

        return api.authURL + endpoint.path + query
        
    }
    
    open class func request(_ endpoint: Endpoint, response completion: @escaping Response, api: API?) {
        
        guard let api = api else { return completion(nil, URLError.badAPI) }
        guard !api.authToken.isEmpty || !endpoint.requiresUser else { return completion(nil, URLError.badUser) }
        guard endpoint.satisfied else { return completion(nil, URLError.badParameters) }
        
        for (k,v) in api.authBasic { if v == "ACCESS_TOKEN" { api.authBasic[k] = api.authToken } }
        
        let keys = api.authBasic.flatten("&") { "\($0)=\($1)" }
        
        let query = endpoint.query.isEmpty ? "?" + keys : endpoint.query + "&" + keys
        
        let full = (endpoint.parameters["code"] != nil ? api.authURL : api.baseURL) + endpoint.path + query
        
        guard let url = URL(string: full) else { return completion(nil, URLError.badURL) }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = endpoint.method.rawValue
        
        if endpoint.method != .GET {
            
            request.httpBody = endpoint.parameters.flatten("&") { "\($0)=\($1)" }.data(using: String.Encoding.utf8)
            
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if !api.authHeader.isEmpty && !api.authToken.isEmpty {
            
            request.setValue(api.authToken, forHTTPHeaderField: api.authHeader)
        
        }
        
        let task = _s.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                
                guard error == nil else { return completion(nil, error?.convert) }
                guard let data = data else { return completion(nil, URLError.badData) }
                
                let json = try? data.unserialize()
                
                if let d = json as? [String:Any] { completion(d, nil) }
                if let a = json as? [Any] { completion(["objects":a], nil) }
                
            }
            
        }
        
        task.resume()
        
    }
    
}

public enum URLError: Error {
    
    case nsError(String)
    case badData
    case badParameters
    case badURL
    case badAPI
    case badUser
    
}

extension Error {
    
    var convert: Error { return URLError.nsError(self.localizedDescription) }
    
}

