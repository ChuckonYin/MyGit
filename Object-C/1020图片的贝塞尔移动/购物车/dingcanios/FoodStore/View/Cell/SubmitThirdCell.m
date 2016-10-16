//
//  SubmitThirdCell.m
//  FoodStore
//
//  Created by liuguopan on 15/1/5.
//  Copyright (c) 2015年 viewcreator3d. All rights reserved.
//

#import "SubmitThirdCell.h"

@interface SubmitThirdCell ()

@property (nonatomic, strong) UIView *bgView;

@end

@implementation SubmitThirdCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1.00f];
        [self createBackgroundView];
        [self createTitleLabel];
        [self createPickTimeView];
        [self createDinersNumberView];
//        [self createMutipleChoiceButton];
//        [self createOtherAvoidFoodsTextView];
        [self initView];
    }
    return self;
}
- (void)initView
{
    UITextField *dinersNumberTextField = [[UITextField alloc] init];
    dinersNumberTextField.frame = CGRectMake(10.0f, 120.0f, self.bgView.frame.size.width - 20.f, 40.0f);
    dinersNumberTextField.backgroundColor = [UIColor whiteColor];
    dinersNumberTextField.placeholder = @"忌口/留言";
    dinersNumberTextField.keyboardType = UIKeyboardAppearanceDefault;
    dinersNumberTextField.font = [UIFont systemFontOfSize:16.0f];
    dinersNumberTextField.layer.borderWidth = 1.0f;
    dinersNumberTextField.layer.borderColor = [[UIColor grayColor] CGColor];
    dinersNumberTextField.returnKeyType = UIReturnKeyDone;
    [self.bgView addSubview:dinersNumberTextField];
    self.infoField = dinersNumberTextField;
}
- (void)createBackgroundView
{
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(5.0f, 4.0f, SCREEN_WIDTH - 5.0f - 5.0f, 170.0f);
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    self.bgView = bgView;
}

- (void)createTitleLabel
{
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(10.0f, 10.0f, 80.0f, 15.0f);
    titleLabel.text = @"配送信息";
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    [self.bgView addSubview:titleLabel];
}

- (void)createPickTimeView
{
    VCButton *nowButton = [VCButton buttonWithType:UIButtonTypeCustom];
    nowButton.frame = CGRectMake(10.0f, 35.0f, 100.0f, 25.0f);
    nowButton.backgroundColor = [UIColor whiteColor];
    [nowButton setTitle:@"立即配送" forState:UIControlStateNormal];
    [nowButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [nowButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -25.0f, 0, 20.0f)];
    [nowButton setImage:[UIImage imageNamed:@"submit_unselected.png"]
               forState:UIControlStateNormal];
    [nowButton setImage:[UIImage imageNamed:@"submit_selected.png"]
               forState:UIControlStateSelected];
    [nowButton setImageEdgeInsets:UIEdgeInsetsMake(4.5f, 0, 4.5f, 84.0f)];
    nowButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    nowButton.adjustsImageWhenHighlighted = NO;
    nowButton.selected = YES;
    [self.bgView addSubview:nowButton];
    self.nowButton = nowButton;
    
    VCButton *pickTimeButton = [VCButton buttonWithType:UIButtonTypeCustom];
    pickTimeButton.frame = CGRectMake(10.0f, 35.0f + 25.0f, 100.0f, 25.0f);
    pickTimeButton.backgroundColor = [UIColor whiteColor];
    [pickTimeButton setTitle:@"选择时间" forState:UIControlStateNormal];
    [pickTimeButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -25.0f, 0, 20.0f)];
    [pickTimeButton setImage:[UIImage imageNamed:@"submit_unselected.png"]
                    forState:UIControlStateNormal];
    [pickTimeButton setImage:[UIImage imageNamed:@"submit_selected.png"]
                    forState:UIControlStateSelected];
    [pickTimeButton setImageEdgeInsets:UIEdgeInsetsMake(4.5f, 0, 4.5f, 84.0f)];
    [pickTimeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    pickTimeButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    pickTimeButton.adjustsImageWhenHighlighted = NO;
    [self.bgView addSubview:pickTimeButton];
    self.pickTimeButton = pickTimeButton;
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.frame = CGRectMake(10.0f + 100.0f, 35.0f + 25.0f, 120.0f, 25.0f);
    timeLabel.backgroundColor = [UIColor whiteColor];
    timeLabel.text = @"2015-1-15 16:37";
    timeLabel.textColor = [UIColor lightGrayColor];
    timeLabel.font = [UIFont systemFontOfSize:12.0f];
    [self.bgView addSubview:timeLabel];
    self.timeLabel = timeLabel;
}

