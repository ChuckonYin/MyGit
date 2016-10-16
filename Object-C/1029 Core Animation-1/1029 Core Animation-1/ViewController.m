//
//  ViewController.m
//  1029 Core Animation-1
//
//  Created by ChuckonYin on 15/10/29.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import "DrawLayerViewController.h"
#import "CYAnimationView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    CYAnimationView *view = [[CYAnimationView alloc] initWithFrame:CGRectMake(20, 150, 150, 200)];
    [self.view addSubview:view];
    /**
     *  由于历史原因，只能是CGImage类型，CGImageRef要强转至cocoa对象
     */
    UIImage *img = [UIImage imageNamed:@"image.jpg"];
    view.layer.contents = (__bridge id)(img.CGImage);
    /**
     *  contentGravity
     */
//    view.layer.contentsGravity = kCAGravityTop;
    /**
     *  masksToBounds
     */
    view.layer.masksToBounds = YES;
    /**
     *  完整图为CGRectMake(0, 0, 1, 1);
     *
     *  @param 0   左上角x
     *  @param 0   左上角y
     *  @param 0.5 占image宽度比
     *  @param 0.5 占image高度比
     *
     *  @return 截取image的部分区域显示在视图上
     */
    view.layer.contentsRect = CGRectMake(0, 0, 0.5, 0.5);
    /**
     *  创建2个视图补全剩余3/4部分
     */
    UIView *addView1 = [[UIView alloc] initWithFrame:CGRectMake(172, 150, 150, 200)];
    [self.view addSubview:addView1];
    addView1.layer.masksToBounds = YES;
    addView1.layer.contents = (__bridge id)(img.CGImage);
    addView1.layer.contentsRect = CGRectMake(0.5, 0, 0.5, 0.5);
    
    UIView *addView2 = [[UIView alloc] initWithFrame:CGRectMake(20, 352, 300, 200)];
    [self.view addSubview:addView2];
    addView2.layer.masksToBounds = YES;
    addView2.layer.contents = (__bridge id)(img.CGImage);
    addView2.layer.contentsRect = CGRectMake(0, 0.5, 1, 0.5);
    /**
     *  图像拉伸
     */
//    view.layer.contentsCenter = CGRectMake(0.25, 0.25, 0.1, 0.1);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(push)];
}
- (void)push{
    [self.navigationController pushViewController:[DrawLayerViewController new] animated:YES];
}

@end






