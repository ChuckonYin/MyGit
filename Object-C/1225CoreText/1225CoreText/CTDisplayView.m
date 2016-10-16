//
//  CTDisplayView.m
//  1225CoreText
//
//  Created by ChuckonYin on 15/12/24.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "CTDisplayView.h"
#import <CoreText/CoreText.h>

@implementation CTDisplayView


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(ctx, CGAffineTransformIdentity);
    CGContextTranslateCTM(ctx, 0, self.bounds.size.height);
    CGContextScaleCTM(ctx, 1.0, -1.0);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    
    NSAttributedString *attriString = [[NSAttributedString alloc] initWithString:@"Hello Chuckon Yin"" 创建绘制的区域，CoreText 本身支持各种文字排版的区域，"
                                       " 我们这里简单地将 UIView 的整个界面作为排版的区域。"
                                       " 为了加深理解，建议读者将该步骤的代码替换成如下代码，"
                                       " 测试设置不同的绘制区域带来的界面变化。"];
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attriString);
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, attriString.length), path, NULL);
    
    CTFrameDraw(frame, ctx);
    
    CFRelease(frame);
    CFRelease(frameSetter);
    CFRelease(path);
    
}


@end
