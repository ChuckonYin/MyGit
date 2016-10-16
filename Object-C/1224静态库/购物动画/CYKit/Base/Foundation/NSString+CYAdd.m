//
//  NSString+CYAdd.m
//  CYKitDemo
//
//  Created by ChuckonYin on 15/12/3.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "NSString+CYAdd.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (CYAdd)

-(NSString*)subStringKeepNumber{
    NSMutableString *muString = [NSMutableString new];
    for (int i=0; i<self.length; i++) {
        char c = [self characterAtIndex:i];
        if ((c>='0' && c<='9') || c=='.') {
            [muString appendFormat:@"%c",c];
        }
    }
    return muString;
}
-(NSString *)deleteNumber
{
    NSMutableString *muString = [NSMutableString new];
    for (int i=0; i<self.length; i++) {
        char c = [self characterAtIndex:i];
        if ((c<'0' || c>'9') && c!='.') {
            [muString appendFormat:@"%c",c];
        }
    }
    return muString;
}

- (id)objectFromJSONString {
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

- (NSString*)changeToDecimal:(NumberKeepSpace)type decimalLength:(NSInteger)length
{
    if(self.length==0) {
        return @"0";
    }
    NSString * keepString = nil;
    
    switch (type) {
        case NumberKeepDecimalRound: {
            keepString = [NSString stringWithFormat:@"%Lf", roundl([self doubleValue]*pow(10, length))/pow(10, length)];
            break;
        }
        case NumberKeepDecimalCeil: {
            keepString = [NSString stringWithFormat:@"%Lf", ceill([self doubleValue]*pow(10, length))/pow(10, length)];
            break;
        }
        default: {
            break;
        }
    }
    NSInteger integerLength = [keepString rangeOfString:@"."].location;
    if (length>0) {
        return [keepString substringToIndex:integerLength+1+length];
    }
    else{
        return [keepString substringToIndex:integerLength];
    }
}

- (NSString *)changeToDecimalChineseEnd:(NumberKeepSpace)type decimalLength:(NSInteger)length
{
    if ([self doubleValue]>=pow(10, 8)) {
        NSString *tempStr = [NSString stringWithFormat:@"%f", [self doubleValue]/pow(10, 8)];
        return [[tempStr changeToDecimal:type decimalLength:length] stringByAppendingString:@"亿"];
    }
    else if ([self doubleValue]>=pow(10, 4)){
        NSString *tempStr = [NSString stringWithFormat:@"%f", [self doubleValue]/pow(10, 4)];
        return [[tempStr changeToDecimal:type decimalLength:length] stringByAppendingString:@"万"];
    }
    else{
        return [self changeToDecimal:type decimalLength:length];
    }
}

- (NSArray*)equidistantNumberArrayCapacity:(NSInteger)count decimalLength:(NSInteger)length orderedAscending:(BOOL)Ascending
{
    NSMutableArray *array = @[].mutableCopy;
    CGFloat perNum = [self floatValue]/count;
    for (int i=0; i<count; i++) {
        NSString *aString = aString = [NSString stringWithFormat:@"%f", perNum *( Ascending ? (i+1) : (count-i))];
        [array addObject:[aString changeToDecimalChineseEnd:NumberKeepDecimalRound decimalLength:length]];
    }
    return array;
}


- (NSString *)md5String
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString *)base64String
{
    NSData *data = [NSData dataWithBytes:[self UTF8String] length:[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
    NSUInteger length = [data length];
    NSMutableData *mutableData = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    
    uint8_t *input = (uint8_t *)[data bytes];
    uint8_t *output = (uint8_t *)[mutableData mutableBytes];
    
    for (NSUInteger i = 0; i < length; i += 3) {
        NSUInteger value = 0;
        for (NSUInteger j = i; j < (i + 3); j++) {
            value <<= 8;
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        static uint8_t const kAFBase64EncodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        
        NSUInteger idx = (i / 3) * 4;
        output[idx + 0] = kAFBase64EncodingTable[(value >> 18) & 0x3F];
        output[idx + 1] = kAFBase64EncodingTable[(value >> 12) & 0x3F];
        output[idx + 2] = (i + 1) < length ? kAFBase64EncodingTable[(value >> 6)  & 0x3F] : '=';
        output[idx + 3] = (i + 2) < length ? kAFBase64EncodingTable[(value >> 0)  & 0x3F] : '=';
    }
    
    NSString *retString = [[NSString alloc] initWithData:mutableData encoding:NSASCIIStringEncoding];
    return retString;
}

@end
