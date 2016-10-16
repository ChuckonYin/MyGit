//
//  NSString+NumberFormat.m
//  PANewToapAPP
//
//  Created by ChuckonYin on 16/1/18.
//  Copyright © 2016年 Gavin. All rights reserved.
//

#import "NSString+NumberFormat.h"
#import "NSString+CYAdd.h"


@implementation NSString (NumberFormat)
//十万
- (NSString *)formatHundredThousand
{
    //低于十万
    if ([self floatValue]<powl(10, 5)) return self;
    //高于亿
    if ([self floatValue]>=powl(10, 8)) return [self changeToDecimalChineseEnd:NumberKeepDecimalRound decimalLength:4];
    //低于百万
    else if ([self floatValue]<pow(10, 6)){
        return [self changeToDecimal:NumberKeepDecimalRound decimalLength:4];
    }
    //百万、千万级别
    else{
        return [self formatMillion];
    }
    return nil;
}
//百万
- (NSString *)formatMillion
{
    //百万
    if ([self floatValue]<pow(10, 7)) {
        NSString *numStr = [NSString stringWithFormat:@"%Lf", self.floatValue/powl(10.0f, 6.0f)];
        return [[numStr changeToDecimal:NumberKeepDecimalRound decimalLength:4] stringByAppendingString:@"百万"];
    }
    //千万
    else if ([self floatValue]<pow(10, 8)){
        NSString *numStr = [NSString stringWithFormat:@"%Lf", self.floatValue/powl(10.0f, 7.0f)];
        return [[numStr changeToDecimal:NumberKeepDecimalRound decimalLength:4] stringByAppendingString:@"千万"];
    }
    return nil;
}

//- (void)chineseFormatDecimalLength:(NSInteger)length
//{
//    NSInteger numberLength = self.length;
//    
//    if ([self containsString:@"亿"]) {
//        
//    }
//    else if ([self containsString:@"千"]){
//        
//    }
//    
////    [self substringWithRange:<#(NSRange)#>];
//    
//}

- (NSString*)formatHundredThousandDecimalLength:(NSInteger)length
{
    //低于十万
    if ([self floatValue]<powl(10, 5)) return self;
    //高于亿
    if ([self floatValue]>=powl(10, 8)) return [self changeToDecimalChineseEnd:NumberKeepDecimalRound decimalLength:length];
    //低于百万
    else if ([self floatValue]<pow(10, 6)){
        return [self changeToDecimal:NumberKeepDecimalRound decimalLength:length];
    }
    //百万、千万级别
    else{
        return [self formatMillionDecimalLength:length];
    }
    return self;
}

- (NSString*)formatMillionDecimalLength:(NSInteger)length
{
    //低于十万
    if ([self floatValue]<powl(10, 5)) return self;
    //高于亿
    if ([self floatValue]>=powl(10, 8)) return [self changeToDecimalChineseEnd:NumberKeepDecimalRound decimalLength:length];
    //百万
    if ([self floatValue]<pow(10, 7)) {
        NSString *numStr = [NSString stringWithFormat:@"%Lf", self.floatValue/powl(10.0f, 6.0f)];
        return [[numStr changeToDecimal:NumberKeepDecimalRound decimalLength:length] stringByAppendingString:@"百万"];
    }
    //千万
    else if ([self floatValue]<pow(10, 8)){
        NSString *numStr = [NSString stringWithFormat:@"%Lf", self.floatValue/powl(10.0f, 7.0f)];
        return [[numStr changeToDecimal:NumberKeepDecimalRound decimalLength:length] stringByAppendingString:@"千万"];
    }
    return self;
}


@end
