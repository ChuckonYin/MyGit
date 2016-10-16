//
//  SafetyCategory.h
//  FoodStore
//
//  Created by liuguopan on 14-12-11.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SafetyCategory : NSObject

@end

@interface NSString (Safety)

- (BOOL)availableString;
- (BOOL)availableStringAndLengthNotZero;
+ (BOOL)availableString:(id)obj;
+ (BOOL)availableString:(id)obj lengthNotZero:(BOOL)notz;
- (NSArray *)notNullComponentsSeparatedByString:(NSString *)separator;

@end

@interface NSArray (Safety)

- (BOOL)availableArray;
- (BOOL)availableArrayAndCountNotZero;
+ (BOOL)availableArray:(id)obj;
+ (BOOL)availableArray:(id)obj countNotZero:(BOOL)notz;
- (NSArray *)deleteAllNullObject;
+ (NSArray *)deleteAllNullObject:(NSArray *)arr;

@end
