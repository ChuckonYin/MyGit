//
//  ViewController.m
//  1120runtime添加属性
//
//  Created by ChuckonYin on 15/11/20.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "UILabel+Associate.h"

const char * CYJumpToViewController = "CYJumpToViewController";
const char * fundName = "fundName";
//#define CYJumpToViewController "CYJumpToViewController"
//#define fundName "一账通宝"

@interface ViewController ()

//@property (nonatomic, assign) NSInteger rec;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    /**
     *  runtime 添加属性 。问题：为什么断点看不到添加的属性
     */
    objc_setAssociatedObject(self, @"rec", @3, OBJC_ASSOCIATION_ASSIGN);
    NSNumber *rec = objc_getAssociatedObject(self, @"rec");
    NSLog(@"%@",rec);
    
    UILabel *lab = [UILabel new];
    [self.view addSubview:lab];
    [lab setIdentifier:@"我是一个控件名"];
    NSString *oriName = [lab getIdentifer];
    [lab setIdentifier:@"我有新名字了"];
    NSString *newName = [lab getIdentifer];
    NSLog(@"%@____%@",oriName, newName);
    NSLog(@"%@",lab);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(jump)];
}
-(void)jump
{
    /**
     *  runtime 实现万能跳转
     */
    //现在要实现跳转至 CYJumpToViewController并确定属性fundName;

    
    Class NewClass = objc_getClass(CYJumpToViewController);
    
    id ctrl = (UIViewController*)[[NewClass alloc] init];
    
    [ctrl setValue:@"一账通宝" forKeyPath:@"fundName"];
    
    objc_setAssociatedObject(ctrl, @"color", [UIColor yellowColor], OBJC_ASSOCIATION_RETAIN);
    
    [self.navigationController pushViewController:ctrl animated:YES];
    
}







@end
