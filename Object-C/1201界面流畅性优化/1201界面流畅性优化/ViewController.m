//
//  ViewController.m
//  1201界面流畅性优化
//
//  Created by ChuckonYin on 15/12/1.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, strong) UIView *moveView;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = @[@1,@2];
    NSArray *tmp = self.array;
    self.array = nil;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [tmp class];
    });
    
    NSAttributedString *attrStr = nil;
//    [attrStr boundingRectWithSize:<#(CGSize)#> options:<#(NSStringDrawingOptions)#> context:(nullable NSStringDrawingContext *)];
//    [attrStr drawWithRect:<#(CGRect)#> options:<#(NSStringDrawingOptions)#> context:<#(nullable NSStringDrawingContext *)#>];
    /**
     *  CoreText 对象创建好后，能直接获取文本的宽高等信息，避免了多次计算（调整 UILabel 大小时算一遍、UILabel 绘制时内部再算一遍
     */
    //view每次改变尺寸都会调用
    [self.view sizeThatFits:self.view.bounds.size];
    //遍历换这个
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    _moveView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:_moveView];
    _moveView.backgroundColor = [UIColor redColor];
    
    [self move];
}

- (void)move
{
    NSLog(@"%@",[self getTimeNow]);
    _moveView.frame = CGRectMake(0, _moveView.frame.origin.y + 10, 100, 100);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self move];
    });
}

- (NSString *)getTimeNow
{
    NSString* date;
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    //[formatter setDateFormat:@"YYYY.MM.dd.hh.mm.ss"];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss:SSS"];
    date = [formatter stringFromDate:[NSDate date]];
//    timeNow = [[NSString alloc] initWithFormat:@"%@", date];
//    NSLog(@"%@", timeNow);
    return date;
}






@end






