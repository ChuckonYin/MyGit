//
//  YZTAnimateTextField.m
//  16_05_12登陆输入框优化
//
//  Created by ChuckonYin on 16/5/12.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "YZTAnimateTextField.h"
#import "Masonry.h"

#define YZTAnimateTextFieldEditStateColor [UIColor blueColor].CGColor
#define YZTAnimateTextFieldNormalStateColor [UIColor colorWithRed:0.60 green:0.60 blue:0.60 alpha:1.00].CGColor
const CGFloat YZTAnimateTextFieldPlaceholderToLeft = 10.0f;

@interface YZTAnimateTextField()<UITextFieldDelegate>

//UI
@property (nonatomic, strong) UIView *borderView;
@property (nonatomic, strong) UILabel *placeholderLabel;
@property (nonatomic, strong) UIView *rightView;
//DATA
@property (nonatomic, copy) NSString *normalPlaceholder;
@property (nonatomic, copy) NSString *topPlaceholder;

@property (nonatomic, assign) CGPoint normalCenter;
@property (nonatomic, assign) CGPoint topCenter;
@property (nonatomic, assign) CGSize normalSize;
@property (nonatomic, assign) CGSize topSize;
@end

@implementation YZTAnimateTextField

#pragma mark - lifeCycle

- (instancetype)initWithNormalPlaceholder:(NSString *)normalPlaceholder
                                 delegate:(id<UITextFieldDelegate>)delegate{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        _normalPlaceholder = normalPlaceholder;
        _delegate = delegate;
        //set default
        _normalSize = CGSizeZero;
        _topSize = CGSizeZero;
        _topPlaceholderScale = 0.80f;
        _normalPlaceholderFont = [UIFont systemFontOfSize:16.0f];
        [self normalSize];
        [self topSize];
        [self initUI];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
}

- (void)initUI{
    [self addSubview:self.borderView];
    [self addSubview:self.textField];
    UILabel *l = self.placeholderLabel;
    [self addSubview:l];
    __unsafe_unretained YZTAnimateTextField *weakSelf = self;
    [self.borderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(YZTAnimateTextFieldPlaceholderToLeft);
        make.centerY.equalTo(weakSelf);
        make.size.mas_equalTo(weakSelf.normalSize);
    }];
//    self.placeholderLabel.center = CGPointMake(YZTAnimateTextFieldPlaceholderToLeft+weakSelf.normalSize.width/2.0, CGRectGetMidY(weakSelf.bounds));
    
}


#pragma mark - private

- (void)yzt_startAnimation{
    if (self.textField.text && self.textField.text.length>0) return;
    if ([self yzt_systemVersion]<8.0){
        __unsafe_unretained YZTAnimateTextField *weakSelf = self;
        if (self.placeholderLabel.center.y<1.0) {
            if (_textField.text.length != 0) return;
            {
                [UIView animateWithDuration:0.25 animations:^{
                    weakSelf.placeholderLabel.center = CGPointMake(YZTAnimateTextFieldPlaceholderToLeft+weakSelf.normalSize.width/2.0, CGRectGetMidY(weakSelf.bounds));
                    weakSelf.placeholderLabel.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                } completion:^(BOOL finished) {
                }];
            }
        }
        else{
            [UIView animateWithDuration:0.25 animations:^{
                weakSelf.placeholderLabel.center = CGPointMake(YZTAnimateTextFieldPlaceholderToLeft+weakSelf.topSize.width/2.0, 0);
                weakSelf.placeholderLabel.transform = CGAffineTransformMakeScale(weakSelf.topPlaceholderScale, weakSelf.topPlaceholderScale);
            } completion:^(BOOL finished) {
            }];
        }
    }
    else{
        __unsafe_unretained YZTAnimateTextField *weakSelf = self;
        if (self.placeholderLabel.transform.ty!=0) {
            [UIView animateWithDuration:0.25 animations:^{
                weakSelf.placeholderLabel.transform = CGAffineTransformScale(CGAffineTransformMakeTranslation(0, 0), 1.0f, 1.0f);
            } completion:^(BOOL finished) {
            }];
        }
        else{
            [UIView animateWithDuration:0.25 animations:^{
                weakSelf.placeholderLabel.transform = CGAffineTransformScale(CGAffineTransformMakeTranslation(weakSelf.topSize.width/2.0-weakSelf.normalSize.width/2.0, -CGRectGetHeight(weakSelf.frame)/2.0), weakSelf.topPlaceholderScale, weakSelf.topPlaceholderScale);
            } completion:^(BOOL finished) {
            }];
        }
    }
}

- (void)yzt_clearAction{
    self.textField.text = @"";
}

- (CGFloat)yzt_systemVersion{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

#pragma mark - set & get

- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.delegate = self;
        _textField.rightView = self.rightView;
        _textField.rightViewMode = UITextFieldViewModeWhileEditing;
    }
    return _textField;
}

- (UILabel *)placeholderLabel{
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
        _placeholderLabel.backgroundColor = [UIColor whiteColor];
        _placeholderLabel.font = _normalPlaceholderFont;
        _placeholderLabel.text = _normalPlaceholder;
        _placeholderLabel.textColor = [UIColor grayColor];
        _placeholderLabel.transform = CGAffineTransformMakeScale(1.0, 1.0);
        _placeholderLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _placeholderLabel;
}

- (UIView *)borderView{
    if (!_borderView) {
        _borderView = [[UIView alloc] init];
        _borderView.layer.cornerRadius = 5.0f;
        _borderView.layer.masksToBounds = YES;
        _borderView.layer.borderWidth = 1.0f;
        _borderView.layer.borderColor = YZTAnimateTextFieldNormalStateColor;
    }
    return _borderView;
}

- (CGSize)normalSize{
    if (CGSizeEqualToSize(_normalSize, CGSizeZero)) {
        _normalSize = [_normalPlaceholder sizeWithAttributes:@{NSFontAttributeName:_normalPlaceholderFont}];
        _normalSize = CGSizeMake(_normalSize.width+5, _normalSize.height);
    }
    return _normalSize;
}

- (CGSize)topSize{
    if (CGSizeEqualToSize(_topSize, CGSizeZero)) {
        _topSize = CGSizeMake(self.normalSize.width*self.topPlaceholderScale, self.normalSize.height*self.topPlaceholderScale);
    }
    return _topSize;
}


- (UIView *)rightView{
    if (!_rightView) {
        _rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _rightView.layer.contents = (id)([UIImage imageNamed:@"clear"].CGImage);
        [_rightView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yzt_clearAction)]];
    }
    return _rightView;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.borderView.layer.borderColor = YZTAnimateTextFieldEditStateColor;
    [self yzt_startAnimation];
    if (_delegate && [_delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [_delegate textFieldDidBeginEditing:textField];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.borderView.layer.borderColor = YZTAnimateTextFieldNormalStateColor;
    [self yzt_startAnimation];
    if (_delegate && [_delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [_delegate textFieldDidEndEditing:textField];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (_delegate && [_delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [_delegate textFieldShouldBeginEditing:textField];
    }
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (_delegate && [_delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [_delegate textFieldShouldEndEditing:textField];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (_delegate && [_delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [_delegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    if (_delegate && [_delegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [_delegate textFieldShouldClear:textField];
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (_delegate && [_delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [_delegate textFieldShouldReturn:textField];
    }
    return YES;
}

@end




