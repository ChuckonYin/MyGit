//
//  ViewController.m
//  1022cell高度计算
//
//  Created by ChuckonYin on 15/10/22.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import <UITableView+FDTemplateLayoutCell.h>
#define  kScreenWidth [[UIScreen mainScreen] bounds].size.width

@interface ViewController ()

@property (atomic, assign) NSInteger rec;

@property (nonatomic, assign) BOOL isActive;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _isActive = YES;
    _rec = 0;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 150, kScreenWidth, 400) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"hhhh");
        printf("");
    });
    
    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(act) userInfo:nil repeats:YES];
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.2 target:self selector:@selector(act) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    [timer fire];
    
    while (_isActive) {
        NSLog(@"循环");
    }
}

-(void)act{
    _rec ++;
    if (_rec == 10) {
           NSLog(@"fsfsdfsdf");
    }
 
}






@end


