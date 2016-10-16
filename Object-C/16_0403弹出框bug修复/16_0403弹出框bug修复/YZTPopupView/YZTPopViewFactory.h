//
//  YZTPopView.h
//  PANewToapAPP
//
//  Created by apple on 15/10/14.
//  Copyright © 2015年 Gavin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YZTPopupView.h"
#import "YZTDateView.h"
#import "YZTPickerView.h"
#import "YZTOrderedDictionary.h"
#import "YZTRightPickerView.h"
#import "YZTYearMonthDateView.h"

/**
 *	@brief	item三种状态,即itemTypes,因需装入数组来传参，所以定义成字符串
 */
UIKIT_EXTERN NSString *const YZTPopItemTypeNormal;      // actionSheet(黑色)
UIKIT_EXTERN NSString *const YZTPopItemTypeHighlight;   // actionSheet(橘黄色)
UIKIT_EXTERN NSString *const YZTPopItemTypeDisabled;    // 灰色，不可点击

/**
 *	@brief	外部可以通过发送本通知，来让PopView都隐藏掉，
 *          或者调用 + (void)hidingAllPopView;
 */
UIKIT_EXTERN NSString *const YZTPopViewToHideNotification;

/**
 *	@brief	items点击后事件处理的Block
 *
 */
typedef void(^YZTPopItemEventBlock)(NSInteger itemIndex);

/**
 *	@brief	AlertCustomView点击item后，有返回BOOL值的回调Block，以返回值确定
 *          是否满足条件使Alert消失
 *
 */
typedef BOOL(^YZTPopItemEventReturnBlock)(NSInteger itemIndex);

/**
 *	@brief	YZTPopView 展示后、消失后、ActionSheet点击取消后，的回调Block
 *
 */
typedef void(^YZTPopupBlock)(YZTPopupView *popupView);

/**
 *	@brief	AlertInput点击item后，有返回BOOL值的回调Block，以返回值确定
 *          是否满足输入条件使Alert消失
 *
 */
typedef BOOL(^YZTPopAlertInputHandler)(NSInteger itemIndex, NSString *text);

/**
 *	@brief	YZTPickerView 一列数据的PickerView，返回对应row的title
 *
 */
typedef NSString*(^YZTPopPickerReturnRowTitle)(NSInteger forRow);
/**
 *	@brief	YZTPickerView 一列数据的PickerView，确定后的回调Block
 *
 */
typedef void(^YZTPopPickerConfirmHandler)(NSInteger selectedRow, NSString *selectedTitle);


@interface YZTPopViewFactory : NSObject

+ (void)initConfig;

/**
 *	@brief	点击黑色透明部分是否应该隐藏PopView
 *          注意：只在onView为nil的时候有效果
 *
 */
+ (void)touchWildToHide:(BOOL)hide;

/**
 *	@brief	可以在任何地方调用来隐藏所有展示的PopView
 *
 */
+ (void)hidingAllPopView;

#pragma mark - ActionSheet

/**************************** ActionSheet *******************************/

+ (YZTPopupView *)showActionSheetWithItemTitles:(NSArray *)itemTitles
                                     eventBlock:(YZTPopItemEventBlock)eventBlock;

+ (YZTPopupView *)showActionSheetWithItemTitles:(NSArray *)itemTitles
                                         onView:(UIView *)onView
                                     eventBlock:(YZTPopItemEventBlock)eventBlock;

+ (YZTPopupView *)showActionSheetWithItemTitles:(NSArray *)itemTitles
                                         onView:(UIView *)onView
                                     eventBlock:(YZTPopItemEventBlock)eventBlock
                                    cancelBlock:(YZTPopupBlock)cancelBlock
                                    hiddenBlock:(YZTPopupBlock)hiddenBlock;

+ (YZTPopupView *)showActionSheetWithItemTitles:(NSArray *)itemTitles
                                      itemTypes:(NSArray *)itemTypes
                                     eventBlock:(YZTPopItemEventBlock)eventBlock;

+ (YZTPopupView *)showActionSheetWithTitle:(NSString *)title
                                itemTitles:(NSArray *)itemTitles
                                eventBlock:(YZTPopItemEventBlock)eventBlock;

