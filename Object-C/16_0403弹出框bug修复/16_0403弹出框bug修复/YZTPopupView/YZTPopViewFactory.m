//
//  YZTPopView.m
//  PANewToapAPP
//
//  Created by apple on 15/10/14.
//  Copyright © 2015年 Gavin. All rights reserved.
//

#import "YZTPopViewFactory.h"

#import "YZTPopupWindow.h"
#import "YZTPopupItem.h"
#import "YZTSheetView.h"
#import "YZTAlertView.h"
#import "YZTAlertPasswordInputConfig.h"
#import "YZTCheckSheetView.h"


NSString *const YZTPopItemTypeNormal = @"0";
NSString *const YZTPopItemTypeHighlight = @"1";
NSString *const YZTPopItemTypeDisabled = @"2";

NSString *const YZTPopViewToHideNotification = @"YZTPopViewToHideNotification";

@implementation YZTPopViewFactory

+ (void)initConfig
{
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        [[YZTPopupWindow sharedWindow] cacheWindow];
        //[YZTPopupWindow sharedWindow].touchWildToHide = YES;
    });
}

+ (void)touchWildToHide:(BOOL)hide
{
    [YZTPopupWindow sharedWindow].touchWildToHide = hide;
}

+ (void)hidingAllPopView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:YZTPopViewToHideNotification object:nil];
}

#pragma mark - ActionSheet

+ (YZTPopupView *)showActionSheetWithItemTitles:(NSArray *)itemTitles
                                     eventBlock:(YZTPopItemEventBlock)eventBlock
{
    return [YZTPopViewFactory showActionSheetWithItemTitles:itemTitles
                                                  itemTypes:nil
                                                 eventBlock:eventBlock];
}

+ (YZTPopupView *)showActionSheetWithItemTitles:(NSArray *)itemTitles
                                      itemTypes:(NSArray *)itemTypes
                                     eventBlock:(YZTPopItemEventBlock)eventBlock
{
    return [YZTPopViewFactory showActionSheetWithTitle:nil
                                            itemTitles:itemTitles
                                             itemTypes:itemTypes
                                            eventBlock:eventBlock];
}

+ (YZTPopupView *)showActionSheetWithItemTitles:(NSArray *)itemTitles
                                         onView:(UIView *)onView
                                     eventBlock:(YZTPopItemEventBlock)eventBlock
{
    return [YZTPopViewFactory showActionSheetWithTitle:nil
                                            itemTitles:itemTitles
                                             itemTypes:nil
                                                onView:onView
                                            eventBlock:eventBlock];
}

+ (YZTPopupView *)showActionSheetWithItemTitles:(NSArray *)itemTitles
                                         onView:(UIView *)onView
                                     eventBlock:(YZTPopItemEventBlock)eventBlock
                                    cancelBlock:(YZTPopupBlock)cancelBlock
                                    hiddenBlock:(YZTPopupBlock)hiddenBlock
{
    return [YZTPopViewFactory showActionSheetWithTitle:nil
                                            itemTitles:itemTitles
                                             itemTypes:nil
                                                onView:onView
                                            shownBlock:nil
                                            eventBlock:eventBlock
                                           cancelBlock:cancelBlock
                                           hiddenBlock:hiddenBlock];
}

+ (YZTPopupView *)showActionSheetWithTitle:(NSString *)title
                                itemTitles:(NSArray *)itemTitles
                                eventBlock:(YZTPopItemEventBlock)eventBlock
{
    return [YZTPopViewFactory showActionSheetWithTitle:title
                                            itemTitles:itemTitles
                                             itemTypes:nil
                                            eventBlock:eventBlock];
}

+ (YZTPopupView *)showActionSheetWithTitle:(NSString *)title
                                itemTitles:(NSArray *)itemTitles
                                    onView:(UIView *)onView
                                eventBlock:(YZTPopItemEventBlock)eventBlock
{
    return [YZTPopViewFactory showActionSheetWithTitle:title
                                            itemTitles:itemTitles
                                             itemTypes:nil
                                                onView:onView
                                            eventBlock:eventBlock];
}

+ (YZTPopupView *)showActionSheetWithTitle:(NSString *)title
                                itemTitles:(NSArray *)itemTitles
                                 itemTypes:(NSArray *)itemTypes
                                eventBlock:(YZTPopItemEventBlock)eventBlock
{
    return [YZTPopViewFactory showActionSheetWithTitle:title
                                            itemTitles:itemTitles
                                             itemTypes:itemTypes
                                                onView:nil
                                            eventBlock:eventBlock];
}

+ (YZTPopupView *)showActionSheetWithTitle:(NSString *)title
                                itemTitles:(NSArray *)itemTitles
                                 itemTypes:(NSArray *)itemTypes
                                    onView:(UIView *)onView
                                eventBlock:(YZTPopItemEventBlock)eventBlock
{
    return [YZTPopViewFactory showActionSheetWithTitle:title
                                            itemTitles:itemTitles
                                             itemTypes:itemTypes
                                                onView:onView
                                            shownBlock:nil
                                            eventBlock:eventBlock
                                           cancelBlock:nil
                                           hiddenBlock:nil];
}

