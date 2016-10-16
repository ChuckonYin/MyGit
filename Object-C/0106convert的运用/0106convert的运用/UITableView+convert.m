//
//  UITableView+convert.m
//  0106convert的运用
//
//  Created by ChuckonYin on 16/1/6.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "UITableView+convert.h"
#import <objc/runtime.h>
@implementation UITableView (convert)

- (void)setToScreenBottom:(NSNumber *)toScreenBottom
{
    objc_setAssociatedObject(self, @selector(toScreenBottom), toScreenBottom, OBJC_ASSOCIATION_RETAIN);
}
- (NSNumber *)toScreenBottom
{
    return objc_getAssociatedObject(self, @selector(toScreenBottom));
}
- (void)scrollToShowLastIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
    UIView *fullScreenView = [[self viewController] view];
    CGRect r = [cell convertRect:cell.bounds toView:fullScreenView];
    self.toScreenBottom = @(fullScreenView.bounds.size.height - r.origin.y-r.size.height);
//    [NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginScroll:) name: object:
}

- (void)beginScroll:(NSNotification*)not
{
    
    CGFloat keyBoardHeight = 100;
    if ([self.toScreenBottom floatValue] < keyBoardHeight) {
        //需要弹
        self.contentOffset = CGPointMake(self.contentOffset.x, self.contentOffset.y + [self.toScreenBottom floatValue] - keyBoardHeight);
    }
    else{
        //不弹
    }
}

- (UIViewController *)viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
