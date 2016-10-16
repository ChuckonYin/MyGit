//
//  CommentCell.h
//  FoodStore
//
//  Created by ZhangShouC on 2/4/15.
//  Copyright (c) 2015 liuguopan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommentCellDelegate <NSObject>

- (void)starClick:(NSIndexPath *)indexPath index:(NSInteger)index;

@end


@interface CommentCell : UITableViewCell

@property (nonatomic,strong) UILabel * nameLabel;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,strong) NSIndexPath * indexPath;

@property (nonatomic,weak) __weak id<CommentCellDelegate> delegate;
- (void)setStar:(NSInteger)index;

@end
