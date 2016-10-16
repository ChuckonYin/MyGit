//
//  CYCoretextView.m
//  1016CYCoreText
//
//  Created by ChuckonYin on 15/10/16.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "CYCoretextView.h"
#import <CoreText/CoreText.h>

@implementation CYCoretextView

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    //取出最底层颠倒坐标轴y轴
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    {
        CGContextSetTextMatrix(ctx, CGAffineTransformIdentity);
        CGContextTranslateCTM(ctx, 0, self.bounds.size.height);
        CGContextScaleCTM(ctx, 1.0, -1.0);
    }
    //绘制区域
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, self.bounds);
    
    
//    NSAttributedString *attriStr = [[NSAttributedString alloc] initWithString:@"Hello world"];
    
    NSAttributedString *attriStr = [[NSAttributedString alloc] initWithString:
                                    @"              Hello World!\n"
                                    " 创建绘制的区域，CoreText 本身支持各种文字排版的区域\n"
                                    " 我们这里简单地将 UIView 的整个界面作为排版的区域。\n"
                                    " 为了加深理解，建议读者将该步骤的代码替换成如下代码\n"
                                    " 测试设置不同的绘制区域带来的界面变化。\n"];
    
    
    CTFramesetterRef setterframe = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attriStr);

    CTFrameRef frame = CTFramesetterCreateFrame(setterframe, CFRangeMake(0, [attriStr length]), path, NULL);
    
    
    CTFrameDraw(frame, ctx);
    
}



















@end