+ (YZTPopupView *)showActionSheetWithTitle:(NSString *)title
                                itemTitles:(NSArray *)itemTitles
                                 itemTypes:(NSArray *)itemTypes
                                    onView:(UIView *)onView
                                shownBlock:(YZTPopupBlock)shownBlock
                                eventBlock:(YZTPopItemEventBlock)eventBlock
                               cancelBlock:(YZTPopupBlock)cancelBlock
                               hiddenBlock:(YZTPopupBlock)hiddenBlock
{
    [YZTPopViewFactory initConfig];
    if (itemTitles && itemTitles.count>0) {
        NSMutableArray *items = [NSMutableArray new];
        for (int i = 0; i < itemTitles.count; i++) {
            if (itemTypes && itemTypes.count>i) {
                if ([itemTypes[i] isEqualToString:YZTPopItemTypeNormal] ||
                    [itemTypes[i] isEqualToString:YZTPopItemTypeHighlight] ||
                    [itemTypes[i] isEqualToString:YZTPopItemTypeDisabled]) {
                    [items addObject:MMItemMake(itemTitles[i], [itemTypes[i] integerValue], eventBlock)];
                }else{
                    [items addObject:MMItemMake(itemTitles[i], MMItemTypeNormal, eventBlock)];
                }
            }else{
                [items addObject:MMItemMake(itemTitles[i], MMItemTypeNormal, eventBlock)];
            }
        }
        YZTSheetView *sheetView = [[YZTSheetView alloc] initWithTitle:title items:items];
        
        if (onView) {
            sheetView.attachedView = onView;
        }
        
        if (cancelBlock){
            sheetView.cancelBlock = cancelBlock;
        }
        
        if (hiddenBlock){
            sheetView.hideCompletionBlock = hiddenBlock;
        }
        
        if (shownBlock) {
            [sheetView showWithBlock:shownBlock];
        }else{
            [sheetView show];
        }
        
        return sheetView;
    }else{
        PADLog(@"YZTPopViewFactory error: itemTitles is nil or (.count == 0)");
    }
    return nil;
}


#pragma mark - CheckSheet

+ (YZTPopupView *)showCheckSheetWithItemTitles:(NSArray *)itemsTitles
                                 selectedIndex:(NSInteger)selectedIndex
                                    eventBlock:(YZTPopItemEventBlock)eventBlock
{
    return [YZTPopViewFactory showCheckSheetWithItemsInfo:itemsTitles
                                            selectedIndex:selectedIndex
                                               eventBlock:eventBlock];
}

+ (YZTPopupView *)showCheckSheetWithItemsInfo:(NSArray *)itemsInfo
                                selectedIndex:(NSInteger)selectedIndex
                                   eventBlock:(YZTPopItemEventBlock)eventBlock
{
    return [YZTPopViewFactory showCheckSheetWithItemsInfo:itemsInfo
                                            selectedIndex:selectedIndex
                                                   onView:nil
                                               shownBlock:nil
                                               eventBlock:eventBlock
                                              cancelBlock:nil
                                              hiddenBlock:nil];
}

+ (YZTPopupView *)showCheckSheetWithItemsInfo:(NSArray *)itemsInfo
                                selectedIndex:(NSInteger)selectedIndex
                                       onView:(UIView *)onView
                                   shownBlock:(YZTPopupBlock)shownBlock
                                   eventBlock:(YZTPopItemEventBlock)eventBlock
                                  cancelBlock:(YZTPopupBlock)cancelBlock
                                  hiddenBlock:(YZTPopupBlock)hiddenBlock
{
    [YZTPopViewFactory initConfig];
    if (itemsInfo && itemsInfo.count>0) {
        YZTCheckSheetView *checkSheetView = [[YZTCheckSheetView alloc] initWithItemsInfo:itemsInfo selectedIndex:selectedIndex];
        
        if (onView) {
            checkSheetView.attachedView = onView;
        }
        
        if (eventBlock) {
            checkSheetView.checkSheetHander = eventBlock;
        }
        
        if (cancelBlock) {
            checkSheetView.cancelBlock = cancelBlock;
        }
        
        if (hiddenBlock) {
            checkSheetView.hideCompletionBlock = hiddenBlock;
        }
        
        if (shownBlock) {
            [checkSheetView showWithBlock:shownBlock];
        }else{
            [checkSheetView show];
        }
        
        return checkSheetView;
        
    }else{
        PADLog(@"YZTPopViewFactory error: itemInfo is nil or (.count == 0)");
    }
    
    return nil;
}


#pragma mark - AlertView(Confirm)

+ (YZTPopupView *)showAlertConfirmWithTitle:(NSString *)title
                                     detail:(NSString *)detail
{
    return [YZTPopViewFactory showAlertConfirmWithTitle:title
                                                 detail:detail
                                             eventBlock:nil];
}

+ (YZTPopupView *)showAlertConfirmWithTitle:(NSString *)title
                                     detail:(NSString *)detail
                                 eventBlock:(YZTPopItemEventBlock)eventBlock
{
    return [YZTPopViewFactory showAlertConfirmWithTitle:title
                                                 detail:detail
                                             shownBlock:nil
                                             eventBlock:eventBlock
                                            hiddenBlock:nil];
}

