//
//  YZTAlertView.h
//  YZTPopupView
//
//  Created by Ralph Li on 9/6/15.
//  Copyright © 2015 LJC. All rights reserved.
//

#import "YZTPopupView.h"
#import "MMPopupDefine.h"

typedef BOOL(^MMPopupInputHandler)(NSInteger itemIndex, NSString *text);

typedef BOOL(^MMPopupHasReturnHandler)(NSInteger itemIndex);


@interface YZTAlertView : YZTPopupView

@property (nonatomic, assign) NSUInteger maxInputLength;    // default is 0. Means no length limit.

@property (nonatomic, copy) MMPopupHasReturnHandler returnHandler;

- (instancetype) initWithCustomViewTitle:(NSString*)title
                              customView:(UIView *)customView
                                  detail:(NSString*)detail
                                   items:(NSArray*)items
                                 handler:(MMPopupInputHandler)inputHandler;

- (instancetype) initWithInputTitle:(NSString*)title
                             detail:(NSString*)detail
                        placeholder:(NSString*)inputPlaceholder
                            handler:(MMPopupInputHandler)inputHandler;

- (instancetype) initWithConfirmTitle:(NSString*)title
                               detail:(NSString*)detail;

- (instancetype) initWithTitle:(NSString*)title
                        detail:(NSString*)detail
                         items:(NSArray*)items;

- (instancetype)initWithTitle:(NSString *)title
                   customView:(UIView *)customView
                       detail:(NSString *)detail
                        items:(NSArray *)items
             inputPlaceholder:(NSString *)inputPlaceholder
                 inputHandler:(MMPopupInputHandler)inputHandler;

// 外部确定按钮出发可以模拟触发自己的确定按钮动作，tag = -1
- (void)externalButtonAtion;


- (instancetype)initWithTitle:(NSString *)title
                    InputView:(UIView *)inputView
                       detail:(NSString *)detail
                        items:(NSArray *)items;


@end



/**
 *  Global Configuration of YZTAlertView.
 */
@interface MMAlertViewConfig : NSObject

+ (MMAlertViewConfig*) globalConfig;

@property (nonatomic, assign) CGFloat width;                // Default is 275.
@property (nonatomic, assign) CGFloat toastWidth;           // Default is 150.
@property (nonatomic, assign) CGFloat buttonHeight;         // Default is 40//50.
@property (nonatomic, assign) CGFloat innerMargin;          // Default is 20.
@property (nonatomic, assign) CGFloat cornerRadius;         // Default is 5.

@property (nonatomic, assign) CGFloat titleFontSize;        // Default is 16.
@property (nonatomic, assign) CGFloat detailFontSize;       // Default is 14.
@property (nonatomic, assign) CGFloat buttonFontSize;       // Default is 16.

@property (nonatomic, strong) UIColor *backgroundColor;     // Default is #FFFFFF.
@property (nonatomic, strong) UIColor *titleColor;          // Default is #4A4A4A.
@property (nonatomic, strong) UIColor *detailColor;         // Default is #9B9B9B.
@property (nonatomic, strong) UIColor *splitColor;          // Default is #CCCCCC.

@property (nonatomic, strong) UIColor *itemNormalColor;     // Default is #FF6600. effect with MMItemTypeNormal
@property (nonatomic, strong) UIColor *itemHighlightColor;  // Default is #E76153. effect with MMItemTypeHighlight
@property (nonatomic, strong) UIColor *itemPressedColor;    // Default is #FF6600.

@property (nonatomic, strong) NSString *defaultTextOK;      // Default is "好".
@property (nonatomic, strong) NSString *defaultTextCancel;  // Default is "取消".
@property (nonatomic, strong) NSString *defaultTextConfirm; // Default is "确定".

@end
