//
//  CYFrameSet.m
//  1016CYCoreText
//
//  Created by ChuckonYin on 15/10/18.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "CYFrameSet.h"

@implementation CYFrameSet


+ (CoreTextData *)parseContext:(NSString *)context config:(CYTextConfig *)config
{
    NSMutableAttributedString *contextStr = [[NSMutableAttributedString alloc] initWithString:context attributes:[self parseConfigInfoToDictionary:config]];
    return nil;
}

+ (NSDictionary*)parseConfigInfoToDictionary:(CYTextConfig*)config
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    CGFloat fontSize = config.textFont;
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
    CGFloat lineSpace = config.lineSpace;
    const CFIndex kNumberOfSettings = 3;
    CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
        { kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof(CGFloat), &lineSpace},
        { kCTParagraphStyleSpecifierMaximumLineSpacing, sizeof(CGFloat), &lineSpace},
        { kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(CGFloat), &lineSpace}
    };
    return dict;
}


@end