+ (YZTPopupView *)showAlertConfirmWithTitle:(NSString *)title
                                     detail:(NSString *)detail
                                 shownBlock:(YZTPopupBlock)shownBlock
                                 eventBlock:(YZTPopItemEventBlock)eventBlock
                                hiddenBlock:(YZTPopupBlock)hiddenBlock
{
    return [YZTPopViewFactory showAlertViewWithTitle:title
                                              detail:detail
                                          itemTitles:@[@"确定"]
                                           itemTypes:nil
                                              onView:nil
                                          shownBlock:shownBlock
                                          eventBlock:eventBlock
                                         hiddenBlock:nil];
}

#pragma mark - AlertView
/**
 *  each button take one row if there are more than 2 items
 */

// title：温馨提示，左按钮：取消，右按钮：确认
+ (YZTPopupView *)showAlertViewWithCancelAndConfirm:(NSString *)detail
                                         eventBlock:(YZTPopItemEventBlock)eventBlock
{
    return [YZTPopViewFactory showAlertViewWithCancelAndConfirm:@"温馨提示"
                                                         detail:detail
                                                     eventBlock:eventBlock];
}

// 左按钮：取消，右按钮：确认
+ (YZTPopupView *)showAlertViewWithCancelAndConfirm:(NSString *)title
                                             detail:(NSString *)detail
                                         eventBlock:(YZTPopItemEventBlock)eventBlock
{
    return [YZTPopViewFactory showAlertViewWithTitle:title
                                              detail:detail
                                          itemTitles:@[@"取消",@"确定"]
                                          eventBlock:eventBlock];
}

+ (YZTPopupView *)showAlertViewWithTitle:(NSString *)title
                                  detail:(NSString *)detail
                              itemTitles:(NSArray *)itemTitles
                              eventBlock:(YZTPopItemEventBlock)eventBlock
{
    return [YZTPopViewFactory showAlertViewWithTitle:title
                                              detail:detail
                                          itemTitles:itemTitles
                                           itemTypes:nil
                                          eventBlock:eventBlock];
}

+ (YZTPopupView *)showAlertViewWithTitle:(NSString *)title
                                  detail:(NSString *)detail
                              itemTitles:(NSArray *)itemTitles
                               itemTypes:(NSArray *)itemTypes
                              eventBlock:(YZTPopItemEventBlock)eventBlock
{
    return [YZTPopViewFactory showAlertViewWithTitle:title
                                              detail:detail
                                          itemTitles:itemTitles
                                           itemTypes:itemTypes
                                              onView:nil
                                          eventBlock:eventBlock];
}

+ (YZTPopupView *)showAlertViewWithTitle:(NSString *)title
                                  detail:(NSString *)detail
                              itemTitles:(NSArray *)itemTitles
                               itemTypes:(NSArray *)itemTypes
                                  onView:(UIView *)onView
                              eventBlock:(YZTPopItemEventBlock)eventBlock
{
    return [YZTPopViewFactory showAlertViewWithTitle:title
                                              detail:detail
                                          itemTitles:itemTitles
                                           itemTypes:itemTypes
                                              onView:onView
                                          shownBlock:nil
                                          eventBlock:eventBlock
                                         hiddenBlock:nil];
}

+ (YZTPopupView *)showAlertViewWithTitle:(NSString *)title
                                  detail:(NSString *)detail
                              itemTitles:(NSArray *)itemTitles
                               itemTypes:(NSArray *)itemTypes
                                  onView:(UIView *)onView
                              shownBlock:(YZTPopupBlock)shownBlock
                              eventBlock:(YZTPopItemEventBlock)eventBlock
                             hiddenBlock:(YZTPopupBlock)hiddenBlock

{
    return [YZTPopViewFactory configAllKindAlertViewWithTitle:title
                                                   customView:nil
                                                       detail:detail
                                                   itemTitles:itemTitles
                                                    itemTypes:itemTypes
                                                       onView:onView
                                                   shownBlock:shownBlock
                                                   eventBlock:eventBlock
                                             eventReturnBlock:nil
                                                  hiddenBlock:hiddenBlock
                                             inputPlaceholder:nil
                                                 inputHandler:nil];
}

#pragma mark - AlertView(Input)

// 默认有“取消”、@“确定”按钮
+ (YZTPopupView *)showAlertInputWithTitle:(NSString *)title
                              placeholder:(NSString *)inputPlaceholder
                                  handler:(YZTPopAlertInputHandler)inputHandler
{
    return [YZTPopViewFactory showAlertInputWithTitle:title
                                           itemTitles:nil
                                          placeholder:inputPlaceholder
                                              handler:inputHandler];
}

// 可自定义itemTitles
+ (YZTPopupView *)showAlertInputWithTitle:(NSString *)title
                               itemTitles:(NSArray *)itemTitles
                              placeholder:(NSString *)inputPlaceholder
                                  handler:(YZTPopAlertInputHandler)inputHandler
{
    return [YZTPopViewFactory showAlertInputWithTitle:title
                                               detail:nil
                                           itemTitles:nil
                                          placeholder:inputPlaceholder
                                               onView:nil
                                              handler:inputHandler];
}

