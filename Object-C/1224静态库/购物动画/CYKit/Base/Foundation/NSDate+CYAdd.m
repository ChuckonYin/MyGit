//
//  NSDate+CYAdd.m
//  PANewToapAPP
//
//  Created by ChuckonYin on 15/12/21.
//  Copyright © 2015年 Gavin. All rights reserved.
//

#import "NSDate+CYAdd.h"

@implementation NSDate (CYAdd)

////返回与当前日期相隔某天的日期
+(NSDate *)getANewDateCompareWithDate:(NSDate *)date withSideNumber:(NSInteger)num
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:num];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    return mDate;
}
+(NSMutableArray *)getDateArrayCompareWithDate:(NSDate*)aDate TodayStart:(NSInteger)start End:(NSInteger)end dateStyle:(DateFormatter)style orUserDefinedStyle:(NSString*)styleStr
{
    NSMutableArray * dateArr = [[NSMutableArray alloc]init];
    for (NSInteger i = start; i< end; i++) {
        NSDate * date =[self getANewDateCompareWithDate:aDate withSideNumber:i];
        NSString *str = [date stringValueFormate:style orUserDefinedStyle:nil];
        [dateArr addObject:str];
    }
    return dateArr;
}

-(NSString *)stringValueFormate:(DateFormatter)formate orUserDefinedStyle:(NSString*)styleStr
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    /*
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:self];
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    NSInteger day = [dateComponent day];
    NSInteger hour = [dateComponent hour];
    NSInteger minute = [dateComponent minute];
    NSInteger second = [dateComponent second];
    */
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    if (styleStr && [styleStr isKindOfClass:[NSString class]] && styleStr.length > 0) {
        [formatter setDateFormat:styleStr];
    }
    switch (formate) {
        case DateFormatterYYYYmmDD: {
            [formatter setDateFormat:@"yyyyMMdd"];
            break;
        }
        case DateFormatterLineJoin: {
            [formatter setDateFormat:@"yyyy-MM-dd"];
            break;
        }
        case DateFormatterChineseJoin: {
            [formatter setDateFormat:@"yyyy年MM月dd日"];
            break;
        }
        default: {
            break;
        }
    }
    return [formatter stringFromDate:self];
}





@end
