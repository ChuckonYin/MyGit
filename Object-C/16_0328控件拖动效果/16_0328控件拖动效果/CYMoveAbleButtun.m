//
//  CYMoveAbleButtun.m
//  16_0328控件拖动效果
//
//  Created by ChuckonYin on 16/3/28.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "CYMoveAbleButtun.h"

@interface CYMoveAbleButtun()

@property (nonatomic, assign) BOOL cy_canMove;

@property (nonatomic, weak) id targetCache;

@property (nonatomic, assign) SEL targetSELCache;
@end

@implementation CYMoveAbleButtun

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addTarget:self action:@selector(cy_touchDown: withEvent:) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(cy_dragMoving:withEvent:)forControlEvents: UIControlEventTouchDragInside];
        [self addTarget:self action:@selector(cy_dragEnded:withEvent:)forControlEvents: UIControlEventTouchUpInside |
         UIControlEventTouchUpOutside];
    }
    return self;
}

- (void)cy_touchDown:(UIControl *)control withEvent:event{
    [self performSelector:@selector(cy_beginMoving:) withObject:control afterDelay:0.5];
    if (_delegate && [_delegate respondsToSelector:@selector(cy_moveAbleButtunTouchDown:withEvent:)]) {
        [_delegate cy_moveAbleButtunTouchDown:self withEvent:event];
    }
}

- (void)cy_dragMoving:(UIControl *)c withEvent:ev
{
    if (!self.cy_canMove) return;
    CGPoint center = [[[ev allTouches] anyObject] locationInView:self.superview];
    c.transform = CGAffineTransformMakeTranslation(center.x - c.center.x, center.y - c.center.y);
    if (_delegate && [_delegate respondsToSelector:@selector(cy_moveAbleButtunDragMoving:withEvent:)]) {
        [_delegate cy_moveAbleButtunDragMoving:self withEvent:ev];
    }
}

- (void)cy_dragEnded:(UIControl *)c withEvent:ev
{
    self.cy_canMove = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self cy_refreshUIStart:NO];
    
    if (_delegate && [_delegate respondsToSelector:@selector(cy_moveAbleButtunDragEnded:withEvent:)]) {
        [_delegate cy_moveAbleButtunDragEnded:self withEvent:ev];
    }
    if (_targetCache && [_targetCache respondsToSelector:_targetSELCache]) {
        [_targetCache performSelector:_targetSELCache withObject:self];
    }
}

- (void)cy_beginMoving:(UIControl *)control{
    if (control.state != UIControlStateNormal) {
        self.cy_canMove = YES;
        [self cy_refreshUIStart:YES];
    }
}

- (void)cy_refreshUIStart:(BOOL)start{
    //开始移动
    if (start) {
        self.transform = CGAffineTransformMakeTranslation(3, -3);
        self.layer.shadowColor = self.backgroundColor.CGColor;//shadowColor阴影颜色
        self.layer.shadowOffset = CGSizeMake(-4,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        self.layer.shadowOpacity = 0.4;//阴影透明度，默认0
        self.layer.shadowRadius = 5;//阴影半径，默认3
    }
    //终止移动
    else{
        self.transform = CGAffineTransformMakeTranslation(0, 0);
        self.layer.shadowColor = [UIColor clearColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    }
}

#pragma mark - super SEL

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    //私有方法，直接执行
    if (action == @selector(cy_dragEnded:withEvent:) || action == @selector(cy_dragMoving:withEvent:) || action == @selector(cy_touchDown:withEvent:)) {
        [super addTarget:target action:action forControlEvents:controlEvents];
        return;
    }
    //用户传入方法，缓存执行
    switch (controlEvents) {
        case UIControlEventTouchUpInside: {
            self.targetCache = target;
            self.targetSELCache = action;
            return;
        }
        default:
            break;
    }
    [super addTarget:target action:action forControlEvents:controlEvents];
}

@end
