//
//  YZTCheckSheetView.h
//  PANewToapAPP
//
//  Created by 李玉柱 on 16/1/6.
//  Copyright © 2016年 Gavin. All rights reserved.
//

#import "YZTPopupView.h"
#import "MMPopupDefine.h"

typedef void(^YZTCheckSheetHandler)(NSInteger selectedRows);


UIKIT_EXTERN NSString *const YZTPopCheckSheetTitle;      // 标题
UIKIT_EXTERN NSString *const YZTPopCheckSheetSubTitle;   // 灰色标题
UIKIT_EXTERN NSString *const YZTPopCheckSheetIconName;   // icon图片名

/*
 itemsInfo:
 
 @[
     @{
        YZTPopCheckSheetTitle:    @"title-test1",
        YZTPopCheckSheetSubTitle: @"subTitle-test1",
        YZTPopCheckSheetIconName: @"iconName-test1"
     },
 
     @{ 
        YZTPopCheckSheetTitle:    @"title-test2",
        YZTPopCheckSheetSubTitle: @"subTitle-test2",
        YZTPopCheckSheetIconName: @"iconName-test2"
     },
     ....
 ];
 */

@interface YZTCheckSheetView : YZTPopupView

@property (nonatomic, copy  ) MMPopupBlock cancelBlock;
@property (nonatomic, copy  ) YZTCheckSheetHandler checkSheetHander;

- (instancetype) initWithItemsInfo:(NSArray *)itemsInfo
                     selectedIndex:(NSInteger)selectedIndex;


@end

/**
 *  Global Configuration of YZTCheckSheetView.
 */
@interface MMCheckSheetViewConfig : NSObject

+ (MMCheckSheetViewConfig*) globalConfig;

@property (nonatomic, assign) CGFloat tableRowHeight;         // Default is 59.

@property (nonatomic, assign) CGFloat titleFontSize;          // Default is 16.
@property (nonatomic, assign) CGFloat subTitleFontSize;       // Default is 14.

@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *titleColor;            // Default is #4a4a4a.
@property (nonatomic, strong) UIColor *subTitleColor;         // Default is #9b9b9b.
@property (nonatomic, strong) UIColor *tableColor;


@end
