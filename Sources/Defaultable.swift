//
//  Defaultable.swift
//  Relax
//
//  Created by Jo Albright on 1/11/16.
//  Copyright (c) 2016 Jo Albright. All rights reserved.
//
//


import Foundation


private let _d = UserDefaults.standard

public protocol Defaultable { }

extension Defaultable {
    
    public func load<T>(_ k: String) -> T? { return _d.object(forKey: k) as? T }
    public func save<T>(_ k: String, _ v: T) { _d.set(v, forKey: k) }
    
}