+ (YZTPopupView *)showActionSheetWithTitle:(NSString *)title
                                itemTitles:(NSArray *)itemTitles
                                    onView:(UIView *)onView
                                eventBlock:(YZTPopItemEventBlock)eventBlock;

+ (YZTPopupView *)showActionSheetWithTitle:(NSString *)title
                                itemTitles:(NSArray *)itemTitles
                                 itemTypes:(NSArray *)itemTypes
                                eventBlock:(YZTPopItemEventBlock)eventBlock;

+ (YZTPopupView *)showActionSheetWithTitle:(NSString *)title
                                itemTitles:(NSArray *)itemTitles
                                 itemTypes:(NSArray *)itemTypes
                                    onView:(UIView *)onView
                                eventBlock:(YZTPopItemEventBlock)eventBlock;

+ (YZTPopupView *)showActionSheetWithTitle:(NSString *)title
                                itemTitles:(NSArray *)itemTitles
                                 itemTypes:(NSArray *)itemTypes
                                    onView:(UIView *)onView
                                shownBlock:(YZTPopupBlock)shownBlock
                                eventBlock:(YZTPopItemEventBlock)eventBlock
                               cancelBlock:(YZTPopupBlock)cancelBlock
                               hiddenBlock:(YZTPopupBlock)hiddenBlock;
/*=======================================================================*/


#pragma mark - CheckSheet

/**************************** CheckSheet *******************************/


+ (YZTPopupView *)showCheckSheetWithItemTitles:(NSArray *)itemsTitles
                                 selectedIndex:(NSInteger)selectedIndex
                                    eventBlock:(YZTPopItemEventBlock)eventBlock;
/*
 如果会有子标题，图片icon需要组装成如下数据源，才能调用
 
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

+ (YZTPopupView *)showCheckSheetWithItemsInfo:(NSArray *)itemsInfo
                                selectedIndex:(NSInteger)selectedIndex
                                   eventBlock:(YZTPopItemEventBlock)eventBlock;

+ (YZTPopupView *)showCheckSheetWithItemsInfo:(NSArray *)itemsInfo
                                selectedIndex:(NSInteger)selectedIndex
                                       onView:(UIView *)onView
                                   shownBlock:(YZTPopupBlock)shownBlock
                                   eventBlock:(YZTPopItemEventBlock)eventBlock
                                  cancelBlock:(YZTPopupBlock)cancelBlock
                                  hiddenBlock:(YZTPopupBlock)hiddenBlock;

/*=======================================================================*/


#pragma mark - AlertView (Confirm)

/**************************** AlertView (Confirm) ************************/

+ (YZTPopupView *)showAlertConfirmWithTitle:(NSString *)title
                                     detail:(NSString *)detail;

+ (YZTPopupView *)showAlertConfirmWithTitle:(NSString *)title
                                     detail:(NSString *)detail
                                 eventBlock:(YZTPopItemEventBlock)eventBlock;

+ (YZTPopupView *)showAlertConfirmWithTitle:(NSString *)title
                                     detail:(NSString *)detail
                                 shownBlock:(YZTPopupBlock)shownBlock
                                 eventBlock:(YZTPopItemEventBlock)eventBlock
                                hiddenBlock:(YZTPopupBlock)hiddenBlock;
/*======================================================================*/


#pragma mark - AlertView

/***************************** AlertView ********************************/
/**
 *  each button take one row if there are more than 2 items
 */

// title：温馨提示，左按钮：取消，右按钮：确认
+ (YZTPopupView *)showAlertViewWithCancelAndConfirm:(NSString *)detail
                                         eventBlock:(YZTPopItemEventBlock)eventBlock;

// 左按钮：取消，右按钮：确认
+ (YZTPopupView *)showAlertViewWithCancelAndConfirm:(NSString *)title
                                             detail:(NSString *)detail
                                         eventBlock:(YZTPopItemEventBlock)eventBlock;

+ (YZTPopupView *)showAlertViewWithTitle:(NSString *)title
                                  detail:(NSString *)detail
                              itemTitles:(NSArray *)itemTitles
                              eventBlock:(YZTPopItemEventBlock)eventBlock;

