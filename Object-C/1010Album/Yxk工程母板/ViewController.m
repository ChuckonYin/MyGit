//
//  ViewController.m
//  Yxk工程母板
//
//  Created by yxk-yxk on 15/9/21.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()<UIScrollViewDelegate>
{
    NSMutableArray *_viewArr;
    CGFloat _oldX;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(30, 150, kScreenWidth-60, 400)];
    scroll.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:scroll];
    scroll.contentSize = CGSizeMake(1000, 0);
    scroll.delegate = self;
    scroll.pagingEnabled = YES;
    scroll.clipsToBounds = YES;
    
    _viewArr = [[NSMutableArray alloc] init];
    for (int i=0; i<3; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(-1000, 50, kScreenWidth/3, 300)];
        if (i==0) {
            view.backgroundColor = [UIColor redColor];
            view.center = CGPointMake(0, 200);
        }
        if (i==1) {
            view.backgroundColor = [UIColor blueColor];
            view.center = CGPointMake(kScreenWidth/2, 200);
        }
        if (i==2) {
            view.backgroundColor = [UIColor brownColor];
            view.center = CGPointMake(kScreenWidth, 200);
        }
        [scroll addSubview:view];
        [_viewArr addObject:view];
    }
    
//    [scroll scrollRectToVisible:CGRectMake(300, 0, kScreenWidth-60, 400) animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat x = scrollView.contentOffset.x;

    [scrollView scrollRectToVisible:CGRectMake(0, 0, kScreenWidth-60, 400) animated:YES];
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    CGPoint p = [[touches anyObject] locationInView:self.view];
//    _oldX = p.x;
//}
//
//-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    CGPoint p = [[touches anyObject] locationInView:self.view];
//    CGFloat moveX = p.x - _oldX;
//    for (UIView *view in _viewArr) {
//        CGFloat centerX = view.center.x;
//        view.center = CGPointMake(centerX + moveX, 300);
//    }
//    _oldX = _oldX + moveX;
//}
//-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    _oldX = 0;
//}


@end
