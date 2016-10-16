//
//  AssetsDetailView.m
//  1106流动性扫描图
//
//  Created by ChuckonYin on 15/11/6.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#define leftGap 40.0f
#define rightGap 40.0f
#define xGap 46.0f
#define yGap 36.0f
#define zeroP CGPointMake(leftGap, 130.0f)

#import "AssetsDetailView.h"
@interface AssetsDetailView ()
{
    UIView *_dataView;
    CGFloat _mHight;
    CGFloat _mWidth;
//    CGPoint _zeroP;
}
@property (nonatomic, strong) AssetsDetailDataView *detailDataView;
@end

@implementation AssetsDetailView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _mHight = frame.size.height;
        _mWidth = frame.size.width;
        
        [self addScrollView];
        [self addLeftDataView];
    }
    return self;
}

-(void)addScrollView
{
    _scroll = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:_scroll];
    _scroll.contentSize = CGSizeMake(1000, 0);
    
    _detailDataView = [[AssetsDetailDataView alloc] initWithFrame:CGRectMake(0, 0, 1000, _mHight)];
    _detailDataView.backgroundColor = [UIColor clearColor];
    [_scroll addSubview:_detailDataView];
    
//    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(200, 0, 100, 30)];;
//    [_detailDataView addSubview:v];
//    v.backgroundColor = [UIColor blackColor];
    
}
-(void)addLeftDataView
{
    _dataView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftGap, _mHight)];
    [self addSubview:_dataView];
    _dataView.backgroundColor = [UIColor whiteColor];
}


- (void)drawRect:(CGRect)rect {
    
    UIBezierPath *yPath = [UIBezierPath bezierPath];
    [yPath moveToPoint:CGPointMake(zeroP.x + 0.5, zeroP.y-2*yGap-15)];
    [yPath addLineToPoint:CGPointMake(zeroP.x + 0.5, zeroP.y+2*yGap)];
    [[UIColor grayColor] setStroke];
    yPath.lineWidth = 1;
    [yPath stroke];
    
    for (int i=0; i<5; i++) {
        UIBezierPath *xPath = [UIBezierPath bezierPath];
        [xPath moveToPoint:CGPointMake(0, zeroP.y + (i-2)*yGap)];
        [xPath addLineToPoint:CGPointMake(_mWidth, zeroP.y + (i-2)*yGap)];
        if (i==2) {
            xPath.lineWidth = 1;
        }
        else{
            xPath.lineWidth = 0.5;
        }
        //0xebebeb
        [[UIColor grayColor] setStroke];
        [xPath stroke];
    }
}

@end

@interface AssetsDetailDataView()
{
    //居中横坐标
    CGFloat _middleX;
}
@end

@implementation AssetsDetailDataView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        NSLog(@"%f",xGap);
        _middleX = [[UIScreen mainScreen]bounds].size.width/2;
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    //日期起始点居中
    UIBezierPath *yPath = [UIBezierPath bezierPath];
    for (int i=-5; i<50; i++) {
        [yPath moveToPoint:CGPointMake(_middleX + i*xGap, zeroP.y-2*yGap-15)];
        [yPath addLineToPoint:CGPointMake(_middleX + i*xGap, zeroP.y+2*yGap)];
        
        if (i>=0) {
            CGPoint corniceP = CGPointMake(_middleX + i*xGap, zeroP.y);
            [self addCorniceAtPoint:corniceP height:(arc4random()%2?1:-1)*(CGFloat)(arc4random()%10)/10];
        }
    }
    [[UIColor grayColor] setStroke];
    yPath.lineWidth = 0.5;
    [yPath stroke];
}
/**
 *  添加柱状图 柱宽18 总高72
 *
 *  @param p 添加柱状图的位置
 *  @param h 添加柱状图的高度 0-1.0
 */
-(void)addCorniceAtPoint:(CGPoint)p height:(CGFloat)h
{
    UIView *bgView = [[UIView alloc] init];
    [self addSubview:bgView];
    
    UIView *cornice = [[UIView alloc] init];
    [bgView addSubview:cornice];
    cornice.layer.cornerRadius = 2;
    cornice.clipsToBounds = YES;
    
    if (h>0) {
        cornice.frame = CGRectMake(0, 72*(1-h), 18, 72*2*h);
        bgView.frame = CGRectMake(p.x-9, p.y-72, 18, 72);
        cornice.backgroundColor = [UIColor orangeColor];
    }
    else{
        cornice.frame = CGRectMake(0, -72*(1+h), 18, -72*2*h);
        bgView.frame = CGRectMake(p.x-9, p.y, 18, 72);
        cornice.backgroundColor = [UIColor lightGrayColor];
    }
    bgView.clipsToBounds = YES;
    
    UILabel *dateLab = [[UILabel alloc] initWithFrame:CGRectMake(p.x-23, p.y+75, 46, 14)];
    dateLab.text = @"日期";
    dateLab.font = [UIFont systemFontOfSize:12];
    dateLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:dateLab];
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint p = [[touches anyObject] locationInView:self];
    NSLog(@"%f",p.x);
    NSInteger index = roundf((p.x-_middleX)/xGap);
    NSLog(@"点击%li",index);
}

@end

