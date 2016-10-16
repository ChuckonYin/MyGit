//
//  ViewController.m
//  1227自定义导航栏
//
//  Created by ChuckonYin on 15/12/27.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import <objc/runtime.h>
@interface ViewController ()<UIGestureRecognizerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"first";
    self.view.backgroundColor = [UIColor brownColor];
    
    Class class = NSClassFromString(@"_UINavigationInteractiveTransition");
    id c = [[class alloc] init];
    NSLog(@"%@", c);
    
//    Method m;
//    method_setImplementation(m, imp_implementationWithBlock(^{
//        self.view.backgroundColor = [UIColor yellowColor];
//    }));
//    class_addMethod([self class], @selector(m), <#IMP imp#>, <#const char *types#>)
//    objc_get
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    SecondViewController *secondCtrl = [[SecondViewController alloc] init];
    [self.navigationController setNavigationBarSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width, 34)];
    
    [self.navigationController pushViewController:secondCtrl animated:YES completion:^(BOOL finished) {
        
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return YES;
}



@end
