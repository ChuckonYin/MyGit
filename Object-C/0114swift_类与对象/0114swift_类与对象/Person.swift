//
//  Person.swift
//  0114swift_类与对象
//
//  Created by ChuckonYin on 16/1/14.
//  Copyright © 2016年 PingAn. All rights reserved.
//

import UIKit

protocol Personprotocol : class
{
    func persenSendSomthing();
}
class Person: NSObject {
    //类属性
    internal var name:String{
        get{
            return "老尹"
        }
        set{
            newValue
        }
    }
    var age:Int8
    var sex:String
    weak var delegate : Personprotocol?
    
    //构造方法
    init(name newName:String, age newAge:Int8) {
        age = newAge
        sex = "女"
    }
    func sayHisName() ->String{
        return name
    }
    func sayHisAge() ->Int8{
        return self.age;
    }
    func sayHisSex(){
        if (sex == "男"){
            print("我是爷们")
        }
        else{
            print("我是美女")
        }
    }
    internal func initWithName(name:NSString)->Person{
        return Person(name: "尹绪坤", age: 26)
    }
    internal func name(name:String){
        self.name = name;
        
    }
    
}

private extension Person{
    class func function0(){
        
    }
    private func function1(){
        
    }
}
extension Person{
    internal func function2(){
        
    }
    func function3(){
        
    }
}














