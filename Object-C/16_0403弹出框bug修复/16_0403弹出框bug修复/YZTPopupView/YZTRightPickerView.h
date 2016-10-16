//
//  YZTRightPickerView.h
//  PANewToapAPP
//
//  Created by 李玉柱 on 16/1/12.
//  Copyright © 2016年 Gavin. All rights reserved.
//

#import "YZTPopupView.h"

typedef void(^YZTRightPickerViewConfirmHandler)(NSArray *selectedRows, NSArray *selectedTitles);
typedef NSInteger(^YZTRightPickerViewReturnRows)(NSInteger inComponet, NSArray *selectedRows);
typedef NSString*(^YZTRightPickerViewReturnRowTitle)(NSInteger forComponet,NSInteger forRow, NSArray *selectedRows);

@interface YZTRightPickerView : YZTPopupView

@property (nonatomic, copy) YZTRightPickerViewReturnRows returnRowsBlock;
@property (nonatomic, copy) YZTRightPickerViewReturnRowTitle returnRowTitleBlock;
@property (nonatomic, copy) YZTRightPickerViewConfirmHandler pickerViewHandler;
@property (nonatomic, strong) NSArray *wantShowRows;

- (instancetype)initWithComponentsNumber:(NSInteger)countNum;

@end


/**
 *  Global Configuration of YZTRightPickerView.
 */
@interface YZTRightPickerViewConfig : NSObject

+ (YZTRightPickerViewConfig *) globalConfig;

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