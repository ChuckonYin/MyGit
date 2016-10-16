//
//  YZTPopWarningView.m
//  16_05_12登陆输入框优化
//
//  Created by ChuckonYin on 16/5/13.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "YZTPopWarningView.h"

#define YZTPopWarningViewDefaultFontSize 14.0f

@interface YZTPopWarningView()

@property (nonatomic, assign) CGFloat offX;
@property (nonatomic, assign) CGPoint topLocation;
@property (nonatomic, assign) CGPoint fullCenter;
@property (nonatomic, copy) void(^selectAction)(NSInteger);

@end

@implementation YZTPopWarningView

+ (YZTPopWarningView *)yzt_showWarning:(NSString *)warning
                                OnView:(UIView *)superView
                           topLocation:(CGPoint)topLocation
                         horizontalOff:(CGFloat)off
                          selectAction:(void(^)(NSInteger))selectAction{
    CGSize preSize = [self size:warning
                        forFont:[UIFont systemFontOfSize:YZTPopWarningViewDefaultFontSize]
                           size:CGSizeMake([[UIScreen mainScreen] bounds].size.width/2.0, HUGE)
                           mode:NSLineBreakByWordWrapping];
    CGSize realSize = CGSizeZero;
    if (preSize.width<[[UIScreen mainScreen] bounds].size.width/2.0-28) {
        realSize = CGSizeMake(preSize.width+28, [UIFont systemFontOfSize:YZTPopWarningViewDefaultFontSize].ascender+20);
    }
    else{
        realSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width/2.0, preSize.height+20);
    }
    NSLog(@"%@", NSStringFromCGSize(realSize));
    
    
    return nil;
}

- (void)dealloc{
    NSLog(@"dealloc");
}

- (id)initWithFrame:(CGRect)frame horizontalOff:(CGFloat)off{
    if (self = [super initWithFrame:frame]) {
//        self.titles = titles;
        self.offX = off;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(CGRectGetMidX(self.bounds)-self.offX, 0)];
    [path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds)-self.offX-10.0/1.372, 12)];
    [path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds)-self.offX+10.0/1.372,12)];
    [path closePath];
    [[UIColor whiteColor] setFill];
    [path fill];
}

#pragma private

+ (CGSize)yzt_textSize:(NSString *)text font:(CGFloat)fontSize{
    return [text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}];
}

+ (CGSize)size:(NSString *)string forFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([string respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [string boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [string sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}

- (void)yzt_show{
    self.transform = CGAffineTransformMakeScale(0, 0);
    self.center = CGPointMake(self.topLocation.x-self.offX, self.topLocation.y);
    self.alpha = 0.0;
    __unsafe_unretained YZTPopWarningView *weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.transform = CGAffineTransformMakeScale(0.95, 0.95);
        weakSelf.center = weakSelf.fullCenter;
        weakSelf.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            weakSelf.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {
            
        }];
    }];
}

- (void)yzt_dismiss{
    self.transform = CGAffineTransformMakeScale(1.0, 1.0);
    self.center = self.fullCenter;
    self.alpha = 1.0;
    __unsafe_unretained YZTPopWarningView *weakSelf = self;
    [UIView animateWithDuration:0.4 animations:^{
        //        weakSelf.transform = CGAffineTransformMakeScale(0, 0);
        //        weakSelf.center = CGPointMake(weakSelf.topLocation.x-weakSelf.offX, weakSelf.topLocation.y);
        weakSelf.alpha = 0.0;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

@end



