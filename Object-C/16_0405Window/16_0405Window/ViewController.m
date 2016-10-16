//
//  ViewController.m
//  16_0405Window
//
//  Created by ChuckonYin on 16/4/5.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import "CYPopWindow.h"
#import "CYPopViewFactory.h"

@interface ViewController ()

//@property (nonatomic, strong) CYPopWindow *widow;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[CYPopWindow share] show];
//    
//    [[CYPopWindow share] dismiss];
    [CYPopViewFactory showPopView];
}




@end
