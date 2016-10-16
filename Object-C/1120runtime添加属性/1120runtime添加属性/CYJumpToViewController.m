//
//  CYJumpToViewController.m
//  1120runtime添加属性
//
//  Created by ChuckonYin on 15/11/20.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "CYJumpToViewController.h"
#import <objc/runtime.h>

@interface CYJumpToViewController ()

@end

@implementation CYJumpToViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _fundName;
    
    self.view.backgroundColor = objc_getAssociatedObject(self, @"color");
    
    
    
}



@end








