//
//  GestureViewController.m
//  16_0518导航栏问题
//
//  Created by ChuckonYin on 16/5/18.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "GestureViewController.h"
#import "MSGViewController.h"
#import "AppDelegate.h"

@interface GestureViewController ()

@end

@implementation GestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.title = @"手势";
    
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    
    UINavigationController *rootCtrl = (UINavigationController *)[[UIApplication sharedApplication].delegate window].rootViewController;
    [rootCtrl.visibleViewController.navigationController setNavigationBarHidden:NO animated:YES];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [rootCtrl pushViewController:[MSGViewController new] animated:YES];
//    });
     [self dismissViewControllerAnimated:YES completion:nil];
    
    
   
}

@end
