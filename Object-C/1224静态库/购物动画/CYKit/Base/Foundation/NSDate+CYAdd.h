//
//  NSDate+CYAdd.h
//  PANewToapAPP
//
//  Created by ChuckonYin on 15/12/21.
//  Copyright © 2015年 Gavin. All rights reserved.
//

typedef NS_ENUM(NSInteger, DateFormatter) {
    DateFormatterYYYYmmDD = 0, //20150506
    DateFormatterLineJoin, //2015-05-06
    DateFormatterChineseJoin //2015年05月06日
};

#import <Foundation/Foundation.h>

@interface NSDate (CYAdd)

/**
 *  返回一个日期数组
 *  @param start 起始日期离今天的天数，今日以前为负数，今日以后为正数
 *  @param end   终止日期离今天的天数，今日以前为负数，今日以后为正数
 */
+(NSMutableArray *)getDateArrayCompareWithDate:(NSDate*)aDate TodayStart:(NSInteger)start End:(NSInteger)end dateStyle:(DateFormatter)style orUserDefinedStyle:(NSString*)styleStr;
/**
 *  返回与当前日期相隔某天的日期
 *  @param NSDate 任意某一天
 *  @param day    离某个日期的天数  正数or负数
 */
+(NSDate *)getANewDateCompareWithDate:(NSDate *)date withSideNumber:(NSInteger)num;

-(NSString*)stringValueFormate:(DateFormatter)formate;

@end
