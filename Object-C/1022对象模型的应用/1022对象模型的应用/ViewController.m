//
//  ViewController.m
//  1022对象模型的应用
//
//  Created by ChuckonYin on 15/10/22.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    Class newclass = objc_allocateClassPair([UIView class], "CYView", 0);
    
    class_addMethod(newclass, @selector(test), (IMP)testFunction1, "v@:");
    
    objc_registerClassPair(newclass);
    
    id p = [[newclass alloc] init];
    
    [p performSelector:@selector(test)];
    
    class_replaceMethod(newclass, @selector(test), (IMP)testFunction2, "v@:");
    
    [p performSelector:@selector(test)];
    
//    class_addMethod([UIView class], @selector(cy_setBackgroudColor), (IMP)testFunction1, "v@:");
    
    class_replaceMethod([UIView class], @selector(setBackgroundColor:), (IMP)cy_setBackgroudColor, "v@:");
    
    self.view.backgroundColor = [UIColor redColor];
    
    NSMutableArray *arr1 = [[NSMutableArray alloc] init];
    for (int i=0; i<10; i++) {
        Person *p = [[Person alloc] init];
        p.age = 10;
        [arr1 addObject:p];
    }
    NSMutableArray *arr2 = [[NSMutableArray alloc] init];
    for (int i=0; i<10; i++) {
        Person *p = arr1[i];
        p.age = 20;
        [arr2 addObject:p];
    }
//    NSLog(@"%@",arr2);
    
    NSNumber *num1 = @1;
    NSNumber *num2 = @2;
    NSNumber *num3 = @33;
    
    NSLog(@"%p",num1);
    NSLog(@"%p",num2);
    NSLog(@"%p",num3);
    
    Person *p1 = [[Person alloc] init];
    NSLog(@"%p",p1);
}

void testFunction1(id self, SEL _cmd)
{
    NSLog(@"动态创建一个类成功");
}
void cy_setBackgroudColor()
{
    NSLog(@"uiview实现自定义方法");
}
void testFunction2(id self, SEL _cmd){
    printf("class的方法被替换");
}


@end




