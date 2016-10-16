//
//  ViewController.m
//  20160201NSOperation
//
//  Created by ChuckonYin on 16/2/1.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSOperationQueue *queque = [[NSOperationQueue alloc] init];
    [queque addOperationWithBlock:^{
        NSLog(@"diyige");
    }];
    [queque addOperationWithBlock:^{
        NSLog(@"dierge");
    }];
//    [queque addOperations:<#(nonnull NSArray<NSOperation *> *)#> waitUntilFinished:<#(BOOL)#>];
    
    
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        
    }];
    
}

@end
