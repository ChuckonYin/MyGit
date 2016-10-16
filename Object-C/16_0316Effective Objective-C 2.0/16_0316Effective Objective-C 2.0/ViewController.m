//
//  ViewController.m
//  16_0316Effective Objective-C 2.0
//
//  Created by ChuckonYin on 16/3/16.
//  Copyright © 2016年 PingAn. All rights reserved.
//
/*
1、+(void)load、initialize方法
   1）load加载顺序为：系统框架－>分类－>类。因此，方法体中避免使用非系统框架的类。
   2）initialize与load用法相似，但非程序启动时加载，在类被使用时加载（懒加载）。
   3）load、initialize的加载都会阻塞线程，尽量精简方法的代码。

2、timer的循环引用问题。
   1）在反复执行的timer中，目标析构时，timer还未invalidate，会导致内存泄漏。
   2）修复方法：用block的形式把任务抛给timer来打破循环，详见"NSTimer + YYAdd.h"。

3、for in 
   1）遍历可变数组的时候，如果你再遍历里面添加或者删除元素的时候，枚举器可能会分配错误的元素数据，甚至崩溃
    因为对于数组的变成，for in 遍历的枚举器是不知道容器的数据变更的
    而普通的for 循环遍历是知道的，但是效率上略慢一点点
 
 
*/







#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    
    
    
    
    
    
    
}

@end
