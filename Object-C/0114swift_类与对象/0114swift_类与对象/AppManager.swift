//
//  AppManager.swift
//  0114swift_类与对象
//
//  Created by ChuckonYin on 16/1/21.
//  Copyright © 2016年 PingAn. All rights reserved.
//

import UIKit

class AppManager: NSObject {

    internal static let share = AppManager()
    
    private var s0 = "chuckon"
    
    internal var s1 = "yin"
    
    private override init() {
        s0 = "1"
        s1 = "2"
    }
    internal func printClassName()->String{
        print(NSStringFromClass(AppManager))
        if s0==s1 && s0=="1" {
            print("equae")
        }
        if AppManager.share.isKindOfClass(NSObject) {
            
        }
        return "AppManager"
    }
    private func doNothing(){
        
    }
    class func AppManagerDoSomething(){
    }

    
}
