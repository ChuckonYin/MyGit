//
//  ViewController.m
//  1015HMSegmentedControl
//
//  Created by ChuckonYin on 15/10/15.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import "HMSegmentedControl.h"

@interface ViewController ()

@property (nonatomic, strong) UISegmentedControl *sgmtControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    _sgmtControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
//    [self.view addSubview:_sgmtControl];
//    _sgmtControl.center = CGPointMake([[UIScreen mainScreen] bounds].size.width/2, 200);
//    _sgmtControl.backgroundColor = [UIColor lightGrayColor];
//    
//    _sgmtControl.sectionTitles = @[@"按钮1",@"按钮2"];
//    _sgmtControl.textColor = [UIColor redColor];
//    _sgmtControl.selectedTextColor = [UIColor whiteColor];
//    _sgmtControl.selectionIndicatorColor = [UIColor redColor];
//    _sgmtControl.segmentWidthStyle = 0;
//    _sgmtControl.selectionStyle = 2;

//    [_sgmtControl setIndexChangeBlock:^(NSInteger index) {
//        NSLog(@"%li",index);
//    }];

    _sgmtControl = [[UISegmentedControl alloc] initWithItems:@[@"按钮1",@"按钮2"]];
    _sgmtControl.frame = CGRectMake(0, 0, 200, 100);
    [self.view addSubview:_sgmtControl];
    _sgmtControl.center = CGPointMake([[UIScreen mainScreen] bounds].size.width/2, 200);
    _sgmtControl.backgroundColor = [UIColor lightGrayColor];
    _sgmtControl.tintColor = [UIColor redColor];
    
}

@end
