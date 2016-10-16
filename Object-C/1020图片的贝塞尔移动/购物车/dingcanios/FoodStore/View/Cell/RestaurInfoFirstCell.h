//
//  RestaurInfoFirstCell.h
//  FoodStore
//
//  Created by liuguopan on 14/12/31.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurInfoFirstCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *RestaurIconImgView;

@property (weak, nonatomic) IBOutlet UILabel *restaurNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *favBtn;
@property (weak, nonatomic) IBOutlet UILabel *pingfenLabel;
@property (weak, nonatomic) IBOutlet UILabel *shijianLabel;
@property (weak, nonatomic) IBOutlet UILabel *qisongjiaLabel;
@property (weak, nonatomic) IBOutlet UILabel *peisongfeiLabel;

@end
