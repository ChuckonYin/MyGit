//
//  YZTAlertInputPassword.m
//  PANewToapAPP
//
//  Created by apple on 15/11/12.
//  Copyright © 2015年 Gavin. All rights reserved.
//

#import "YZTAlertPasswordInputConfig.h"
#import "YZTPopupItem.h"
#import "APNumberPad.h"

#define AdviceWidth    60.0
#define AdviceHeight   40.0
#define BalckPoinWidth 8.0

@class YZTBlackPointView;

@interface YZTAlertPasswordInputConfig()<UITextFieldDelegate,APNumberPadDelegate>

@property (nonatomic, copy) YZTPopAlertInputHandler eventHandler;
@property (nonatomic, strong) YZTAlertView *alertView;
@property (nonatomic, assign) NSUInteger pwdLength;
@property (nonatomic, strong) UITextField *pwdTextField;
@property (nonatomic, strong) NSMutableArray *bpViews;

@end

@implementation YZTAlertPasswordInputConfig

- (YZTAlertView *)configAlertPasswordViewWithTitle:(NSString *)title
                                         pwdLength:(NSInteger)length
                                        itemTitles:(NSArray *)itemTitles
                                         itemTypes:(NSArray *)itemTypes
                                           handler:(YZTPopAlertInputHandler)handler
{
    _eventHandler = handler;
    _pwdLength = length;
    UIView *customView = [self createPwdInputView
                          :length];
    
    NSMutableArray *items = [NSMutableArray new];
    
    if (itemTitles && itemTitles.count>0) {
        
        for (int i = 0; i < itemTitles.count; i++) {
            if (itemTypes && itemTypes.count>i) {
                if ([itemTypes[i] isEqualToString:YZTPopItemTypeNormal] ||
                    [itemTypes[i] isEqualToString:YZTPopItemTypeHighlight] ||
                    [itemTypes[i] isEqualToString:YZTPopItemTypeDisabled]) {
                    [items addObject:MMItemMake(itemTitles[i], [itemTypes[i] integerValue], nil)];
                }else{
                    [items addObject:MMItemMake(itemTitles[i], MMItemTypeNormal, nil)];
                }
            }else{
                [items addObject:MMItemMake(itemTitles[i], MMItemTypeNormal, nil)];
            }
        }
    }else{
//        PADLog(@"YZTPopViewFactory error: itemTitles is nil or (.count == 0)");
    }
    
//    YZTAlertView *alertView = [[YZTAlertView alloc] initWithTitle:title customView:customView detail:nil items:items inputPlaceholder:nil inputHandler:nil];
    YZTAlertView * alertView = [[YZTAlertView alloc]initWithTitle:title InputView:customView detail:nil items:items];
    alertView.withKeyboard = YES;

    alertView.returnHandler = ^(NSInteger itemIndex){

        if (_eventHandler(itemIndex, _pwdTextField.text)) {
            [_pwdTextField resignFirstResponder];
            return YES;
        }else{
            return NO;
        }
    };
    
    [_pwdTextField becomeFirstResponder];
    
    _alertView = alertView;
    
    return alertView;
}

- (UIView *)createPwdInputView:(NSInteger)pwdLength
{
    UIView *containerView = [[UIView alloc] init];
    
    UIView *borderView = [[UIView alloc] init];
    [borderView.layer setMasksToBounds:YES];
    [borderView.layer setBorderWidth:1];
    [borderView.layer setBorderColor:RGB(204, 204, 204).CGColor];
    [borderView clipsToBounds];
    [containerView addSubview:borderView];
    
    _pwdTextField = [[UITextField alloc] init];
    _pwdTextField.keyboardType = UIKeyboardTypeNumberPad;
    _pwdTextField.hidden = YES;
    _pwdTextField.delegate = self;
    _pwdTextField.inputView = ({
        
        APNumberPad *numberPad = [APNumberPad numberPadWithDelegate:self];
        
        [numberPad.leftFunctionButton setTitle:@"B" forState:UIControlStateNormal];
        
        numberPad.leftFunctionButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        
        numberPad;
    });
    
    [containerView addSubview:_pwdTextField];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToInput)];
    [borderView addGestureRecognizer:tapGR];
    
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat maxWidth = (screenWidth - 40*2)/pwdLength;
//    CGFloat maxWidth = screenWidth;
    CGFloat realWidth = AdviceWidth;
    CGFloat realHeight = AdviceHeight;
    if (maxWidth < AdviceWidth) {
        realWidth = maxWidth;
        //realHeight = realWidth - 4;
    }
//    containerView.frame = CGRectMake(0, 0, realWidth*pwdLength+18*2, realHeight);
    containerView.frame = CGRectMake(0, 0, kScreenWidth, realHeight);
    [borderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(containerView);
        make.size.mas_equalTo(CGSizeMake(realWidth*pwdLength, realHeight));
    }];
    
    MASViewAttribute *lastAttribute = borderView.mas_left;
    _bpViews = [[NSMutableArray alloc] init];
    for (int i =0; i < pwdLength; i++) {
        YZTBlackPointView *bpView = [[YZTBlackPointView alloc] init];
        [borderView addSubview:bpView];
        [bpView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(borderView);
            make.size.mas_equalTo(CGSizeMake(realWidth, realHeight));
            make.left.equalTo(lastAttribute);
        }];
        [_bpViews addObject:bpView];
        lastAttribute = bpView.mas_right;
    }
    
    return containerView;
}

- (void)tapToInput
{
    [self.pwdTextField becomeFirstResponder];
}

#pragma mark - delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    PADLog(@"%lu,%lu,%@,%@",(unsigned long)range.location,(unsigned long)range.length,string,textField.text);
    
    if (range.location >= _pwdLength) {
        return NO;
    }
    [(YZTBlackPointView *)_bpViews[range.location] hideBlackPoint:(string.length==0)];
    return YES;
}

- (void)numberPad:(APNumberPad *)numberPad functionButtonAction:(UIButton *)functionButton textInput:(UIResponder<UITextInput> *)textInput
{
    PADLog(@"APNumberPad - functionButtonAction");
}

- (BOOL)numberPad:(APNumberPad *)numberPad oKButtonAction:(UIButton *)oKButton textInput:(UIResponder<UITextInput> *)textInput
{
    PADLog(@"APNumberPad - oKButtonAction");
    if (_pwdTextField.text.length == _pwdLength) {
        [_alertView externalButtonAtion];
        return YES;
    }
    return NO;
}

@end


@implementation YZTBlackPointView

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.layer setMasksToBounds:YES];
        [self.layer setBorderWidth:0.25];
        [self.layer setBorderColor:RGB(204, 204, 204).CGColor];
        [self clipsToBounds];
        
        self.blackPointView = [[UIView alloc] init];
        [self addSubview:self.blackPointView];
        [self.blackPointView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(BalckPoinWidth, BalckPoinWidth));
        }];
        self.blackPointView.backgroundColor = [UIColor blackColor];
        [self.blackPointView.layer setMasksToBounds:YES];
        [self.blackPointView.layer setCornerRadius:BalckPoinWidth/2];
        [self.blackPointView clipsToBounds];
        [self hideBlackPoint:YES];
    }
    return self;
}

- (void)hideBlackPoint:(BOOL)isHide
{
    [self.blackPointView setHidden:isHide];
}

@end


