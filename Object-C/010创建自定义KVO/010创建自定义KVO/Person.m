//
//  Person.m
//  010创建自定义KVO
//
//  Created by ChuckonYin on 16/1/12.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath changeCallBack:(ChangeCallBack)callBack
{
    _callBack = callBack;
}
@end


@implementation KVOPerson

- (void)setAge:(NSInteger)age
{
    if (self.callBack) {
        self.callBack(self, @"age", @(self.age), @(age));
    }
    [super setAge:age];
}

- (Class)class
{
    return [super class];
}

@end

