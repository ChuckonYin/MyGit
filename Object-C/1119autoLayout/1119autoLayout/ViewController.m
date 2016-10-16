//
//  ViewController.m
//  1119autoLayout
//
//  Created by ChuckonYin on 15/11/19.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"

#define NSLog(format, ...) do {                                                                          \
fprintf(stderr, "<%s : %d> %s\n",                                           \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
__LINE__, __func__);                                                        \
(NSLog)((format),##__VA_ARGS__);                                           \
fprintf(stderr, "-------\n");                                               \
} while (0)

@interface ViewController ()
@property (nonatomic, strong) UIView *firstCenterView;
@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"");

    _firstCenterView = [UIView new];
    _firstCenterView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_firstCenterView];
    
    //关闭自动伸缩，storyboard和xib默认是关闭的。
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_firstCenterView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint *cst1 = [NSLayoutConstraint constraintWithItem:_firstCenterView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:40];
    
    NSLayoutConstraint *cst2 = [NSLayoutConstraint constraintWithItem:_firstCenterView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:40];
    
    NSLayoutConstraint *cst3 = [NSLayoutConstraint constraintWithItem:_firstCenterView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-40];
    
    NSLayoutConstraint *cst4 = [NSLayoutConstraint constraintWithItem:_firstCenterView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-40];
    
    NSArray *arr = [NSArray arrayWithObjects:cst1, cst2, cst3, cst4, nil];
    [self.view addConstraints:arr];
    
    
//    [self.view setBackgroundColor:[UIColor redColor]];
//    //创建子view
//    UIView *subView = [[UIView alloc] init];
//    [subView setBackgroundColor:[UIColor blackColor]];
//    //将子view添加到父视图上
//    [self.view addSubview:subView];
//    //使用Auto Layout约束，禁止将Autoresizing Mask转换为约束
//    [subView setTranslatesAutoresizingMaskIntoConstraints:NO];
//    //layout 子view
//    //子view的上边缘离父view的上边缘40个像素
//    NSLayoutConstraint *contraint1 = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:40.0];
//    //子view的左边缘离父view的左边缘40个像素
//    NSLayoutConstraint *contraint2 = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:40.0];
//    //子view的下边缘离父view的下边缘40个像素
//    NSLayoutConstraint *contraint3 = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-40.0];
//    //子view的右边缘离父view的右边缘40个像素
//    NSLayoutConstraint *contraint4 = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-40.0];
//    //把约束添加到父视图上
//    NSArray *array = [NSArray arrayWithObjects:contraint1, contraint2, contraint3, contraint4, nil];
//    [self.view addConstraints:array];
//
    /**
     *    子view在父view的中间，且子view长300，高200。
     */
    [self.view setBackgroundColor:[UIColor redColor]];
    //创建子view
    UIView *subView = [[UIView alloc] init];
    [subView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:subView];
    //使用Auto Layout约束，禁止将Autoresizing Mask转换为约束
    [subView setTranslatesAutoresizingMaskIntoConstraints:NO];
    //layout 子view
    //子view的中心横坐标等于父view的中心横坐标
    NSLayoutConstraint *constrant1 = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    //子view的中心纵坐标等于父view的中心纵坐标
    NSLayoutConstraint *constrant2 = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
    //子view的宽度为300
    NSLayoutConstraint *constrant3 = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:300.0];
    //子view的高度为200
    NSLayoutConstraint *constrant4 = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:200.0];
    //把约束添加到父视图上
    NSArray *array = [NSArray arrayWithObjects:constrant1, constrant2, constrant3, constrant4, nil];
    [self.view addConstraints:array];
}
-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"");
}
- (void)viewWillLayoutSubviews
{
    NSLog(@"");
}




@end
