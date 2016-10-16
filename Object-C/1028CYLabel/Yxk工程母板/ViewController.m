//
//  ViewController.m
//  Yxk工程母板
//
//  Created by yxk-yxk on 15/9/21.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import "CYLabel.h"

@interface ViewController ()
{
    NSMutableArray *arr;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CYLabel *label = [[CYLabel alloc] init];
    
    [self.view addSubview:label];

    label.frame = CGRectMake(50, 50, 300, 300);
    
    label.cy_BgColor([UIColor yellowColor]).cy_Font(12);
    
    [label test];
    

    NSLog(@"fs");
}


@end
