//
//  NSMutableDictionary+CYAdd.m
//  CYKitDemo
//
//  Created by ChuckonYin on 15/12/4.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "NSMutableDictionary+CYAdd.h"

@implementation NSMutableDictionary (CYAdd)

-(void)changeNumberToString{
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (obj && [obj isKindOfClass:[NSNumber class]]) {
            [self setObject:[obj stringValue] forKey:key];
        }
        else{
            [self setObject:obj forKey:key];
        }
    }];
}

@end
