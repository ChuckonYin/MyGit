//
//  ViewController.m
//  16_0517CADisplayLink
//
//  Created by ChuckonYin on 16/5/17.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *arrow;

@property (nonatomic, assign) CGFloat angle;

@property (nonatomic, strong) CADisplayLink *link;

@end

@implementation ViewController

- (instancetype)init{
    if (self = [super init]) {
        _arrow = nil;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _angle = 0.0f;
    
    [self.view addSubview:self.arrow];
    
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(reDraw)];
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    _link.frameInterval = 6;
    
    
//    [NSTimer scheduledTimerWithTimeInterval:0.0001 target:self selector:@selector(reDraw) userInfo:nil repeats:YES];
}

- (void)reDraw{
    self.arrow.transform = CGAffineTransformMakeRotation(_angle);
    _angle += 0.1;
    NSLog(@"%f", self.arrow.transform.a);
}

- (void)dealloc{
    NSLog(@"dealloc");
}

- (UIView *)arrow{
    if (!_arrow) {
        _arrow = [[UIView alloc] initWithFrame:CGRectMake(50, 200, 250, 20)];
        _arrow.backgroundColor = [UIColor redColor];
    }
    return _arrow;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    _link.paused = !_link.paused;
    [self.navigationController pushViewController:[ViewController new] animated:YES];
}



@end
