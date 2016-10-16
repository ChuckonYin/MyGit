//
//  YZTYearMonthDateView.h
//  PANewToapAPP
//
//  Created by 李玉柱 on 16/1/13.
//  Copyright © 2016年 Gavin. All rights reserved.
//

#import "YZTPopupView.h"

typedef void(^YZTYearMonthConfirmHandler)(NSArray *selectedRows);

@interface YZTYearMonthDateView : YZTPopupView

@property (nonatomic, copy) YZTYearMonthConfirmHandler dateConfirmHandler;
@property (nonatomic, strong) NSArray *wantShowRows;
@property (nonatomic, strong) NSNumber *maxMonth;

- (instancetype)initWithMinYear:(NSInteger)minYear MaxYear:(NSInteger)maxYear;


@end


/**
 *  Global Configuration of YZTYearMonthDateView.
 */
@interface YZTYearMonthDateViewConfig : NSObject

+ (YZTYearMonthDateViewConfig *) globalConfig;

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