//
//  YZTPickerView.h
//  PANewToapAPP
//
//  Created by apple on 15/11/4.
//  Copyright © 2015年 Gavin. All rights reserved.
//

#import "YZTPopupView.h"

typedef void(^YZTPickerViewConfirmHandler)(NSArray *selectedRows, NSArray *selectedTitles);
typedef NSInteger(^YZTPickerViewReturnRows)(NSInteger inComponet, NSArray *selectedRows);
typedef NSString*(^YZTPickerViewReturnRowTitle)(NSInteger forComponet,NSInteger forRow, NSArray *selectedRows);

@interface YZTPickerView : YZTPopupView

@property (nonatomic, copy) YZTPickerViewReturnRows returnRowsBlock;
@property (nonatomic, copy) YZTPickerViewReturnRowTitle returnRowTitleBlock;
@property (nonatomic, copy) YZTPickerViewConfirmHandler pickerViewHandler;
@property (nonatomic, strong) NSArray *wantShowRows;

- (instancetype)initWithComponentsNumber:(NSInteger)countNum;

@end

/**
 *  Global Configuration of YZTPickerView.
 */
@interface YZTPickerViewConfig : NSObject

+ (YZTPickerViewConfig *) globalConfig;

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