- (void)createDinersNumberView
{   
    UIButton *dinersNumberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dinersNumberBtn.frame = CGRectMake(10.0f, 85.0f, 70.0f, 25.0f);
    dinersNumberBtn.backgroundColor = [UIColor whiteColor];
    [dinersNumberBtn setTitle:@"用餐人数" forState:UIControlStateNormal];
    [dinersNumberBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [dinersNumberBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -11.0f, 0, 0.0f)];
    [dinersNumberBtn setImage:[UIImage imageNamed:@"submit_person.png"]
                     forState:UIControlStateNormal];
    [dinersNumberBtn setImageEdgeInsets:UIEdgeInsetsMake(5.0f, 0, 5.0f, 55.0f)];
    dinersNumberBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    dinersNumberBtn.enabled = NO;
    [self.bgView addSubview:dinersNumberBtn];
    
    UITextField *dinersNumberTextField = [[UITextField alloc] init];
    dinersNumberTextField.frame = CGRectMake(95.0f, 85.0f, 100.0f, 25.0f);
    dinersNumberTextField.backgroundColor = [UIColor whiteColor];
//    dinersNumberTextField.placeholder = @" 点击选择人数";
    dinersNumberTextField.text = @"1";
    dinersNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    dinersNumberTextField.font = [UIFont systemFontOfSize:12.0f];
    dinersNumberTextField.layer.borderWidth = 1.0f;
    dinersNumberTextField.layer.borderColor = [[UIColor grayColor] CGColor];
    dinersNumberTextField.textAlignment = NSTextAlignmentCenter;
    dinersNumberTextField.returnKeyType = UIReturnKeyDone;
    [self.bgView addSubview:dinersNumberTextField];
    self.dinersNuberTextField = dinersNumberTextField;
}

//// 回收键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.dinersNuberTextField resignFirstResponder];
//    [self.otherAvoidFoodsTextView resignFirstResponder];
//    [self.infoField resignFirstResponder];
}

- (void)createMutipleChoiceButton
{
    CGFloat width_4 = (self.bgView.frame.size.width - 10.0f - 10.0f) / 4;
    for (int i = 0; i < 4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10.0f + width_4 * i, 130.0f, width_4, 15.0f);
        btn.backgroundColor = [UIColor grayColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:8.0f];
        [self.bgView addSubview:btn];
        [self setPropery:btn index:i];
    }
}

- (void)setPropery:(UIButton *)btn index:(int)i
{
    switch (i) {
        case 0: {
            [btn setTitle:@"全单免葱" forState:UIControlStateNormal];
            self.mutipleChoiceButton1 = btn;
        }
            break;
        case 1: {
            [btn setTitle:@"全单免香菜" forState:UIControlStateNormal];
            self.mutipleChoiceButton2 = btn;
        }
            break;
        case 2: {
            [btn setTitle:@"全单免姜" forState:UIControlStateNormal];
            self.mutipleChoiceButton3 = btn;
        }
            break;
        case 3: {
            [btn setTitle:@"全单免蒜" forState:UIControlStateNormal];
            self.mutipleChoiceButton4 = btn;
        }
            break;
        default:
            break;
    }
}

- (void)createOtherAvoidFoodsTextView
{
    UITextView *otherAvoidFoodsTextView = [[UITextView alloc] init];
    otherAvoidFoodsTextView.frame = CGRectMake(10.0f, 160.0f, self.bgView.frame.size.width - 10.f - 10.0f, 50.0f);
    otherAvoidFoodsTextView.backgroundColor = [UIColor lightGrayColor];
    otherAvoidFoodsTextView.keyboardType = UIKeyboardAppearanceDefault;
    otherAvoidFoodsTextView.returnKeyType = UIReturnKeyDone;
    [self.bgView addSubview:otherAvoidFoodsTextView];
    self.otherAvoidFoodsTextView = otherAvoidFoodsTextView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
