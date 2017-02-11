//
//  MartaAPI.swift
//  Relax
//
//  Created by Jo Albright on 2/10/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit


// Documentation : http://www.itsmarta.com/app-developer-resources.aspx

private let _m = MartaAPI()

open class MartaAPI: API {
    
    open override class func session() -> MartaAPI { return _m }
    
    open override func start() {
        
        baseURL = "http://developer.itsmarta.com/"
        
    }
    
    public enum Endpoints: String {
        
        // Realtime Locations
        
        case bus
        case train
        
        
        public var endpoint: Endpoint { return _endpoints[self]! }
        
        var _endpoints: [Endpoints:Endpoint] {
            
            return [
                
                // Realtime Locations
                
                .bus : Endpoint(path: "BRDRestService/RestBusRealTimeService/GetAllBus"),
                .train : Endpoint(path: "RealtimeTrain/RestServiceNextTrain/GetRealtimeArrivals", requiredParameters: ["apikey"]),
                
            ]
            
        }
        
    }
    
    
}
