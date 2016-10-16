//
//  UILabel+Associate.m
//  1120runtime添加属性
//
//  Created by ChuckonYin on 15/11/20.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "UILabel+Associate.h"
#import <objc/runtime.h>

#define Identifier @"Identifier"

@implementation UILabel (Associate)

- (void)setIdentifier:(NSString*)newIdName
{
    objc_setAssociatedObject(self, Identifier, newIdName, OBJC_ASSOCIATION_COPY);
}

- (NSString*)getIdentifer
{
    return objc_getAssociatedObject(self, Identifier);
}

@end