+ (YZTPopupView *)showAlertViewWithTitle:(NSString *)title
                                  detail:(NSString *)detail
                              itemTitles:(NSArray *)itemTitles
                               itemTypes:(NSArray *)itemTypes
                              eventBlock:(YZTPopItemEventBlock)eventBlock;

+ (YZTPopupView *)showAlertViewWithTitle:(NSString *)title
                                  detail:(NSString *)detail
                              itemTitles:(NSArray *)itemTitles
                               itemTypes:(NSArray *)itemTypes
                                  onView:(UIView *)onView
                              eventBlock:(YZTPopItemEventBlock)eventBlock;

+ (YZTPopupView *)showAlertViewWithTitle:(NSString *)title
                                  detail:(NSString *)detail
                              itemTitles:(NSArray *)itemTitles
                               itemTypes:(NSArray *)itemTypes
                                  onView:(UIView *)onView
                              shownBlock:(YZTPopupBlock)shownBlock
                              eventBlock:(YZTPopItemEventBlock)eventBlock
                             hiddenBlock:(YZTPopupBlock)hiddenBlock;

/*======================================================================*/


#pragma mark - AlertView(Password)

/****************************** 密码输入框 ********************************/

+ (YZTPopupView *)showAlertPasswordWithTitle:(NSString *)title
                                   pwdLength:(NSInteger)pwdLength
                                  itemTitles:(NSArray *)itemTitles
                                     handler:(YZTPopAlertInputHandler)handler;

+ (YZTPopupView *)showAlertPasswordWithTitle:(NSString *)title
                                   pwdLength:(NSInteger)pwdLength
                                  itemTitles:(NSArray *)itemTitles
                                   itemTypes:(NSArray *)itemTypes
                                      onView:(UIView *)onView
                                  shownBlock:(YZTPopupBlock)shownBlock
                                     handler:(YZTPopAlertInputHandler)handler
                                 hiddenBlock:(YZTPopupBlock)hiddenBlock;

/*======================================================================*/


#pragma mark - AlertView(CustomView)

/************************* AlertView(CustomView) ************************/

// 默认带“确定”按钮
+ (YZTPopupView *)showAlertCustomViewWithTitle:(NSString *)title
                                    customView:(UIView *)customView
                              eventReturnBlock:(YZTPopItemEventReturnBlock)eventReturnBlock;

+ (YZTPopupView *)showAlertCustomViewWithTitle:(NSString *)title
                                    customView:(UIView *)customView
                                    itemTitles:(NSArray *)itemTitles
                              eventReturnBlock:(YZTPopItemEventReturnBlock)eventReturnBlock;

+ (YZTPopupView *)showAlertCustomViewWithTitle:(NSString *)title
                                    customView:(UIView *)customView
                                    itemTitles:(NSArray *)itemTitles
                                        onView:(UIView *)onView
                              eventReturnBlock:(YZTPopItemEventReturnBlock)eventReturnBlock;

+ (YZTPopupView *)showAlertCustomViewWithTitle:(NSString *)title
                                    customView:(UIView *)customView
                                        detail:(NSString *)detail
                                    itemTitles:(NSArray *)itemTitles
                                     itemTypes:(NSArray *)itemTypes
                                        onView:(UIView *)onView
                              eventReturnBlock:(YZTPopItemEventReturnBlock)eventReturnBlock;

+ (YZTPopupView *)showAlertCustomViewWithTitle:(NSString *)title
                                    customView:(UIView *)customView
                                        detail:(NSString *)detail
                                    itemTitles:(NSArray *)itemTitles
                                     itemTypes:(NSArray *)itemTypes
                                        onView:(UIView *)onView
                                    shownBlock:(YZTPopupBlock)shownBlock
                              eventReturnBlock:(YZTPopItemEventReturnBlock)eventReturnBlock
                                   hiddenBlock:(YZTPopupBlock)hiddenBlock;

/*======================================================================*/


#pragma mark - AlertView(Input)

/**************************** AlertView(Input) **************************/

/**
 * 记住：YZTPopAlertInputHandler，此block需要有BOO型返回值
 *
 */

// 默认有“取消”、@“确定”按钮
+ (YZTPopupView *)showAlertInputWithTitle:(NSString *)title
                              placeholder:(NSString *)inputPlaceholder
                                  handler:(YZTPopAlertInputHandler)inputHandler;

