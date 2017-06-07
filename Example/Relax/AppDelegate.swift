//
//  AppDelegate.swift
//  Relax
//
//  Created by Jo Albright on 01/11/2016.
//  Copyright (c) 2016 Jo Albright. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barStyle = .black
        
        return true
    }

}