+ (YZTPopupView *)showAlertInputWithTitle:(NSString *)title
                                   detail:(NSString *)detail
                               itemTitles:(NSArray *)itemTitles
                              placeholder:(NSString *)inputPlaceholder
                                   onView:(UIView *)onView
                                  handler:(YZTPopAlertInputHandler)inputHandler
{
    return [YZTPopViewFactory showAlertInputWithTitle:title
                                               detail:detail
                                           itemTitles:itemTitles
                                          placeholder:inputPlaceholder
                                               onView:onView
                                           shownBlock:nil
                                              handler:inputHandler
                                          hiddenBlock:nil];
}

+ (YZTPopupView *)showAlertInputWithTitle:(NSString *)title
                                   detail:(NSString *)detail
                               itemTitles:(NSArray *)itemTitles
                              placeholder:(NSString *)inputPlaceholder
                                   onView:(UIView *)onView
                               shownBlock:(YZTPopupBlock)shownBlock
                                  handler:(YZTPopAlertInputHandler)inputHandler
                              hiddenBlock:(YZTPopupBlock)hiddenBlock
{
    return [YZTPopViewFactory configAllKindAlertViewWithTitle:title
                                                   customView:nil
                                                       detail:detail
                                                   itemTitles:itemTitles
                                                    itemTypes:nil
                                                       onView:onView
                                                   shownBlock:shownBlock
                                                   eventBlock:nil
                                             eventReturnBlock:nil
                                                  hiddenBlock:hiddenBlock
                                             inputPlaceholder:inputPlaceholder
                                                 inputHandler:inputHandler];
}

#pragma mark - AlertView(Password)

//注意：自定义键盘的“确定键”点击后，会返回itemIndex 为 -1，以作区分，可以与弹框的“确定按钮”的事件统一处理
+ (YZTPopupView *)showAlertPasswordWithTitle:(NSString *)title
                                   pwdLength:(NSInteger)pwdLength
                                  itemTitles:(NSArray *)itemTitles
                                     handler:(YZTPopAlertInputHandler)handler
{
    return [YZTPopViewFactory showAlertPasswordWithTitle:title
                                               pwdLength:pwdLength
                                              itemTitles:itemTitles
                                               itemTypes:nil
                                                  onView:nil
                                              shownBlock:nil
                                                 handler:handler
                                             hiddenBlock:nil];
}
//注意：自定义键盘的“确定键”点击后，会返回itemIndex 为 -1，以作区分，可以与弹框的“确定按钮”的事件统一处理
+ (YZTPopupView *)showAlertPasswordWithTitle:(NSString *)title
                                   pwdLength:(NSInteger)pwdLength
                                  itemTitles:(NSArray *)itemTitles
                                   itemTypes:(NSArray *)itemTypes
                                      onView:(UIView *)onView
                                  shownBlock:(YZTPopupBlock)shownBlock
                                     handler:(YZTPopAlertInputHandler)handler
                                 hiddenBlock:(YZTPopupBlock)hiddenBlock

{
    [YZTPopViewFactory initConfig];

    YZTAlertPasswordInputConfig *passwordInputConfig = [[YZTAlertPasswordInputConfig alloc] init];

    YZTAlertView *pwdAlerView = [passwordInputConfig configAlertPasswordViewWithTitle:title pwdLength:pwdLength itemTitles:itemTitles itemTypes:itemTypes handler:handler];
    
    if (onView) {
        pwdAlerView.attachedView = onView;
    }
    
    if (hiddenBlock) {
        pwdAlerView.hideCompletionBlock = hiddenBlock;
    }
    
    if (shownBlock) {
        [pwdAlerView showWithBlock:shownBlock];
    }else{
        [pwdAlerView show];
    }
    
    return pwdAlerView;
}

#pragma mark - AlertView(CustomView)

+ (YZTPopupView *)showAlertCustomViewWithTitle:(NSString *)title
                                    customView:(UIView *)customView
                              eventReturnBlock:(YZTPopItemEventReturnBlock)eventReturnBlock
{
    return [YZTPopViewFactory showAlertCustomViewWithTitle:title
                                                customView:customView
                                                itemTitles:@[@"取消",@"确定"]
                                          eventReturnBlock:eventReturnBlock];
}

+ (YZTPopupView *)showAlertCustomViewWithTitle:(NSString *)title
                                    customView:(UIView *)customView
                                    itemTitles:(NSArray *)itemTitles
                              eventReturnBlock:(YZTPopItemEventReturnBlock)eventReturnBlock
{
    return [YZTPopViewFactory showAlertCustomViewWithTitle:title
                                                customView:customView
                                                itemTitles:itemTitles
                                                    onView:nil
                                          eventReturnBlock:eventReturnBlock];
}

+ (YZTPopupView *)showAlertCustomViewWithTitle:(NSString *)title
                                    customView:(UIView *)customView
                                    itemTitles:(NSArray *)itemTitles
                                        onView:(UIView *)onView
                              eventReturnBlock:(YZTPopItemEventReturnBlock)eventReturnBlock
{
    return [YZTPopViewFactory showAlertCustomViewWithTitle:title
                                                customView:customView
                                                    detail:nil
                                                itemTitles:itemTitles
                                                 itemTypes:nil
                                                    onView:onView
                                          eventReturnBlock:eventReturnBlock];
}