// 可自定义itemTitles
+ (YZTPopupView *)showAlertInputWithTitle:(NSString *)title
                               itemTitles:(NSArray *)itemTitles
                              placeholder:(NSString *)inputPlaceholder
                                  handler:(YZTPopAlertInputHandler)inputHandler;

+ (YZTPopupView *)showAlertInputWithTitle:(NSString *)title
                                   detail:(NSString *)detail
                               itemTitles:(NSArray *)itemTitles
                              placeholder:(NSString *)inputPlaceholder
                                   onView:(UIView *)onView
                                  handler:(YZTPopAlertInputHandler)inputHandler;

+ (YZTPopupView *)showAlertInputWithTitle:(NSString *)title
                                   detail:(NSString *)detail
                               itemTitles:(NSArray *)itemTitles
                              placeholder:(NSString *)inputPlaceholder
                                   onView:(UIView *)onView
                               shownBlock:(YZTPopupBlock)shownBlock
                                  handler:(YZTPopAlertInputHandler)inputHandler
                              hiddenBlock:(YZTPopupBlock)hiddenBlock;
/*======================================================================*/


#pragma mark - PickerView

/***************************** PickerView *******************************/

// 只有一列数据选择的PickerView
+ (YZTPopupView *)showPickerViewWithRowsCount:(NSInteger)rowsCount
                          returnRowTitleBlock:(YZTPopPickerReturnRowTitle)returnRowTitleBlock
                               confirmHandler:(YZTPopPickerConfirmHandler)confirmHandler;

+ (YZTPopupView *)showPickerViewWithRowsCount:(NSInteger)rowsCount
                                  wantShowRow:(NSInteger)wantShowRow
                          returnRowTitleBlock:(YZTPopPickerReturnRowTitle)returnRowTitleBlock
                               confirmHandler:(YZTPopPickerConfirmHandler)confirmHandler;

+ (YZTPopupView *)showPickerViewWithRowsCount:(NSInteger)rowsCount
                                  wantShowRow:(NSInteger)wantShowRow
                                       onView:(UIView *)onView
                          returnRowTitleBlock:(YZTPopPickerReturnRowTitle)returnRowTitleBlock
                                   shownBlock:(YZTPopupBlock)shownBlock
                               confirmHandler:(YZTPopPickerConfirmHandler)confirmHandler
                                  hiddenBlock:(YZTPopupBlock)hiddenBlock;

// 多列数据选择的PickerView
+ (YZTPopupView *)showPickerViewWithComponentsNumber:(NSInteger)cNumber
                                     returnRowsBlock:(YZTPickerViewReturnRows)returnRowsBlock
                                 returnRowTitleBlock:(YZTPickerViewReturnRowTitle)returnRowTitleBlock
                                      confirmHandler:(YZTPickerViewConfirmHandler)confirmHandler;

+ (YZTPopupView *)showPickerViewWithComponentsNumber:(NSInteger)cNumber
                                        wantShowRows:(NSArray *)wantShowRows
                                     returnRowsBlock:(YZTPickerViewReturnRows)returnRowsBlock
                                 returnRowTitleBlock:(YZTPickerViewReturnRowTitle)returnRowTitleBlock
                                      confirmHandler:(YZTPickerViewConfirmHandler)confirmHandler;

+ (YZTPopupView *)showPickerViewWithComponentsNumber:(NSInteger)cNumber
                                        wantShowRows:(NSArray *)wantShowRows
                                              onView:(UIView *)onView
                                     returnRowsBlock:(YZTPickerViewReturnRows)returnRowsBlock
                                 returnRowTitleBlock:(YZTPickerViewReturnRowTitle)returnRowTitleBlock
                                          shownBlock:(YZTPopupBlock)shownBlock
                                      confirmHandler:(YZTPickerViewConfirmHandler)confirmHandler
                                         hiddenBlock:(YZTPopupBlock)hiddenBlock;


//RightPickerView
+ (YZTPopupView *)showRightPickerViewWithComponentsNumber:(NSInteger)cNumber
                                          returnRowsBlock:(YZTRightPickerViewReturnRows)returnRowsBlock
                                      returnRowTitleBlock:(YZTRightPickerViewReturnRowTitle)returnRowTitleBlock
                                           confirmHandler:(YZTRightPickerViewConfirmHandler)confirmHandler;

