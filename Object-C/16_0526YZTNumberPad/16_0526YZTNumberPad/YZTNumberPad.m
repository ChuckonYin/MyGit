//
//  YZTNumberPad.m
//  16_0526YZTNumberPad
//
//  Created by ChuckonYin on 16/5/26.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//


#import "YZTNumberPad.h"

const CGFloat np_numberBtnHeight = 50.0f;
#define np_numberBtnWidth (kScreenWidth/4.0f)

@interface YZTNumberPad()
//UI
@property (nonatomic, strong) NSMutableArray *normalButtuns;
@property (nonatomic, strong) UIButton *clearBtn;
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, strong) UIImage *number_hl_image;
@property (nonatomic, strong) UIImage *confirm_normal_image;
@property (nonatomic, strong) UIImage *confirm_hl_image;
//DATA
@property (nonatomic, weak) UITextField *textField;

@end

@implementation YZTNumberPad

- (instancetype)initWithTextField:(UITextField *)textField{
    return [self initWithFrame:CGRectZero textField:textField];
}

- (instancetype)initWithFrame:(CGRect)frame textField:(UITextField *)textField{
    if (self = [super initWithFrame:CGRectMake(0, 300, kScreenWidth, np_numberBtnHeight*4.0)]) {
        self.backgroundColor = [UIColor whiteColor];
        self.textField = textField;
        [self yzt_initNormalBtn];
        [self addSubview:self.clearBtn];
        [self addSubview:self.confirmBtn];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //画横线
    for (int i=0; i<4; i++) {
        CGContextMoveToPoint(ctx, 0, 1.0f+np_numberBtnHeight*i);
        CGFloat rightX = kScreenWidth-np_numberBtnWidth;
        if (i==0) {
            rightX = kScreenWidth;
        }
        CGContextAddLineToPoint(ctx, rightX, 1+np_numberBtnHeight*i);
    }
    //画竖线
    for (int j=1; j<4; j++) {
        CGContextMoveToPoint(ctx, np_numberBtnWidth*j, 1.0f);
        CGFloat bottomY = np_numberBtnHeight*4.0;
        if (j==3) {
            bottomY = np_numberBtnHeight*2.0;
        }
        CGContextAddLineToPoint(ctx, np_numberBtnWidth*j, bottomY);
    }
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1].CGColor);
    CGContextSetLineWidth(ctx, 0.5);
    CGContextStrokePath(ctx);
}

#pragma mark - YZTNumberPadDelegate

- (void)yzt_numberClickOrHideKeyBoardAction:(UIButton *)btn{
    NSLog(@"%@", self.textField.text);
    NSInteger tag = btn.tag-1990;
    //隐藏键盘
    if (tag==11) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(yztNumberPadHide:)]) {
            [self.delegate yztNumberPadHide:_textField];
            [self.textField resignFirstResponder];
        }
        else{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.textField resignFirstResponder];
            });
            
        }
        return;
    }
    //控制小数点的数量
    if (tag==9) {
        if (self.textField.text.length==0 || [self.textField.text containsString:@"."]) return;
    }
    NSMutableString *muString = self.textField.text.mutableCopy;
    [muString appendString:btn.titleLabel.text];
    self.textField.text = muString;
}

- (void)yzt_clearAction{
    //清除
    if (self.delegate && [self.delegate respondsToSelector:@selector(yztNumberPadClear:)]) {
        [self.delegate yztNumberPadClear:_textField];
    }
    else{
        NSMutableString *muString = self.textField.text.mutableCopy;
        if (muString.length>0) {
            [muString deleteCharactersInRange:NSMakeRange(_textField.text.length-1, 1)];
            self.textField.text = muString;
        }
    }
}


#pragma mark - private

- (void)yzt_initNormalBtn{
    self.normalButtuns = [NSMutableArray arrayWithCapacity:12];
    for (int i=0; i<12; i++) {
        UIButton *normalBtn = [[UIButton alloc] initWithFrame:CGRectMake((i%3)*np_numberBtnWidth, 1.0+(i/3)*np_numberBtnHeight, np_numberBtnWidth, np_numberBtnHeight)];
        [normalBtn setBackgroundImage:self.number_hl_image forState:UIControlStateHighlighted];
        normalBtn.tag = 1990+i;
        [self addSubview:normalBtn];
        [normalBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [normalBtn addTarget:self action:@selector(yzt_numberClickOrHideKeyBoardAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.normalButtuns addObject:normalBtn];
        if (i<9) {
            [normalBtn setTitle:[NSString stringWithFormat:@"%i", i+1] forState:UIControlStateNormal];
        }
        else if (i==9){
            [normalBtn setTitle:@"." forState:UIControlStateNormal];
        }
        else if(i==10){
            [normalBtn setTitle:@"0" forState:UIControlStateNormal];
        }
        else if(i==11){
            [normalBtn setImage:[UIImage imageNamed:@"Keyboard_Hide"] forState:UIControlStateNormal];
        }
    }
}

- (UIImage *)yzt_drawImageWithColor:(UIColor *)color frame:(CGRect)aFrame{
    aFrame = CGRectMake(0, 0, aFrame.size.width, aFrame.size.height);
    UIGraphicsBeginImageContext(aFrame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, aFrame);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

#pragma mark - get & set

- (UIButton *)clearBtn{
    if (!_clearBtn) {
        _clearBtn = [[UIButton alloc] initWithFrame:CGRectMake(np_numberBtnWidth*3.0, 1.0, np_numberBtnWidth, 2.0*np_numberBtnHeight)];
        [_clearBtn setTitle:@"clear" forState:UIControlStateNormal];
        [_clearBtn setImage:[UIImage imageNamed:@"Keyboard_Backspace"] forState:UIControlStateNormal];
        [_clearBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_clearBtn setBackgroundImage:self.number_hl_image forState:UIControlStateHighlighted];
        [_clearBtn addTarget:self action:@selector(yzt_clearAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearBtn;
}

- (UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(np_numberBtnWidth*3.0, .5+2.0*np_numberBtnHeight, np_numberBtnWidth, 2.0*np_numberBtnHeight)];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setBackgroundImage:self.confirm_normal_image forState:UIControlStateNormal];
        [_confirmBtn setBackgroundImage:self.confirm_hl_image forState:UIControlStateHighlighted];
        
    }
    return _confirmBtn;
}
//背景图片比按钮尺寸大
- (UIImage *)number_hl_image{
    if (!_number_hl_image) {
        _number_hl_image = [self yzt_drawImageWithColor:[UIColor lightGrayColor] frame:CGRectMake(0, 0, 3.0*np_numberBtnWidth, 3.0*np_numberBtnHeight)];
    }
    return _number_hl_image;
}

- (UIImage *)confirm_normal_image{
    if (!_confirm_normal_image) {
        _confirm_normal_image = [self yzt_drawImageWithColor:[UIColor colorWithRed:0.08 green:0.35 blue:0.76 alpha:1.00] frame:CGRectMake(0, 0, 3.0*np_numberBtnWidth, 3.0*np_numberBtnHeight)];
    }
    return _confirm_normal_image;
}

- (UIImage *)confirm_hl_image{
    if (!_confirm_hl_image) {
        _confirm_hl_image = [self yzt_drawImageWithColor:[UIColor colorWithRed:0.07 green:0.29 blue:0.66 alpha:1.00] frame:CGRectMake(0, 0, 3.0*np_numberBtnWidth, 3.0*np_numberBtnHeight)];
    }
    return _confirm_hl_image;
}

@end





