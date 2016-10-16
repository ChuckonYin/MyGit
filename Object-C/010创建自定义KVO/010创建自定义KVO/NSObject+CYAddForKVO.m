//
//  NSObject+CYAddForKVO.m
//  010创建自定义KVO
//
//  Created by ChuckonYin on 16/1/5.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "NSObject+CYAddForKVO.h"
#import <objc/runtime.h>

@implementation NSObject (CYAddForKVO)

- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath changeCallBack:(ChangeCallBack)callBack
{

    SEL setterSelector = NSSelectorFromString([self setterSelectorName:keyPath]);
    
    Class kvoClass = [self createKVOClass:[self class] withObservedKeyPath:keyPath];
    class_addMethod(kvoClass, setterSelector, imp_implementationWithBlock(^{
        //重写set方法
        
    }), method_getTypeEncoding((__bridge Method)([self setterSelectorName:keyPath])));
    
}

//创建一个继承原对象的类
- (Class)createKVOClass:(Class)superClass withObservedKeyPath:(NSString*)keyPath;
{
   
    NSString *kvoClassName = [@"KVO" stringByAppendingString:NSStringFromClass(superClass)];
    
    if (NSClassFromString(kvoClassName)) return NSClassFromString(kvoClassName);
    
    Class kvoClass = objc_allocateClassPair(superClass, kvoClassName.UTF8String, 0);
    
    objc_registerClassPair(kvoClass);

    return kvoClass;
}

static void kvo_setter(id self, SEL _cmd, id newValue)
{
    
}
//获取set方法名
- (NSString*)setterSelectorName:(NSString*)keyPath
{
    NSMutableString *string1 = [[@"set" stringByAppendingString:keyPath] stringByAppendingString:@":"].mutableCopy;
    NSString *oneUpChar = [NSString stringWithFormat:@"%c", [[string1 uppercaseString] characterAtIndex:3]];
    [string1 replaceCharactersInRange:NSMakeRange(3, 1) withString:oneUpChar];
    return string1;
}
-(void)setValue:(id)value{
    
}


@end