+ (YZTPopupView *)showAlertCustomViewWithTitle:(NSString *)title
                                    customView:(UIView *)customView
                                        detail:(NSString *)detail
                                    itemTitles:(NSArray *)itemTitles
                                     itemTypes:(NSArray *)itemTypes
                                        onView:(UIView *)onView
                              eventReturnBlock:(YZTPopItemEventReturnBlock)eventReturnBlock
{
    return [YZTPopViewFactory showAlertCustomViewWithTitle:title
                                                customView:customView
                                                    detail:detail
                                                itemTitles:itemTitles
                                                 itemTypes:itemTypes
                                                    onView:onView
                                                shownBlock:nil
                                          eventReturnBlock:eventReturnBlock
                                               hiddenBlock:nil];
}

+ (YZTPopupView *)showAlertCustomViewWithTitle:(NSString *)title
                                    customView:(UIView *)customView
                                        detail:(NSString *)detail
                                    itemTitles:(NSArray *)itemTitles
                                     itemTypes:(NSArray *)itemTypes
                                        onView:(UIView *)onView
                                    shownBlock:(YZTPopupBlock)shownBlock
                              eventReturnBlock:(YZTPopItemEventReturnBlock)eventReturnBlock
                                   hiddenBlock:(YZTPopupBlock)hiddenBlock
{
    return [YZTPopViewFactory configAllKindAlertViewWithTitle:title
                                                   customView:customView
                                                       detail:detail
                                                   itemTitles:itemTitles
                                                    itemTypes:itemTypes
                                                       onView:onView
                                                   shownBlock:shownBlock
                                                   eventBlock:nil
                                             eventReturnBlock:eventReturnBlock
                                                  hiddenBlock:hiddenBlock
                                             inputPlaceholder:nil
                                                 inputHandler:nil];
}

#pragma mark - 配置所有类型的AlertView

+ (YZTPopupView *)configAllKindAlertViewWithTitle:(NSString *)title
                                       customView:(UIView *)customView
                                           detail:(NSString *)detail
                                       itemTitles:(NSArray *)itemTitles
                                        itemTypes:(NSArray *)itemTypes
                                           onView:(UIView *)onView
                                       shownBlock:(YZTPopupBlock)shownBlock
                                       eventBlock:(YZTPopItemEventBlock)eventBlock
                                 eventReturnBlock:(YZTPopItemEventReturnBlock)eventReturnBlock
                                      hiddenBlock:(YZTPopupBlock)hiddenBlock
                                 inputPlaceholder:(NSString *)inputPlaceholder
                                     inputHandler:(YZTPopAlertInputHandler)inputHandler
{
    [YZTPopViewFactory initConfig];
    
    NSMutableArray *items = [NSMutableArray new];
    
    if (itemTitles && itemTitles.count>0) {
        
        for (int i = 0; i < itemTitles.count; i++) {
            if (itemTypes && itemTypes.count>i) {
                if ([itemTypes[i] isEqualToString:YZTPopItemTypeNormal] ||
                    [itemTypes[i] isEqualToString:YZTPopItemTypeHighlight] ||
                    [itemTypes[i] isEqualToString:YZTPopItemTypeDisabled]) {
                    [items addObject:MMItemMake(itemTitles[i], [itemTypes[i] integerValue], eventBlock)];
                }else{
                    [items addObject:MMItemMake(itemTitles[i], MMItemTypeNormal, eventBlock)];
                }
            }else{
                [items addObject:MMItemMake(itemTitles[i], MMItemTypeNormal, eventBlock)];
            }
        }
    }
    /*
    else{
        if (!inputHandler) {
            PADLog(@"YZTPopViewFactory error: itemTitles is nil or (.count == 0)");
            return nil;
        }
    }
     */
    YZTAlertView *alertView = [[YZTAlertView alloc] initWithTitle:title
                                                     customView:customView
                                                         detail:detail
                                                          items:items
                                               inputPlaceholder:inputPlaceholder
                                                   inputHandler:inputHandler];
    
    if (eventReturnBlock) {
        alertView.returnHandler = eventReturnBlock;
    }
    
    if (onView) {
        alertView.attachedView = onView;
    }
    
    if (hiddenBlock) {
        alertView.hideCompletionBlock = hiddenBlock;
    }
    
    if (shownBlock) {
        
        [alertView showWithBlock:shownBlock];
    }else{
        [alertView show];
    }
    
    return alertView;
}

#pragma mark - PickerView

// 只有一列数据选择的PickerView
+ (YZTPopupView *)showPickerViewWithRowsCount:(NSInteger)rowsCount
                          returnRowTitleBlock:(YZTPopPickerReturnRowTitle)returnRowTitleBlock
                               confirmHandler:(YZTPopPickerConfirmHandler)confirmHandler
{
    return [YZTPopViewFactory showPickerViewWithRowsCount:rowsCount
                                              wantShowRow:0
                                                   onView:nil
                                      returnRowTitleBlock:returnRowTitleBlock
                                               shownBlock:nil
                                           confirmHandler:confirmHandler
                                              hiddenBlock:nil];
}

+ (YZTPopupView *)showPickerViewWithRowsCount:(NSInteger)rowsCount
                                  wantShowRow:(NSInteger)wantShowRow
                          returnRowTitleBlock:(YZTPopPickerReturnRowTitle)returnRowTitleBlock
                               confirmHandler:(YZTPopPickerConfirmHandler)confirmHandler
{
    return [YZTPopViewFactory showPickerViewWithRowsCount:rowsCount
                                              wantShowRow:wantShowRow
                                                   onView:nil
                                      returnRowTitleBlock:returnRowTitleBlock
                                               shownBlock:nil
                                           confirmHandler:confirmHandler
                                              hiddenBlock:nil];
}

