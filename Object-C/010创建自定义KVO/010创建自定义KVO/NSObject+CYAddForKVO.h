//
//  NSObject+CYAddForKVO.h
//  010创建自定义KVO
//
//  Created by ChuckonYin on 16/1/5.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^ChangeCallBack)(id obj, NSString * keyPath, id oldValue, id newValue);

@interface NSObject (CYAddForKVO)

- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath changeCallBack:(ChangeCallBack)callBack;


@end
