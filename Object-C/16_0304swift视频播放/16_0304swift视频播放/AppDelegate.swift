//
//  AppDelegate.swift
//  16_0304swift视频播放
//
//  Created by ChuckonYin on 16/3/4.
//  Copyright © 2016年 PingAn. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window?.rootViewController = UINavigationController.init(rootViewController: ViewController())
        return true
    }
}

