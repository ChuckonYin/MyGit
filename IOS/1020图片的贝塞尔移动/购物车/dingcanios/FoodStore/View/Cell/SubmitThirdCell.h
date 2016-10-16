//
//  SubmitThirdCell.h
//  FoodStore
//
//  Created by liuguopan on 15/1/5.
//  Copyright (c) 2015年 viewcreator3d. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCButton.h"

@interface SubmitThirdCell : UITableViewCell

@property (nonatomic, strong) VCButton *nowButton;
@property (nonatomic, strong) VCButton *pickTimeButton;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic, strong) UITextField *dinersNuberTextField;
@property (nonatomic,strong) UITextField * infoField;
/**
 *  全单免葱
 */
@property (nonatomic, strong) UIButton *mutipleChoiceButton1;
/**
 *  全单免香菜
 */
@property (nonatomic, strong) UIButton *mutipleChoiceButton2;
/**
 *  全单免姜
 */
@property (nonatomic, strong) UIButton *mutipleChoiceButton3;
/**
 *  全单免蒜
 */
@property (nonatomic, strong) UIButton *mutipleChoiceButton4;

@property (nonatomic, strong) UITextView *otherAvoidFoodsTextView;


@end
