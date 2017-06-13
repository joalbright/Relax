//
//  RelaxObject.swift
//  Relax
//
//  Created by Jo Albright on 2/10/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

public protocol ParsableRequest {
    
    static var session: API? { get set }

}

extension ParsableRequest {
    
    public static func makeRequest(_ endpoint: Endpoint, completion: @escaping (_ object: Self) -> Void) {
        
        session?.request(endpoint) { info, error in
            
            guard let info = info else { return }
            
            print(info)
//            completion(Self(info))
            
        }
        
    }
    
}

public class RelaxObject: Codable, ParsableRequest {
    
    public static var session: API?
    
}
