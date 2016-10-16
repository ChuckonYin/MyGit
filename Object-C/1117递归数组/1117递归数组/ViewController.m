//
//  ViewController.m
//  1117递归数组
//
//  Created by ChuckonYin on 15/11/17.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    [self getYdscArr:nil andMaxAmount:19999.0f lineCount:5 unit:nil minAmount:0 callBack:^(NSArray *arr) {
        NSLog(@"%@",arr);
    }];
}

- (void)getYdscArr:(NSMutableArray*)dscArr andMaxAmount:(double)max lineCount:(NSInteger)count unit:(NSString*)unitStr minAmount:(CGFloat)min callBack:(void(^)(NSArray*))callback;
{
    NSMutableArray *newDscArr = dscArr;
    if (!newDscArr) {
        newDscArr = [NSMutableArray new];
        //亿
        if (max>100000000) {
            max = ceilf(max/10000000)/10;
            unitStr = @"亿";
        }
        else if (max>10000){
            max = ceilf(max/1000)/10;
            unitStr = @"万";
        }
        else{
            max = max;
            unitStr = @"";
        }
        min = max/((count-1)/2);
    }
    if (unitStr.length==0) {
        [newDscArr addObject:[NSString stringWithFormat:@"%.0f%@", max, unitStr]];
    }
    else{
        [newDscArr addObject:[NSString stringWithFormat:@"%.1f%@", max, unitStr]];
    }
    if (newDscArr.count < count) {
        [self getYdscArr:newDscArr andMaxAmount:max-min lineCount:count unit:unitStr minAmount:min callBack:callback];
    }
    else{
        callback(newDscArr);
    }
}



@end
