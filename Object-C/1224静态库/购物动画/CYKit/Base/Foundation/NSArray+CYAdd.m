//
//  NSArray+CYAdd.m
//  CYKitDemo
//
//  Created by ChuckonYin on 15/12/4.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "NSArray+CYAdd.h"

@implementation NSArray (CYAdd)

-(NSArray*)sortArrayByNumberUp:(BOOL)up{
    return [self sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 floatValue] < [obj2 floatValue]) {
            return up ? NSOrderedAscending : NSOrderedDescending;
        }
        else if ([obj1 floatValue] == [obj2 floatValue]){
            return NSOrderedSame;
        }
        else{
            return up ? NSOrderedDescending : NSOrderedAscending;
        }
    }];
}

-(NSArray *)sortArrayByStringLengthUp:(BOOL)up
{
    return [self sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if (!obj1 || !obj2 || ![obj1 isKindOfClass:[NSString class]] || ![obj2 isKindOfClass:[NSString class]]) {
            return NSOrderedSame;
        }
        if ([(NSString*)obj1 length] < [(NSString*)obj2 length]) {
            return up ? NSOrderedAscending : NSOrderedDescending;
        }
        else if ([(NSString*)obj1 length] == [(NSString*)obj2 length]){
            return NSOrderedSame;
        }
        else{
            return up ? NSOrderedDescending : NSOrderedAscending;
        }
    }];
}

@end
