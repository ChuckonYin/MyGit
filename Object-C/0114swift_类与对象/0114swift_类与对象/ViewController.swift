//
//  ViewController.swift
//  0114swift_类与对象
//
//  Created by ChuckonYin on 16/1/14.
//  Copyright © 2016年 PingAn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        var p = Person(name: "Chuckon", age: 26)
        
        p = Person(name: "00",age: 9)
        
        p.name = "yxk"
        
        print(p.name+"  ii");
        
        p.sayHisAge()
        
        p.sayHisSex()
        
        p.sex = "男"
        
        p.sayHisSex()
        
        p.function2()
        p.function3()
        
        p.name = "dd";
        
        
        AppManager.share;
        
        AppManager.share.printClassName()
        
        for index in 1...5{
            print(index);
        }
        
        let dict = ["1":"one"]
        for (key, value) in dict{
            print(key+"    "+value);
        }
        
        let oldArr = [1,2,3];
        let newArr = oldArr.filter({$0 > 1})
        print(newArr)
    }
    
    func creatHeaderWith(frame : CGRect, color : UIColor = UIColor.whiteColor()){
        color
        frame
    }
}







