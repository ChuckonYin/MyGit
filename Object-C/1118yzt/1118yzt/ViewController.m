//
//  ViewController.m
//  1118yzt
//
//  Created by ChuckonYin on 15/11/18.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    dict[@"aa"] = @"aa";
    NSLog(@"%@",dict);
    
    UIApplication *app = [UIApplication sharedApplication];
    app.applicationIconBadgeNumber = 1;
    app.applicationIconBadgeNumber = 2;
    
//    NSString *num = @"1234.999";
//    //1235
//    NSString *newNum = [NSString stringWithFormat:@"%i", (int)(round([num floatValue]))];
//    
//    NSInteger lenght = newNum.length;
//    
//    //分母
//    NSMutableString  *fenmu = [NSMutableString stringWithString:@"1"];
//    for (int i=0; i<lenght-1; i++) {
//        fenmu = [NSMutableString stringWithString:[fenmu stringByAppendingString:@"0"]];
//    }
//    NSInteger resutNum = [newNum
//
}




@end
