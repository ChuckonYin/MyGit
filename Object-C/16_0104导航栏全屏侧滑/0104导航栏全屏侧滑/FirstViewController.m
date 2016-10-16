//
//  FirstViewController.m
//  0104导航栏全屏侧滑
//
//  Created by ChuckonYin on 16/1/4.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()<UIGestureRecognizerDelegate>

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
//    NSLog(@"%@", self.navigationController.view.gestureRecognizers);
//    
//    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
//    [self.view addGestureRecognizer:pan];
//    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
//    pan.delegate = self;
}

//-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
////    if (self.navigationController.viewControllers.count==1 && [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
////        return NO;
////    }
////    else{
////        return YES;
////    }
//}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    
//}


@end