+ (YZTPopupView *)showPickerViewWithRowsCount:(NSInteger)rowsCount
                                  wantShowRow:(NSInteger)wantShowRow
                                       onView:(UIView *)onView
                          returnRowTitleBlock:(YZTPopPickerReturnRowTitle)returnRowTitleBlock
                                   shownBlock:(YZTPopupBlock)shownBlock
                               confirmHandler:(YZTPopPickerConfirmHandler)confirmHandler
                                  hiddenBlock:(YZTPopupBlock)hiddenBlock
{
    return [YZTPopViewFactory showPickerViewWithComponentsNumber:1
                                                    wantShowRows:@[[NSNumber numberWithInteger:wantShowRow]]
                                                          onView:onView
                                                 returnRowsBlock:^NSInteger(NSInteger inComponet, NSArray *selectedRows) {
                                                     
                                                     return rowsCount;
                                                 }
                                             returnRowTitleBlock:^NSString *(NSInteger forComponet, NSInteger forRow, NSArray *selectedRows) {
                                                 
                                                 return returnRowTitleBlock(forRow);
                                             }
                                                      shownBlock:shownBlock
                                                  confirmHandler:^(NSArray *selectedRows, NSArray *selectedTitles){
                                                      
                                                      confirmHandler([[selectedRows firstObject] integerValue],[selectedTitles firstObject]);
                                                  }
                                                     hiddenBlock:hiddenBlock];
}

// 两列及以上的PickerView
+ (YZTPopupView *)showPickerViewWithComponentsNumber:(NSInteger)cNumber
                                     returnRowsBlock:(YZTPickerViewReturnRows)returnRowsBlock
                                 returnRowTitleBlock:(YZTPickerViewReturnRowTitle)returnRowTitleBlock
                                      confirmHandler:(YZTPickerViewConfirmHandler)confirmHandler
{
    return [YZTPopViewFactory showPickerViewWithComponentsNumber:cNumber
                                                    wantShowRows:0
                                                          onView:nil
                                                 returnRowsBlock:returnRowsBlock
                                             returnRowTitleBlock:returnRowTitleBlock
                                                      shownBlock:nil
                                                  confirmHandler:confirmHandler
                                                     hiddenBlock:nil];
}

+ (YZTPopupView *)showPickerViewWithComponentsNumber:(NSInteger)cNumber
                                        wantShowRows:(NSArray *)wantShowRows
                                     returnRowsBlock:(YZTPickerViewReturnRows)returnRowsBlock
                                 returnRowTitleBlock:(YZTPickerViewReturnRowTitle)returnRowTitleBlock
                                      confirmHandler:(YZTPickerViewConfirmHandler)confirmHandler
{
    return [YZTPopViewFactory showPickerViewWithComponentsNumber:cNumber
                                                    wantShowRows:wantShowRows
                                                          onView:nil
                                                 returnRowsBlock:returnRowsBlock
                                             returnRowTitleBlock:returnRowTitleBlock
                                                      shownBlock:nil
                                                  confirmHandler:confirmHandler
                                                     hiddenBlock:nil];
}

+ (YZTPopupView *)showPickerViewWithComponentsNumber:(NSInteger)cNumber
                                        wantShowRows:(NSArray *)wantShowRows
                                              onView:(UIView *)onView
                                     returnRowsBlock:(YZTPickerViewReturnRows)returnRowsBlock
                                 returnRowTitleBlock:(YZTPickerViewReturnRowTitle)returnRowTitleBlock
                                          shownBlock:(YZTPopupBlock)shownBlock
                                      confirmHandler:(YZTPickerViewConfirmHandler)confirmHandler
                                         hiddenBlock:(YZTPopupBlock)hiddenBlock
{
    [YZTPopViewFactory initConfig];

    YZTPickerView *pickerView = [[YZTPickerView alloc] initWithComponentsNumber:cNumber];
    pickerView.wantShowRows = wantShowRows;
    pickerView.returnRowsBlock = returnRowsBlock;
    pickerView.returnRowTitleBlock = returnRowTitleBlock;
    
    if (confirmHandler) {
        pickerView.pickerViewHandler = confirmHandler;
    }
    
    if (onView) {
        pickerView.attachedView = onView;
    }
    
    if (hiddenBlock) {
        pickerView.hideCompletionBlock = hiddenBlock;
    }
    
    if (shownBlock) {
        [pickerView showWithBlock:shownBlock];
    }else{
        [pickerView show];
    }
    
    return pickerView;
}

#pragma mark - RightPickerView
+ (YZTPopupView *)showRightPickerViewWithComponentsNumber:(NSInteger)cNumber
                                          returnRowsBlock:(YZTRightPickerViewReturnRows)returnRowsBlock
                                      returnRowTitleBlock:(YZTRightPickerViewReturnRowTitle)returnRowTitleBlock
                                           confirmHandler:(YZTRightPickerViewConfirmHandler)confirmHandler
{
    return [YZTPopViewFactory showRightPickerViewWithComponentsNumber:(NSInteger)cNumber
                                                         wantShowRows:(NSArray *)nil
                                                      returnRowsBlock:(YZTRightPickerViewReturnRows)returnRowsBlock
                                                  returnRowTitleBlock:(YZTRightPickerViewReturnRowTitle)returnRowTitleBlock
                                                       confirmHandler:(YZTRightPickerViewConfirmHandler)confirmHandler];
}

