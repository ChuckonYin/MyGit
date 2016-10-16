//
//  CYLimitTextField.m
//  CYLimitTextField
//
//  Created by ChuckonYin on 16/4/12.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "CYLimitTextField.h"
#import <objc/runtime.h>

@interface CYLimitTextField()<UITextFieldDelegate>

@property (nonatomic, copy) NSString *limitType;

//@property (nonatomic, assign) id cyLimitTextFieldDelegate;

@end

@implementation CYLimitTextField

@dynamic delegate;

- (instancetype)initWithFrame:(CGRect)frame limit:(NSString *)limitType preferDirection:(BOOL)rightToleft{
    if (self = [super initWithFrame:frame]) {
        [super setDelegate:self];
        self.limitType = limitType;
    }
    return self;
}

//- (void)setDelegate:(id)delegate{
//    self.cyLimitTextFieldDelegate = delegate;
//}
//
//- (id)delegate{
//    return self.cyLimitTextFieldDelegate;
//}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [self.delegate textFieldShouldBeginEditing:textField];
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        return [self.delegate textFieldDidBeginEditing:textField];
    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [self.delegate textFieldShouldEndEditing:textField];
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        return [self.delegate textFieldDidEndEditing:textField];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(textField: shouldChangeCharactersInRange: replacementString:)]) {
        return [self.delegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    //删除
    if ([string isEqualToString:@""]) {
        return YES;
    }
    NSMutableString *muText = self.text.mutableCopy;
    [muText insertString:string atIndex:range.location];
    [self resetFormate:muText];
    return NO;
}

- (void)resetFormate:(NSString *)string{
    NSMutableString *newString = self.limitType.mutableCopy;
    for (int i=0; i<newString.length; i++) {
        char c = [newString characterAtIndex:i];
        for (int j=0; j<self.limitType.length; j++) {
            if (c == [self.limitType characterAtIndex:j]) {
                [newString replaceCharactersInRange:NSMakeRange(i, 1) withString:@""];
            }
        }
    }
    for (int i=0; i<string.length; i++) {
        char c = [string characterAtIndex:i];
        for (int j=0; j<self.limitType.length; j++) {
            if ([newString characterAtIndex:j] == '#') {
                [newString replaceCharactersInRange:NSMakeRange(j, 1) withString:[NSString stringWithFormat:@"%c", c]];
                break;
            }
        }
    }
    self.text = newString;
//    [newString stringByReplacingOccurrencesOfString:@"#" withString:@""];
}


- (BOOL)textFieldShouldClear:(UITextField *)textField{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [self.delegate textFieldShouldClear:textField];
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    //处理事件
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [self.delegate textFieldShouldReturn:textField];
    }
    return YES;
}


@end