+ (YZTPopupView *)showRightPickerViewWithComponentsNumber:(NSInteger)cNumber
                                             wantShowRows:(NSArray *)wantShowRows
                                          returnRowsBlock:(YZTRightPickerViewReturnRows)returnRowsBlock
                                      returnRowTitleBlock:(YZTRightPickerViewReturnRowTitle)returnRowTitleBlock
                                           confirmHandler:(YZTRightPickerViewConfirmHandler)confirmHandler;

+(YZTPopupView *)showRightPickerViewWithComponentsNumber:(NSInteger)cNumber
                                            wantShowRows:(NSArray *)wantShowRows
                                                  onView:(UIView *)onView
                                         returnRowsBlock:(YZTRightPickerViewReturnRows)returnRowsBlock
                                     returnRowTitleBlock:(YZTRightPickerViewReturnRowTitle)returnRowTitleBlock
                                              shownBlock:(YZTPopupBlock)shownBlock
                                          confirmHandler:(YZTRightPickerViewConfirmHandler)confirmHandler
                                             hiddenBlock:(YZTPopupBlock)hiddenBlock;

/*======================================================================*/


#pragma mark - DateView

/****************************** DateView ********************************/

// 未有的参数可以传nil

+ (YZTPopupView *)showDateViewWithMode:(UIDatePickerMode)dateMode
                               maxDate:(NSDate *)maxDate
                                isGMT0:(BOOL)isUTC0
                        confirmHandler:(YZTDateViewConfirmHandler)confirmHandler;

+ (YZTPopupView *)showDateViewWithMode:(UIDatePickerMode)dateMode
                               maxDate:(NSDate *)maxDate
                        confirmHandler:(YZTDateViewConfirmHandler)confirmHandler;

+ (YZTPopupView *)showDateViewWithMode:(UIDatePickerMode)dateMode
                              showDate:(NSDate *)showDate
                               minDate:(NSDate *)minDate
                               maxDate:(NSDate *)maxDate
                        confirmHandler:(YZTDateViewConfirmHandler)confirmHandler;

+ (YZTPopupView *)showDateViewWithMode:(UIDatePickerMode)dateMode
                              showDate:(NSDate *)showDate
                               minDate:(NSDate *)minDate
                               maxDate:(NSDate *)maxDate
                                onView:(UIView *)onView
                            shownBlock:(YZTPopupBlock)shownBlock
                        confirmHandler:(YZTDateViewConfirmHandler)confirmHandler
                           hiddenBlock:(YZTPopupBlock)hiddenBlock;
//YZTYearMonthDateView

+ (YZTPopupView *)showYearMonthDateViewWithMinYear:(NSInteger)minYear
                                           MaxYear:(NSInteger)maxYear
                                            onView:(UIView *)onView
                                      WantShowRows:(NSArray *)wantShowRows
                                    confirmHandler:(YZTYearMonthConfirmHandler)confirmHandler;

+ (YZTPopupView *)showYearMonthDateViewWithMinYear:(NSInteger)minYear
                                           MaxYear:(NSInteger)maxYear
                                          maxMonth:(NSInteger)maxMonth
                                            onView:(UIView *)onView
                                      WantShowRows:(NSArray *)wantShowRows
                                    confirmHandler:(YZTYearMonthConfirmHandler)confirmHandler;

/*======================================================================*/

#pragma mark - ToastView(土司)

/****************************** ToastView ********************************/

// 默认停留1秒
+ (void)showToastViewWithDetail:(NSString *)detail;

+ (void)showToastViewWithDetail:(NSString *)detail
                    hiddenBlock:(YZTPopupBlock)hiddenBlock;

+ (void)showToastViewWithDetail:(NSString *)detail
                    staySeconds:(double)seconds
                    hiddenBlock:(YZTPopupBlock)hiddenBlock;

+ (void)showToastViewWithTitle:(NSString *)title
                        detail:(NSString *)detail
                   staySeconds:(double)seconds
                    shownBlock:(YZTPopupBlock)shownBlock
                   hiddenBlock:(YZTPopupBlock)hiddenBlock;
/*======================================================================*/


@end
