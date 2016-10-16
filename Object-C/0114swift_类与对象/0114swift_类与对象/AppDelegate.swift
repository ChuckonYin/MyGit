//
//  AppDelegate.swift
//  0114swift_类与对象
//
//  Created by ChuckonYin on 16/1/14.
//  Copyright © 2016年 PingAn. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.window?.rootViewController = ViewController()
        
        self.window?.backgroundColor = UIColor.whiteColor()
        
        return true
    }
}

