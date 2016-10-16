//
//  VCFixLabel.m
//  FoodStore
//
//  Created by liuguopan on 14/12/30.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import "VCFixLabel.h"

@implementation VCFixLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

//- (void)setPrefix:(NSString *)prefix
//{
//    if ([NSString availableString:prefix lengthNotZero:YES]) {
//        _prefix = prefix;
//        [self setFullText:_nativeText prefix:prefix suffix:self.suffix];
//    }
//}

//- (void)setText:(NSString *)text
//{
////    NSString *fullText = nil;
////    [fullText stringByAppendingString:self.prefix];
////    [fullText stringByAppendingString:text];
////    [fullText stringByAppendingString:self.suffix];
//    
//    if ([NSString availableString:text lengthNotZero:YES]) {
//        _nativeText = text;
//        [self setFullText:text prefix:self.prefix suffix:self.suffix];
//    }
//}

//- (void)setSuffix:(NSString *)suffix
//{
//    if ([NSString availableString:suffix lengthNotZero:YES]) {
//        _suffix = suffix;
//        [self setFullText:self.nativeText prefix:self.prefix suffix:self.suffix];
//    }
//}
//
//- (void)setFullText:(NSString *)text prefix:(NSString *)prefix suffix:(NSString *)suffix
//{
//    NSString *fullText = [NSString stringWithString:prefix];
//    fullText = [NSString stringWithFormat:@"%@%@", fullText, text];
//    fullText = [NSString stringWithFormat:@"%@%@", fullText, suffix];
//    self.text = fullText;
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
