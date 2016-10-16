//
//  UILabel+CYAdd.m
//  1203NSURLSession
//
//  Created by ChuckonYin on 15/12/3.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "UILabel+CYAdd.h"
#import <objc/runtime.h>


static dispatch_queue_t cy_aNewQueue(){
    static dispatch_queue_t aNewQueue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        aNewQueue = dispatch_queue_create("com.pingan", DISPATCH_QUEUE_SERIAL);
    });
    return aNewQueue;
}

@implementation UIView (CYAdd)

- (void)setLabelID:(NSString *)labelID
{
    NSLog(@"属性地址：%p",labelID);
    objc_setAssociatedObject(self, @selector(labelID), labelID, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString*)labelID{
    return objc_getAssociatedObject(self, @selector(labelID));
}


@end
