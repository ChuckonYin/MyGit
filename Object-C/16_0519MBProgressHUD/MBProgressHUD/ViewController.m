//
//  ViewController.m
//  MBProgressHUD
//
//  Created by ChuckonYin on 16/5/19.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@end



@implementation ViewController1

- (instancetype)init{
    if (self = [super init]) {
        NSLog(@"init___%@", [self.superclass class]);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    [UIView animateWithDuration:5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        view.transform = CGAffineTransformMakeTranslation(300, 400);
    } completion:^(BOOL finished) {
        
    }];
    
}


@end