//
//  CalendarLayout.h
//  16_0421日历
//
//  Created by ChuckonYin on 16/4/21.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarModel.h"
extern NSString *const SupplementaryViewTopHeader;

typedef NS_ENUM(NSInteger, CalendarLayoutLocation){
    CalendarLayoutLocationLeft,
    CalendarLayoutLocationMiddel,
    CalendarLayoutLocationRight
};

@interface CalendarOneDayModel : NSObject

@property (nonatomic, assign) NSInteger day;

@property (nonatomic, assign) CGFloat currentHeight;

@end

@interface CalendarLayout : UICollectionViewLayout

@property (nonatomic, strong) NSMutableArray <CalendarOneDayModel *>* sevenDays;

@property (nonatomic, strong) NSArray <CalendarModel *>*dataArray;

@end