+ (YZTPopupView *)showRightPickerViewWithComponentsNumber:(NSInteger)cNumber
                                             wantShowRows:(NSArray *)wantShowRows
                                          returnRowsBlock:(YZTRightPickerViewReturnRows)returnRowsBlock
                                      returnRowTitleBlock:(YZTRightPickerViewReturnRowTitle)returnRowTitleBlock
                                           confirmHandler:(YZTRightPickerViewConfirmHandler)confirmHandler
{
    return [YZTPopViewFactory showRightPickerViewWithComponentsNumber:(NSInteger)cNumber
                                                         wantShowRows:(NSArray *)wantShowRows
                                                               onView:(UIView *)nil
                                                      returnRowsBlock:(YZTRightPickerViewReturnRows)returnRowsBlock
                                                  returnRowTitleBlock:(YZTRightPickerViewReturnRowTitle)returnRowTitleBlock
                                                           shownBlock:(YZTPopupBlock)nil
                                                       confirmHandler:(YZTRightPickerViewConfirmHandler)confirmHandler
                                                          hiddenBlock:(YZTPopupBlock)nil];
    
}

+(YZTPopupView *)showRightPickerViewWithComponentsNumber:(NSInteger)cNumber
                                            wantShowRows:(NSArray *)wantShowRows
                                                  onView:(UIView *)onView
                                         returnRowsBlock:(YZTRightPickerViewReturnRows)returnRowsBlock
                                     returnRowTitleBlock:(YZTRightPickerViewReturnRowTitle)returnRowTitleBlock
                                              shownBlock:(YZTPopupBlock)shownBlock
                                          confirmHandler:(YZTRightPickerViewConfirmHandler)confirmHandler
                                             hiddenBlock:(YZTPopupBlock)hiddenBlock
{
    [YZTPopViewFactory initConfig];
    
    YZTRightPickerView *rightPickerView = [[YZTRightPickerView alloc] initWithComponentsNumber:cNumber];
    rightPickerView.wantShowRows = wantShowRows;
    rightPickerView.returnRowsBlock = returnRowsBlock;
    rightPickerView.returnRowTitleBlock = returnRowTitleBlock;
    
    if (confirmHandler) {
        rightPickerView.pickerViewHandler = confirmHandler;
    }
    
    if (onView) {
        rightPickerView.attachedView = onView;
    }
    
    if (hiddenBlock) {
        rightPickerView.hideCompletionBlock = hiddenBlock;
    }
    
    if (shownBlock) {
        [rightPickerView showWithBlock:shownBlock];
    }else{
        [rightPickerView show];
    }
    
    return rightPickerView;

}

#pragma mark - DateView

+ (YZTPopupView *)showDateViewWithMode:(UIDatePickerMode)dateMode
                               maxDate:(NSDate *)maxDate
                        confirmHandler:(YZTDateViewConfirmHandler)confirmHandler{
    return [YZTPopViewFactory showDateViewWithMode:dateMode
                                          showDate:nil
                                           minDate:nil
                                           maxDate:maxDate
                                            onView:nil
                                        shownBlock:nil
                                    confirmHandler:confirmHandler
                                       hiddenBlock:nil];
}


+ (YZTPopupView *)showDateViewWithMode:(UIDatePickerMode)dateMode
                               maxDate:(NSDate *)maxDate
                                   isGMT0:(BOOL)isUTC0
                        confirmHandler:(YZTDateViewConfirmHandler)confirmHandler
{
    return [YZTPopViewFactory showDateViewWithMode:dateMode
                                            isGTMO:(BOOL)isUTC0
                                          showDate:nil
                                           minDate:nil
                                           maxDate:maxDate
                                            onView:nil
                                        shownBlock:nil
                                    confirmHandler:confirmHandler
                                       hiddenBlock:nil];
}

+ (YZTPopupView *)showDateViewWithMode:(UIDatePickerMode)dateMode
                              showDate:(NSDate *)showDate
                               minDate:(NSDate *)minDate
                               maxDate:(NSDate *)maxDate
                        confirmHandler:(YZTDateViewConfirmHandler)confirmHandler
{
    return [YZTPopViewFactory showDateViewWithMode:dateMode
                                          showDate:showDate
                                           minDate:minDate
                                           maxDate:maxDate
                                            onView:nil
                                        shownBlock:nil
                                    confirmHandler:confirmHandler
                                       hiddenBlock:nil];
}

