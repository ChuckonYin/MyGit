//
//  ViewController.swift
//  0122swift
//
//  Created by ChuckonYin on 16/1/22.
//  Copyright © 2016年 PingAn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weak var mycar = Car()
        var a = 1
        a = 2
        print(CGRectZero)
        let tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Plain);
        print(tableView)
        
        let lab : UILabel = UILabel()
        lab.text = "1111"
        
        let labs0 : NSMutableArray = NSMutableArray()
        labs0.addObject(lab);
        
        let labs1 = labs0.mutableCopy()
        
        lab.text = "2222"
        
        print(labs0, labs1)
        
        if let img = UIImage(named: "123"){
            print(img)
        }
        else{
            
        }
        UIColor.whiteColor()
        let car : AnyObject = Car()
        let car1 = car as! Car
//        car.name = "法拉利"   erro
        
        let dates : [NSDate]
        let array : [String]
        
        let path = UIBezierPath()
        path.drawAnTriangle(10, length2: 20, length3: 30)
        path.moveToPoint(CGPointMake(0, 0))
        
        
        let callBack : (NSString, NSString)->Void = {_,_ in 
            
        }
        callBack("d", "e")
        print(callBack)
        
    }
    
    
    
}

