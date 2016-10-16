//
//  UITableView+ReloadData.h
//  PANewToapAPP
//
//  Created by ChuckonYin on 15/11/10.
//  Copyright © 2015年 Gavin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (CYAdd)

/**
 *  代理切换，当加载数据失败时使用“tableview”充当自身代理；当加载数据失败时使用“原始”代理
 */
@property(nonatomic, assign) id delegateCache;
/**
 *  刷新失败加载图片
 *
 *  @param dataArr 表视图数据
 *  @param img     UIImage/NSString
 *
 *  @return failedView
 */
- (UIView*)reloadDataSafety:(NSArray*)dataArr failedImage:(id)img;
/**
 *  刷新失败加载文字
 *
 *  @param dataArr 表视图数据
 *  @param img     NSString
 *
 *  @return failedView
 */
- (UIView*)reloadDataSafety:(NSArray*)dataArr failedTitle:(NSString*)failedDescribe;

@end
