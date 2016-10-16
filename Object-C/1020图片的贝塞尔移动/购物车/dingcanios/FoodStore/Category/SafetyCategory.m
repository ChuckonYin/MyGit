//
//  SafetyCategory.m
//  FoodStore
//
//  Created by liuguopan on 14-12-11.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import "SafetyCategory.h"

@implementation SafetyCategory

@end

@implementation NSString (Safety)

- (BOOL)availableString
{
    return [NSString availableString:self lengthNotZero:NO];
}

- (BOOL)availableStringAndLengthNotZero
{
    return [NSString availableString:self lengthNotZero:YES];
}

+ (BOOL)availableString:(id)obj
{
    return [NSString availableString:obj lengthNotZero:NO];
}

+ (BOOL)availableString:(id)obj lengthNotZero:(BOOL)notz
{
    if (nil != obj
        && ![obj isKindOfClass:[NSNull class]]
        && [obj isKindOfClass:[NSString class]]) {
        if (notz) {
            if (0 == ((NSString *)obj).length) {
                return NO;
            }
        }
        return YES;
    }
    return NO;
}

- (NSArray *)notNullComponentsSeparatedByString:(NSString *)separator
{
    if ([NSString availableString:self lengthNotZero:YES]) {
        NSArray *arr = [self componentsSeparatedByString:separator];
        if ([NSArray availableArray:arr countNotZero:YES]) {
            return [arr deleteAllNullObject];
        }
    }
    return nil;
}

@end

@implementation NSArray (Safety)

- (BOOL)availableArray
{
    return [NSArray availableArray:self countNotZero:NO];
}

- (BOOL)availableArrayAndCountNotZero
{
    return [NSArray availableArray:self countNotZero:YES];
}

+ (BOOL)availableArray:(id)obj
{
    return [NSArray availableArray:obj countNotZero:NO];
}

+ (BOOL)availableArray:(id)obj countNotZero:(BOOL)notz
{
    if (nil != obj
        && ![obj isKindOfClass:[NSNull class]]
        && [obj isKindOfClass:[NSArray class]]) {
        if (notz) {
            if (0 == ((NSArray *)obj).count) {
                return NO;
            }
        }
        return YES;
    }
    return NO;
}

- (NSArray *)deleteAllNullObject
{
    return [NSArray deleteAllNullObject:self];
}

+ (NSArray *)deleteAllNullObject:(NSArray *)arr
{
    if ([NSArray availableArray:arr countNotZero:YES]) {
        NSMutableArray *newArr = [[NSMutableArray alloc] initWithArray:arr];
        for (int i = 0; i < newArr.count; i++) {
            if (nil == [newArr objectAtIndex:i]) {
                [newArr removeObjectAtIndex:i];
                i--;
            }
        }
        return newArr;
    }
    return nil;
}

@end
