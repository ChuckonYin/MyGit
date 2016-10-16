//
//  YZTDateView.h
//  PANewToapAPP
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 Gavin. All rights reserved.
//

#import "YZTPopupView.h"

typedef void(^YZTDateViewConfirmHandler)(NSDate *selectedDate);


@interface YZTDateView : YZTPopupView

@property (nonatomic, copy) YZTDateViewConfirmHandler confirmHandler;

@property (nonatomic, assign) BOOL isUTC0;

- (instancetype)initWithDateMode:(UIDatePickerMode)mode showDate:(NSDate *)showDate minDate:(NSDate *)minDate maxDate:(NSDate *)maxDate;

@end

/**
 *  Global Configuration of YZTPickerView.
 */
@interface YZTDateViewConfig : NSObject

+ (YZTDateViewConfig *) globalConfig;

@property (nonatomic, assign) CGFloat toolViewHeight;
@property (nonatomic, assign) CGFloat pickerViewHeight;
@property (nonatomic, assign) CGFloat splitHeight;
@property (nonatomic, assign) CGFloat pickerRowHeight;

@property (nonatomic, assign) CGFloat titleFontSize;
@property (nonatomic, assign) CGFloat buttonFontSize;

@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *splitColor;
@property (nonatomic, strong) UIColor *buttonCancelTitleColor;
@property (nonatomic, strong) UIColor *buttonConfirmTitleColor;

@end