+ (YZTPopupView *)showDateViewWithMode:(UIDatePickerMode)dateMode
                                  isGTMO:(BOOL)isUTC0
                                showDate:(NSDate *)showDate
                                 minDate:(NSDate *)minDate
                                 maxDate:(NSDate *)maxDate
                                  onView:(UIView *)onView
                              shownBlock:(YZTPopupBlock)shownBlock
                          confirmHandler:(YZTDateViewConfirmHandler)confirmHandler
                           hiddenBlock:(YZTPopupBlock)hiddenBlock{
    [YZTPopViewFactory initConfig];
    
    YZTDateView *dateView = [[YZTDateView alloc] initWithDateMode:dateMode showDate:showDate minDate:minDate maxDate:maxDate];;
    dateView.isUTC0 = isUTC0;
    if (confirmHandler) {
        dateView.confirmHandler = confirmHandler;
    }
    
    if (onView) {
        dateView.attachedView = onView;
    }
    
    if (hiddenBlock) {
        dateView.hideCompletionBlock = hiddenBlock;
    }
    
    if (shownBlock) {
        [dateView showWithBlock:shownBlock];
    }else{
        [dateView show];
    }
    
    return dateView;
}

+ (YZTPopupView *)showDateViewWithMode:(UIDatePickerMode)dateMode
                              showDate:(NSDate *)showDate
                               minDate:(NSDate *)minDate
                               maxDate:(NSDate *)maxDate
                                onView:(UIView *)onView
                            shownBlock:(YZTPopupBlock)shownBlock
                        confirmHandler:(YZTDateViewConfirmHandler)confirmHandler
                           hiddenBlock:(YZTPopupBlock)hiddenBlock
{
    [YZTPopViewFactory initConfig];

    YZTDateView *dateView = [[YZTDateView alloc] initWithDateMode:dateMode showDate:showDate minDate:minDate maxDate:maxDate];;
    
    if (confirmHandler) {
        dateView.confirmHandler = confirmHandler;
    }
    
    if (onView) {
        dateView.attachedView = onView;
    }
    
    if (hiddenBlock) {
        dateView.hideCompletionBlock = hiddenBlock;
    }
    
    if (shownBlock) {
        [dateView showWithBlock:shownBlock];
    }else{
        [dateView show];
    }
        
    return dateView;
}

//YZTYearMonthDateView

+ (YZTPopupView *)showYearMonthDateViewWithMinYear:(NSInteger)minYear
                                           MaxYear:(NSInteger)maxYear
                                            onView:(UIView *)onView
                                      WantShowRows:(NSArray *)wantShowRows
                                    confirmHandler:(YZTYearMonthConfirmHandler)confirmHandler
{
    [YZTPopViewFactory initConfig];
    YZTYearMonthDateView *ymDateView = [[YZTYearMonthDateView alloc] initWithMinYear:minYear
                                                                             MaxYear:maxYear];
    ymDateView.wantShowRows = wantShowRows;
    
    if (confirmHandler) {
        ymDateView.dateConfirmHandler = confirmHandler;
    }
    
    if (onView) {
        ymDateView.attachedView = onView;
    }
    
    [ymDateView show];
    
    return ymDateView;
}

+ (YZTPopupView *)showYearMonthDateViewWithMinYear:(NSInteger)minYear
                                           MaxYear:(NSInteger)maxYear
                                          maxMonth:(NSInteger)maxMonth
                                            onView:(UIView *)onView
                                      WantShowRows:(NSArray *)wantShowRows
                                    confirmHandler:(YZTYearMonthConfirmHandler)confirmHandler
{
    [YZTPopViewFactory initConfig];
    YZTYearMonthDateView *ymDateView = [[YZTYearMonthDateView alloc] initWithMinYear:minYear
                                                                             MaxYear:maxYear];
    ymDateView.wantShowRows = wantShowRows;
    
    ymDateView.maxMonth = [NSNumber numberWithInteger:maxMonth];
    
    if (confirmHandler) {
        ymDateView.dateConfirmHandler = confirmHandler;
    }
    
    if (onView) {
        ymDateView.attachedView = onView;
    }
    
    [ymDateView show];
    
    return ymDateView;
}


#pragma mark - ToastView(土司)

+ (void)showToastViewWithDetail:(NSString *)detail
{
    [YZTPopViewFactory showToastViewWithDetail:detail hiddenBlock:nil];
}

+ (void)showToastViewWithDetail:(NSString *)detail
                    hiddenBlock:(YZTPopupBlock)hiddenBlock
{
    [YZTPopViewFactory showToastViewWithDetail:detail
                                   staySeconds:1.5
                                  hiddenBlock:hiddenBlock];
}

+ (void)showToastViewWithDetail:(NSString *)detail
                    staySeconds:(double)seconds
                    hiddenBlock:(YZTPopupBlock)hiddenBlock
{
    [YZTPopViewFactory showToastViewWithTitle:nil
                                       detail:detail
                                  staySeconds:seconds
                                   shownBlock:nil
                                  hiddenBlock:hiddenBlock];
}

+ (void)showToastViewWithTitle:(NSString *)title
                        detail:(NSString *)detail
                   staySeconds:(double)seconds
                    shownBlock:(YZTPopupBlock)shownBlock
                   hiddenBlock:(YZTPopupBlock)hiddenBlock
{
    [YZTPopViewFactory touchWildToHide:NO];
    
    YZTPopupView *toastView = [YZTPopViewFactory showAlertViewWithTitle:title
                                                                 detail:detail
                                                             itemTitles:nil
                                                              itemTypes:nil
                                                                 onView:nil
                                                             shownBlock:shownBlock
                                                             eventBlock:nil
                                                            hiddenBlock:hiddenBlock];
    
    
    double delayInSeconds = seconds;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [toastView hide];
    });
}

@end
