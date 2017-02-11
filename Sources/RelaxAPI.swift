//
//  API.swift
//  Relax
//
//  Created by Jo Albright on 1/11/16.
//  Copyright (c) 2016 Jo Albright. All rights reserved.
//
//


import Foundation

private let _s = API()

open class API: Defaultable {
    
    open class func session() -> API { return _s }
    
    open var baseURL: String = ""
    open var authURL: String = ""
    open var debugPrint: Bool = false
    
    open var authBasic: [String:String] = [:]
    open var authHeader: String = ""
    
    open var authTokenKey: String = "Starter"
    open var authToken: String {
        
        get { return load(authTokenKey + "Token") ?? "" }
        set { save(authTokenKey + "Token",newValue) }
        
    }
    
    public enum RequestLibraries {
        
        case relax
        case alamoFire
    
    }
    
    open var requestLibrary: RequestLibraries = .relax
    
    public required init() { }
    
    open func url(_ endpoint: Endpoint) throws -> String {
        
        return try Relax.url(endpoint, api: self)
        
    }
    
    open func request(_ endpoint: Endpoint, response: @escaping Response) {
        
        Relax.request(endpoint, response: response, api: self)
        
    }
    
    open func start() { }
    
    open func update(_ c: (API) -> Void) -> Self {
        
        c(self); return self
        
    }
    
    open func loginDetails() -> (auth: Endpoint, authCode: Endpoint) {
        
        return (Endpoint(path: ""), Endpoint(path: ""))
        
    }
    
    
    public enum PrintEmotion: String { case debug = "🤔", warning = "🤢", error = "😡", deprecated = "🚧" }
    
    public func log(emotion: PrintEmotion = .debug, _ items: Any...) {
        
        if debugPrint {
         
            print(emotion.rawValue, "//////////////////////")
            for item in items { print(emotion.rawValue, "//////////////////////", item) }
            print(emotion.rawValue, "//////////////////////")
            
        }
        
    }
    
}



