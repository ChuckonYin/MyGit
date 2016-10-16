//
//  NSString+CYAdd.h
//  CYKitDemo
//
//  Created by ChuckonYin on 15/12/3.
//  Copyright © 2015年 PingAn. All rights reserved.
//

typedef NS_ENUM(NSInteger, NumberKeepSpace){
    NumberKeepDecimalRound ,
    NumberKeepDecimalCeil ,
};

#import <Foundation/Foundation.h>

@interface NSString (CYAdd)

//get number in string
- (NSString*)subStringKeepNumber;
//delete number in string
- (NSString*)deleteNumber;
//parse json string to object
- (id)objectFromJSONString;
/**
 *  @param type   roud or ceif
 *  @param keep   statement decimal space ，can be minus
 *  @param chineseEnable chinese
 *
 *  @return ex1: 777.57 NumberKeepDecimalRound 1 return 777.6;
            ex2: 777.57 NumberKeepDecimalRound -1 return 780;
 */
- (NSString*)changeToDecimal:(NumberKeepSpace)type decimalLength:(NSInteger)length;

- (NSString*)changeToDecimalChineseEnd:(NumberKeepSpace)type decimalLength:(NSInteger)length;

- (NSArray*)equidistantNumberArrayCapacity:(NSInteger)count decimalLength:(NSInteger)length orderedAscending:(BOOL)Ascending;

- (NSString *)md5String;

- (NSString*)base64String;

@end
