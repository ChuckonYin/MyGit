//
//  MSGViewController.m
//  16_0518导航栏问题
//
//  Created by ChuckonYin on 16/5/18.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "MSGViewController.h"

@interface MSGViewController ()

@property (nonatomic, assign) id delegate;

@end

@implementation MSGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"消息中心";
    
    self.view.backgroundColor = [UIColor brownColor];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    
    
    
    
}

//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
////    self.navigationController.navigationBar.hidden = NO;
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//}


@end
