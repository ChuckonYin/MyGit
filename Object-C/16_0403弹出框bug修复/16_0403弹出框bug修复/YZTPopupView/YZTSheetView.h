//
//  YZTSheetView.h
//  YZTPopupView
//
//  Created by Ralph Li on 9/6/15.
//  Copyright © 2015 LJC. All rights reserved.
//

#import "YZTPopupView.h"
#import "MMPopupDefine.h"

@interface YZTSheetView : YZTPopupView

@property (nonatomic, copy  ) MMPopupBlock cancelBlock;

- (instancetype) initWithTitle:(NSString*)title
                         items:(NSArray*)items;

@end


/**
 *  Global Configuration of YZTSheetView.
 */
@interface MMSheetViewConfig : NSObject

+ (MMSheetViewConfig*) globalConfig;

@property (nonatomic, assign) CGFloat buttonHeight;         // Default is 48.
@property (nonatomic, assign) CGFloat buttonCancelHeight;   // Default is 59.
@property (nonatomic, assign) CGFloat innerMargin;          // Default is 19.

@property (nonatomic, assign) CGFloat titleFontSize;        // Default is 18.
@property (nonatomic, assign) CGFloat buttonFontSize;       // Default is 20.
@property (nonatomic, assign) CGFloat buttonCancelFontSize; // Default is 16.

@property (nonatomic, strong) UIColor *backgroundColor;     // Default is #FFFFFF.
@property (nonatomic, strong) UIColor *titleColor;          // Default is #666666.
@property (nonatomic, strong) UIColor *splitColor;          // Default is #CCCCCC.

@property (nonatomic, strong) UIColor *itemCancelColor;     // Default is #9b9b9b. 
@property (nonatomic, strong) UIColor *itemNormalColor;     // Default is #4a4a4a. effect with MMItemTypeNormal
@property (nonatomic, strong) UIColor *itemDisableColor;    // Default is #CCCCCC. effect with MMItemTypeDisabled
@property (nonatomic, strong) UIColor *itemHighlightColor;  // Default is #FF6600. effect with MMItemTypeHighlight
@property (nonatomic, strong) UIColor *itemPressedColor;    // Default is #EFEDE7.

@property (nonatomic, strong) NSString *defaultTextCancel;  // Default is "取消"

@end
