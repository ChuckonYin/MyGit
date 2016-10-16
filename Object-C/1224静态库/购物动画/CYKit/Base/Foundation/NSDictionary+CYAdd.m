//
//  NSDictionary+CYAdd.m
//  CYKitDemo
//
//  Created by ChuckonYin on 15/12/4.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "NSDictionary+CYAdd.h"

@implementation NSDictionary (CYAdd)

-(NSDictionary *)changeNumberToString{
    NSMutableDictionary *muDict = [[NSMutableDictionary alloc] init];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (obj && [obj isKindOfClass:[NSNumber class]]) {
            [muDict setObject:[obj stringValue] forKey:key];
        }
        else{
            [muDict setObject:obj forKey:key];
        }
    }];
    return (NSDictionary*)muDict;
}

@end
