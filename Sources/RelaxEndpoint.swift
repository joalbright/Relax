//
//  Endpoint.swift
//  Relax
//
//  Created by Jo Albright on 1/11/16.
//  Copyright (c) 2016 Jo Albright. All rights reserved.
//
//


import Foundation


public typealias Parameters = [String:Any]
public typealias Headers = [String:Any]

public enum Method: String {
    
    case GET, POST, DELETE, PUT, PATCH, OPTIONS
    
}

public struct Endpoint {
    
    // Set on creation.
    
    public var path: String!
    public var method: Method!
    public var requiredParameters: [String] = []
    public var requiresUser: Bool = false
    
    // Set when creating request.
    
    public var pathpieces: [String:String] = [:] { didSet { for (k,v) in pathpieces { path = path.replace(":" + k, v) } } }
    public var parameters: Parameters = [:]
    public var query: String { return method == .GET && parameters.count > 0 ? "?" + parameters.flatten("&") { "\($0.0)=\($0.1)" } : "" }
    
    public var satisfied: Bool {
        
        parameter: for parameter in requiredParameters {
            
            for choice in parameter.components(separatedBy: ",") { guard parameters[choice] == nil else { continue parameter } }
            guard parameters[parameter] != nil else { return false }
        
        }
        
        return true
        
    }
    
    public init(path: String, method: Method = .GET, requiredParameters: [String] = [], requiresUser: Bool = false) {
        
        self.path = path
        self.method = method
        self.requiredParameters = requiredParameters
        self.requiresUser = requiresUser
        
    }
    
}

extension String {
    
    func replace(_ s1: String, _ s2: String) -> String {
        
        return self.replacingOccurrences(of: s1, with: s2)
        
    }
    
}

extension Collection {
    
    func flatten(_ seperator: String = "", transform: (Self.Iterator.Element) -> String) -> String {
        
        var flattenedElements: [String] = []
        for element in self {
        
            let flat = transform(element)
            guard flat.characters.last != "=" else { continue }
            flattenedElements.append(flat)
        
        }
        return flattenedElements.joined(separator: seperator)
        
    }
    
}

