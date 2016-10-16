//
//  NSObject+CYAdd.m
//  CYKitDemo
//
//  Created by ChuckonYin on 15/12/5.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "NSObject+CYAdd.h"
#import <objc/runtime.h>

@implementation NSObject (CYAdd)

/* 获取对象的所有属性*/
- (NSArray *)getAllProperties
{
    u_int count;
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++)
    {
        const char* propertyName =property_getName(properties[i]);
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    free(properties);
    return propertiesArray;
}

/* 获取对象的所有属性 以及属性值 */
- (NSDictionary *)getAllPropertiesAndValue
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}

/* 控制台输出对象的所有方法 */
-(void)printMothList
{
    unsigned int mothCout_f =0;
    Method* mothList_f = class_copyMethodList([self class],&mothCout_f);
    for(int i=0;i<mothCout_f;i++)
    {
        Method temp_f = mothList_f[i];
        IMP imp_f = method_getImplementation(temp_f);
        SEL name_f = method_getName(temp_f);
        const char* name_s =sel_getName(method_getName(temp_f));
        int arguments = method_getNumberOfArguments(temp_f);
        const char* encoding =method_getTypeEncoding(temp_f);
        NSLog(@"方法名：%@,参数个数：%d,编码方式：%@",[NSString stringWithUTF8String:name_s],
              arguments,[NSString stringWithUTF8String:encoding]);
    }
    free(mothList_f);
}

+(BOOL)isEmptyObject:(id)obj
{
    if (!obj) {
        return YES;
    }
    else if([obj isKindOfClass:[NSString class]]){
        return [obj length]==0;
    }
    else if ([obj isKindOfClass:[NSArray class]] || [obj isKindOfClass:[NSArray class]] || [obj isKindOfClass:[NSSet class]]){
        return [obj count]==0;
    }
    return NO;
}




@end










