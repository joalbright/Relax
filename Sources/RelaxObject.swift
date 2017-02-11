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

extension ParsableRequest where Self: Parsable {
    
    public static func makeRequest(_ endpoint: Endpoint, completion: @escaping (_ object: Self) -> Void) {
        
        session?.request(endpoint) {
            
            guard let info = $0.0 else { return }
            completion(Self(info))
            
        }
        
    }
    
}

public class RelaxObject: Parsable, ParsableRequest {
    
    public static var session: API?
    
    public required init(_ info: ParsedInfo) {
        
        
        
    }
    
}
