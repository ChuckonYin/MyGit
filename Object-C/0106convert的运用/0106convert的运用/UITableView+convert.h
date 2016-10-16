//
//  UITableView+convert.h
//  0106convert的运用
//
//  Created by ChuckonYin on 16/1/6.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (convert)

@property (nonatomic, strong, readonly) NSIndexPath *lastVisibleIndexPath;

@property (nonatomic, strong) NSNumber *toScreenBottom;

- (void)scrollToShowLastIndexPath:(NSIndexPath*)indexPath;

@end
