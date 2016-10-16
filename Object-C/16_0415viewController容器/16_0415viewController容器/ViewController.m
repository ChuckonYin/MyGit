//
//  ViewController.m
//  16_0415viewController容器
//
//  Created by ChuckonYin on 16/4/15.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "ViewController.h"
#import "ChildViewController1.h"
#import "ChildViewController2.h"

@interface ViewController ()

@property (nonatomic, strong) ChildViewController1 *childCtrl1;

@property (nonatomic, strong) ChildViewController2 *childCtrl2;

@property (nonatomic, weak) UIViewController *currentCtrl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:self.childCtrl1];
    [self addChildViewController:self.childCtrl2];
    
    [self.view addSubview:self.childCtrl1.view];
    self.currentCtrl = self.childCtrl1;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UIViewController *toCtrl = nil;
    if (self.currentCtrl == self.childCtrl1) {
        toCtrl = self.childCtrl2;
    }
    else{
        toCtrl = self.childCtrl1;
    }
//    UIViewAnimationOptionLayoutSubviews            = 1 <<  0,
//    UIViewAnimationOptionAllowUserInteraction      = 1 <<  1, // turn on user interaction while animating
//    UIViewAnimationOptionBeginFromCurrentState     = 1 <<  2, // start all views from current value, not initial value
//    UIViewAnimationOptionRepeat                    = 1 <<  3, // repeat animation indefinitely
//    UIViewAnimationOptionAutoreverse               = 1 <<  4, // if repeat, run animation back and forth
//    UIViewAnimationOptionOverrideInheritedDuration = 1 <<  5, // ignore nested duration
//    UIViewAnimationOptionOverrideInheritedCurve    = 1 <<  6, // ignore nested curve
//    UIViewAnimationOptionAllowAnimatedContent      = 1 <<  7, // animate contents (applies to transitions only)
//    UIViewAnimationOptionShowHideTransitionViews   = 1 <<  8, // flip to/from hidden state instead of adding/removing
//    UIViewAnimationOptionOverrideInheritedOptions  = 1 <<  9, // do not inherit any options or animation type
//    
//    UIViewAnimationOptionCurveEaseInOut            = 0 << 16, // default
//    UIViewAnimationOptionCurveEaseIn               = 1 << 16,
//    UIViewAnimationOptionCurveEaseOut              = 2 << 16,
//    UIViewAnimationOptionCurveLinear               = 3 << 16,
//    
//    UIViewAnimationOptionTransitionNone            = 0 << 20, // default
//    UIViewAnimationOptionTransitionFlipFromLeft    = 1 << 20,
//    UIViewAnimationOptionTransitionFlipFromRight   = 2 << 20,
//    UIViewAnimationOptionTransitionCurlUp          = 3 << 20,
//    UIViewAnimationOptionTransitionCurlDown        = 4 << 20,
//    UIViewAnimationOptionTransitionCrossDissolve   = 5 << 20,
//    UIViewAnimationOptionTransitionFlipFromTop     = 6 << 20,
//    UIViewAnimationOptionTransitionFlipFromBottom  = 7 << 20,
    [self transitionFromViewController:self.currentCtrl toViewController:toCtrl duration:1 options:self.currentCtrl==self.childCtrl1?UIViewAnimationOptionTransitionCurlUp:UIViewAnimationOptionTransitionCurlDown animations:^{
    } completion:^(BOOL finished) {
        if (finished) self.currentCtrl = toCtrl;
    }];
}


- (ChildViewController1 *)childCtrl1{
    if (!_childCtrl1) {
        _childCtrl1 = [[ChildViewController1 alloc] init];
    }
    return _childCtrl1;
}

- (ChildViewController2 *)childCtrl2{
    if (!_childCtrl2) {
        _childCtrl2 = [[ChildViewController2 alloc] init];
    }
    return _childCtrl2;
}


@end
