//
//  Person.h
//  010创建自定义KVO
//
//  Created by ChuckonYin on 16/1/12.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ChangeCallBack)(id obj, NSString *key,id oldValue, id newValue);

@interface Person : NSObject

@property (nonatomic, assign) NSInteger age;

@property (nonatomic, copy) ChangeCallBack callBack;

- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath changeCallBack:(ChangeCallBack)callBack;

@end


@interface KVOPerson : Person

@end









