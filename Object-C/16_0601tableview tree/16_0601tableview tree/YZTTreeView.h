//
//  YZTTreeView.h
//  16_0601tableview tree
//
//  Created by apple on 16/6/1.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YZTTreeViewDelegate <NSObject>

- (UITableViewCell *)yztTreeView:(UITableView *)tableView cellForRowAtNode:(NSArray *)node;

- (NSInteger)yztTreeView:(UITableView *)tableView numberOfRowsAtNode:(NSArray *)node;

@end

@interface YZTTreeView : UITableView

@property (nonatomic, assign) id<YZTTreeViewDelegate> delegate;

@end
