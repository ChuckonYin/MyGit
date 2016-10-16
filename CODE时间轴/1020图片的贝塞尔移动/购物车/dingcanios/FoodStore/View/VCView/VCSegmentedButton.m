//
//  VCSegmentedButton.m
//  FoodStore
//
//  Created by liuguopan on 14/12/29.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import "VCSegmentedButton.h"

@interface VCSegmentedButton ()

@property (nonatomic, assign) NSInteger lastSelectedIndex;
@property (nonatomic, strong) UIButton *lastSelectedButton;

@end

@implementation VCSegmentedButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self addButton];
    }
    return self;
}

- (void)initData
{
    self.lastSelectedButton = nil;
    self.lastSelectedIndex = -1;
    self.currentSelectedIndex = -1;
}

- (void)addButton
{
    CGFloat btnWidth = SELF_WIDTH / 3;
    
    NSArray *btnNames = @[@"筛选", @"排序", @"其他"];
    
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnWidth * i, 0, btnWidth, SELF_HEIGHT);
        btn.backgroundColor = [UIColor clearColor];
        btn.tag = i;
        [btn setTitle:btnNames[i] forState:UIControlStateNormal];
        [btn setTitle:btnNames[i] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn addTarget:self action:@selector(vcSegmentedButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}

- (void)setTitle:(NSString *)title index:(NSInteger)index
{
    for (UIButton *btn in self.subviews) {
        if ([btn isKindOfClass:[UIButton class]] &&
            btn.tag == index) {
            [btn setTitle:title forState:UIControlStateNormal];
        }
    }
}

- (void)vcSegmentedButtonClick:(UIButton *)button
{
    LOG(@"vcsengmentedbutton");
    self.currentSelectedIndex = button.tag;
    [self setNeedsDisplay];
    if (self.lastSelectedButton) {  //  上一个选中的Button存在
        self.lastSelectedButton.selected = NO;
        if (self.lastSelectedIndex == button.tag) { //  上一次选择的Button和本次所选为同一个
            self.lastSelectedButton = nil;
            self.lastSelectedIndex = -1;
            self.currentSelectedIndex = -1;
        } else {                                    //  上一次选择的Button和本次所选不是同一个
            button.selected = YES;
            self.lastSelectedButton = button;
            self.lastSelectedIndex = button.tag;
        }
    } else {                        //  上一个选中的Button不存在（第一次选，或重新选择）
        button.selected = YES;
        self.lastSelectedButton = button;
        self.lastSelectedIndex = button.tag;
    }
    
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (void)cancelSelect
{
    self.lastSelectedButton.selected = NO;
    [self initData];
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGFloat width   = rect.size.width;
    CGFloat height  = rect.size.height;
    
    //  左侧竖线起点
    CGPoint leftStartPoint  = CGPointMake(width / 3, height / 2 - 15);
    //  左侧竖线终点
    CGPoint leftEndPoint    = CGPointMake(width / 3, height / 2 + 15);
    //  右侧竖线起点
    CGPoint rightStartPoint = CGPointMake(width / 3 * 2, height / 2 - 15);
    //  右侧竖线终点
    CGPoint rightEndPoint   = CGPointMake(width / 3 * 2, height / 2 + 15);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //  左侧竖线
    CGContextMoveToPoint(context, leftStartPoint.x, leftStartPoint.y);
    CGContextAddLineToPoint(context, leftEndPoint.x, leftEndPoint.y);
    //  右侧竖线
    CGContextMoveToPoint(context, rightStartPoint.x, rightStartPoint.y);
    CGContextAddLineToPoint(context, rightEndPoint.x, rightEndPoint.y);
    
    [[UIColor colorWithRed:0.92f green:0.92f blue:0.92f alpha:1.00f] setStroke];
    CGContextStrokePath(context);
    
    for (int i = 0; i < 3; i++) {
        [self drawSignInRect:rect index:i selected:NO];
    }
    
    if (self.lastSelectedIndex != -1) {
        [self drawSignInRect:rect index:self.lastSelectedIndex selected:NO];
    }
    if (self.currentSelectedIndex != -1) {
        [self drawSignInRect:rect index:self.currentSelectedIndex selected:YES];
    }

}

- (void)drawSignInRect:(CGRect)rect index:(NSInteger)index selected:(BOOL)isSelected
{
    CGFloat width   = rect.size.width;
    CGFloat height  = rect.size.height;
    CGFloat width_3 = width / 3;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    CGPoint signStartpoint  = CGPointMake(width * 146 / 640 + width_3 * index, height / 2);
    CGPoint signMidpoint    = CGPointMake(signStartpoint.x + 3, signStartpoint.y + 3.5);
    CGPoint signEenpoint    = CGPointMake(signStartpoint.x + 6, signStartpoint.y);
    
    CGContextMoveToPoint(context, signStartpoint.x, signStartpoint.y);
    CGContextAddLineToPoint(context, signMidpoint.x, signMidpoint.y);
    CGContextAddLineToPoint(context, signEenpoint.x, signEenpoint.y);
    
    if (isSelected) {
        [[UIColor redColor] setStroke];
    } else {
        [[UIColor colorWithRed:0.70f green:0.70f blue:0.70f alpha:1.00f] setStroke];
    }
    
    CGContextStrokePath(context);
}

@end
