//
//  ScrollViewController.m
//  16_0421objc中国_图形绘制
//
//  Created by ChuckonYin on 16/4/21.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "ScrollViewController.h"

@interface ScrollViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scroll;

@end

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.scroll.contentSize = CGSizeMake(1000, 0);
    [self.view addSubview:self.scroll];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.scroll.bounds = CGRectMake(200, 0, 200, 100);
    [self.view layoutIfNeeded];
}


- (UIView *)scroll{
    if (!_scroll) {
        _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(50, 50, 200, 100)];
//        _scroll.backgroundColor = [UIColor redColor];
        _scroll.delegate = self;
    }
    return _scroll;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%@", NSStringFromCGRect(scrollView.bounds));
    //log结果
//    [26719:329438] {{46, 0}, {200, 100}}
//    2016-04-21 18:01:15.348 16_0421objc中国_图形绘制[26719:329438] {{47, 0}, {200, 100}}
//    2016-04-21 18:01:16.571 16_0421objc中国_图形绘制[26719:329438] {{48.333333333333336, 0}, {200, 100}}
//    2016-04-21 18:01:16.597 16_0421objc中国_图形绘制[26719:329438] {{49.333333333333336, 0}, {200, 100}}
}






@end
