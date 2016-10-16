//
//  UITableView+ReloadData.m
//  PANewToapAPP
//
//  Created by ChuckonYin on 15/11/10.
//  Copyright © 2015年 Gavin. All rights reserved.
//

#define failedViewTAG 9999

#import "UITableView+CYAdd.h"

@implementation UITableView (CYAdd)

- (UIView *)reloadDataSafety:(NSArray*)dataArr failedImage:(id)img{
    UIView *failedView = nil;
    if (dataArr.count==0) {
        failedView = [[UIView alloc] initWithFrame:self.bounds];
        failedView.tag = failedViewTAG;
        failedView.backgroundColor = [UIColor whiteColor];
        [self addSubview:failedView];
        if (img && [img isKindOfClass:[UIImage class]]) {
            failedView.layer.contents = (id)[(UIImage*)img CGImage];
        }
        else if (img &&[img isKindOfClass:[NSString class]]){
            failedView.layer.contents = (id)[[UIImage imageNamed:(NSString*)img] CGImage];
        }
    }
    else{
        for (UIView *view in self.subviews) {
            if (view.tag == failedViewTAG) {
                [view removeFromSuperview];
            }
        }
    }
    [self reloadData];
    return failedView;
}

- (UIView*)reloadDataSafety:(NSArray*)dataArr failedTitle:(NSString*)failedDescribe{
    UIView *failedView = [self reloadDataSafety:dataArr failedImage:nil];
    if (failedView && failedDescribe) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        label.center = point(kScreenWidth/2,kScreenHeight/2);
        label.textAlignment = NSTextAlignmentCenter;
        label.text = failedDescribe;
        label.font = chineseFont(14);
        label.textColor = [UIColor colorWithRed:0.75 green:75 blue:75 alpha:1];
        [failedView addSubview:label];
    }
    return failedView;
}

//- (void)reloadDataSafety:(NSArray*)dataArr{
//    if (self.delegate != self) {
//        self.delegateCache = self.delegate;
//    }
//    if (!dataArr || dataArr.count==0) {
//        self.delegate = self;
//        MyFinancialRequestFailView *failBackView = [[MyFinancialRequestFailView alloc] initWithFrame:self.frame];
//        failBackView.backgroundColor = [UIColor whiteColor];
//        [self addSubview:failBackView];
//    }
//    else{
//        self.delegate = self.delegateCache;
//        for (UIView *view in self.subviews) {
//            if ([view isKindOfClass:[MyFinancialRequestFailView class]]) {
//                [view removeFromSuperview];
//            }
//        }
//    }
//    [self reloadData];
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 0;
//}
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return nil;
//}
////将tableview的代理存储起来
//-(void)setDelegateCache:(id)delegateCache
//{
//    objc_setAssociatedObject(self, @selector(delegateCache), delegateCache, OBJC_ASSOCIATION_ASSIGN);
//}
//-(id)delegateCache
//{
//    return objc_getAssociatedObject(self, @selector(delegateCache));
//}






@end
