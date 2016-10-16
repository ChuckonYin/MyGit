//
//  ShapeViewController.m
//  1130渐变色
//
//  Created by ChuckonYin on 15/11/30.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ShapeViewController.h"
#import "GradientViewController.h"
#import "ColorProgressViewController.h"

@interface ShapeViewController ()
{
    NSInteger _timerRec;
}
@property (nonatomic, strong) NSTimer*timer;

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation ShapeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(push)];
    
    /**
     *  CAShapeself.shapeLayer完全依赖于CGPath
     */
    self.shapeLayer = [CAShapeLayer layer];
    
    self.shapeLayer.frame = CGRectMake(0, 0, 200, 200);
    self.shapeLayer.position = point(100, 300);
    self.shapeLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    [self.view.layer addSublayer:self.shapeLayer];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.shapeLayer.bounds];
    self.shapeLayer.path = path.CGPath;
    
    self.shapeLayer.strokeColor = [UIColor brownColor].CGColor;
    self.shapeLayer.lineWidth = 5;
    self.shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startTimer)]];
    self.shapeLayer.strokeStart = 0.0;
    self.shapeLayer.strokeEnd = 0.0;
    
}

-(void)startTimer{
    if (!_timer) {
        self.timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(timerProgress) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        _timerRec = 200;
    }
}

-(void)timerProgress{
    if (self.shapeLayer.strokeStart==0 && self.shapeLayer.strokeEnd<1.0) {
        self.shapeLayer.strokeEnd += 0.1;
    }
    else if (self.shapeLayer.strokeEnd>=1.0){
        self.shapeLayer.strokeStart += 0.1;
    }
    if (self.shapeLayer.strokeEnd==0) {
        self.shapeLayer.strokeStart = 0;
    }
    //此处同时移动起始和终止点在移动的过程中出现渲染bug。故先移动终止点至一个小于起始点的非法点，就不会画图。再移动起始点。
    if (self.shapeLayer.strokeStart==self.shapeLayer.strokeEnd) {
        self.shapeLayer.strokeEnd = 0;
    }
}

-(void)push
{
    [self.navigationController pushViewController:[ColorProgressViewController new] animated:YES];
}
@end
