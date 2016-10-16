

//
//  YZTPopupView.m
//  YZTPopupView
//
//  Created by Ralph Li on 9/6/15.
//  Copyright © 2015 LJC. All rights reserved.
//

#import "YZTPopupView.h"
#import "YZTPopupWindow.h"
#import "MMPopupDefine.h"
#import "MMPopupCategory.h"

@implementation YZTPopupView

- (instancetype)init
{
    self = [super init];
    
    if ( self )
    {
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if ( self )
    {
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    self.type = MMPopupTypeAlert;
    self.animationDuration = 0.3f;
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    tapGR.cancelsTouchesInView = NO;
    [self addGestureRecognizer:tapGR];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardAction:) name: UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hidehide) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyBoardAction:(NSNotification *)noti{
    self.keyBoardDuration = [[noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect keyboardBounds;
    [[noti.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    self.keyBoardHeight = keyboardBounds.size.height;
   self.keyBoardCurve= [noti.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey]; // 添加移动动画，使视图跟随键盘移动
}

- (void)tapAction:(UITapGestureRecognizer *)gr
{
    //[self endEditing:YES];
//    [self hideKeyBoard];
    
}

- (void)hideKeyBoard
{
    for (UIWindow* window in [UIApplication sharedApplication].windows)
    {
        for (UIView* view in window.subviews)
        {
            [self dismissAllKeyBoardInView:view];
        }
    }
}

- (BOOL)dismissAllKeyBoardInView:(UIView *)view
{
    if([view isFirstResponder])
    {
        [view resignFirstResponder];
        return YES;
    }
    for(UIView *subView in view.subviews)
    {
        if([self dismissAllKeyBoardInView:subView])
        {
            return YES;
        }
    }
    return NO;
}

- (BOOL)visible
{
    if ( self.attachedView )
    {
        return !self.attachedView.mm_dimBackgroundView.hidden;
    }
    
    return NO;
}

- (void)setType:(MMPopupType)type
{
    _type = type;
    
    switch (type)
    {
        case MMPopupTypeAlert:
        {
            self.showAnimation = [self alertShowAnimation];
            self.hideAnimation = [self alertHideAnimation];
//            self.showAnimation = [self sheetShowAnimation];
//            self.hideAnimation = [self sheetHideAnimation];
            break;
        }
        case MMPopupTypeSheet:
        {
            self.showAnimation = [self sheetShowAnimation];
            self.hideAnimation = [self sheetHideAnimation];
            break;
        }
        case MMPopupTypeCustom:
        {
            self.showAnimation = [self customShowAnimation];
            self.hideAnimation = [self customHideAnimation];
            break;
        }
            
        default:
            break;
    }
}

- (void)setAnimationDuration:(NSTimeInterval)animationDuration
{
    _animationDuration = animationDuration;
    
    self.attachedView.mm_dimAnimationDuration = animationDuration;
}

- (void)show
{
    [self showWithBlock:nil];
}

- (void)showWithBlock:(MMPopupBlock)block
{
    // 方便在任何地方调用来隐藏所展示的PopView
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideImmediate) name:YZTPopViewToHideNotification object:nil];
    
    if ( block )
    {
        self.showCompletionBlock = block;
    }
    
    if ( !self.attachedView )
    {
        self.attachedView = [YZTPopupWindow sharedWindow];
    }
    [self.attachedView mm_showDimBackground];
    
    NSAssert(self.showAnimation, @"show animation must be there");
    
    self.showAnimation(self);
    
    if ( self.withKeyboard )
    {
        [self showKeyboard];
    }
}

- (void)cancle
{
    [self hide];
}

- (void)hideImmediate
{
    self.isAllHide = YES;
    [self hideWithBlock:nil];
}

- (void)hide
{
    [self hideWithBlock:nil];
}

- (void)hideWithBlock:(MMPopupBlock)block
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:YZTPopViewToHideNotification object:nil];
    
    if ( block )
    {
        self.hideCompletionBlock = block;
    }
    
    if ( !self.attachedView )
    {
        self.attachedView = [YZTPopupWindow sharedWindow];
    }
    [self.attachedView mm_hideDimBackground:!self.isAllHide];
    self.isAllHide = NO;
    
    if ( self.withKeyboard )
    {
        [self hideKeyboard];
    }
    
    NSAssert(self.showAnimation, @"hide animation must be there");
    
    self.hideAnimation(self);
}

- (MMPopupBlock)alertShowAnimation
{
    MMWeakify(self);
    MMPopupBlock block = ^(YZTPopupView *popupView){
        MMStrongify(self);
        
        [self.attachedView.mm_dimBackgroundView addSubview:self];
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.center.equalTo(self.attachedView).centerOffset(CGPointMake(0, self.withKeyboard?-216/2:0));
            make.center.equalTo(self.attachedView).centerOffset(CGPointMake(0, self.withKeyboard?-216/2:0));
        }];
        [self layoutIfNeeded];
        
        self.layer.transform = CATransform3DMakeScale(1.2f, 1.2f, 1.0f);
        self.alpha = 0.0f;
        
        [UIView animateWithDuration:self.animationDuration
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             
                             self.layer.transform = CATransform3DIdentity;
                             self.alpha = 1.0f;
                             
                         }
                         completion:^(BOOL finished) {
                             [self showCompletionHandler];
                             if ( self.showCompletionBlock )
                             {
                                 self.showCompletionBlock(self);
                             }
                             
                         }];
    };
    
    return block;
}

- (MMPopupBlock)alertHideAnimation
{
    MMWeakify(self);
    MMPopupBlock block = ^(YZTPopupView *popupView){
        MMStrongify(self);
        
        [UIView animateWithDuration:self.animationDuration
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             
                             self.alpha = 0.0f;
                             
                         }
                         completion:^(BOOL finished) {
                             
                             [self removeFromSuperview];
                             
                             if ( self.hideCompletionBlock )
                             {
                                 self.hideCompletionBlock(self);
                             }
                             
                         }];
    };
    
    return block;
}

- (MMPopupBlock)sheetShowAnimation
{
    MMWeakify(self);
    MMPopupBlock block = ^(YZTPopupView *popupView){
        MMStrongify(self);
        
        [self.attachedView.mm_dimBackgroundView addSubview:self];
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.attachedView);
            make.bottom.equalTo(self.attachedView.mas_bottom).offset(self.attachedView.frame.size.height);
        }];
        [self layoutIfNeeded];
        
        if (self.withKeyboard) {
            self.animationDuration = self.keyBoardDuration;
        }
        else{
            self.animationDuration = 0.3;
        }
        [self layoutIfNeeded];
        if(self.withKeyboard){
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.attachedView.mas_bottom).offset(0);
            }];
            [UIView animateWithDuration:self.animationDuration animations:^{
                [UIView setAnimationBeginsFromCurrentState:YES];
                [UIView setAnimationCurve:[self.keyBoardCurve intValue]];
                self.transform = CGAffineTransformMakeTranslation(0, self.withKeyboard?-self.keyBoardHeight:0);
            }];
        }
        else{
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.attachedView.mas_bottom).offset(1);
            }];
            [UIView animateWithDuration:self.animationDuration
                                  delay:0
                                options:UIViewAnimationOptionBeginFromCurrentState
                             animations:^{
                [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.attachedView.mas_bottom).offset(-10);
                                               }];
               [self layoutIfNeeded];

           }
                           completion:^(BOOL finished) {
                               [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:20 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                                   [self mas_updateConstraints:^(MASConstraintMaker *make) {
                                       make.bottom.equalTo(self.attachedView.mas_bottom).offset(0);
                                   }];
                                   [self layoutIfNeeded];
                                   
                               } completion:^(BOOL finished) {
                                   [self showCompletionHandler];
                                   if ( self.showCompletionBlock )
                                   {
                                       self.showCompletionBlock(self);
                                   }
                               }];
          }];
//            [UIView animateWithDuration:self.animationDuration animations:^{
//                [self mas_updateConstraints:^(MASConstraintMaker *make) {
//                    make.bottom.equalTo(self.attachedView.mas_bottom).offset(0);
//                }];
//            } completion:^(BOOL finished) {
//               
//            }];
        }
    };
    return block;
}

- (MMPopupBlock)sheetHideAnimation
{
    MMWeakify(self);
    MMPopupBlock block = ^(YZTPopupView *popupView){
        MMStrongify(self);
        if (self.withKeyboard) {

            [UIView animateWithDuration:self.keyBoardDuration animations:^{
                [UIView setAnimationBeginsFromCurrentState:YES];
                [UIView setAnimationCurve:[self.keyBoardCurve intValue]];
                self.transform = CGAffineTransformMakeTranslation(0,self.frame.size.height);
            }completion:^(BOOL finished) {
                [self mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(self.attachedView.mas_bottom).offset(0);
                }];
            }];
        }
        else{
            [UIView animateWithDuration:self.animationDuration
                                  delay:0
                                options:UIViewAnimationOptionBeginFromCurrentState
                             animations:^{
                                 
                                 [self mas_updateConstraints:^(MASConstraintMaker *make) {
                                     make.bottom.equalTo(self.attachedView.mas_bottom).offset(self.attachedView.frame.size.height);
                                 }];
                                 
                                 [self layoutIfNeeded];
                                 
                             }
                             completion:^(BOOL finished) {
                                 
                                 [self removeFromSuperview];
                                 
                                 if ( self.hideCompletionBlock )
                                 {
                                     self.hideCompletionBlock(self);
                                 }
                                 
                             }];
            
        }
        
    };
    
    return block;
}

- (MMPopupBlock)customShowAnimation
{
    MMWeakify(self);
    MMPopupBlock block = ^(YZTPopupView *popupView){
        MMStrongify(self);
        
        [self.attachedView.mm_dimBackgroundView addSubview:self];
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.attachedView).centerOffset(CGPointMake(0, -self.attachedView.bounds.size.height));
        }];
        [self layoutIfNeeded];
        
        [UIView animateWithDuration:self.animationDuration
                              delay:0
             usingSpringWithDamping:0.8
              initialSpringVelocity:1.5
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             
                             [self mas_updateConstraints:^(MASConstraintMaker *make) {
                                 make.center.equalTo(self.attachedView).centerOffset(CGPointMake(0, self.withKeyboard?-216/2:0));
                             }];
                             
                             [self layoutIfNeeded];
                             
                         } completion:^(BOOL finished) {
                             [self showCompletionHandler];
                             if ( self.showCompletionBlock )
                             {
                                 self.showCompletionBlock(self);
                             }
                             
                         }];
    };
    
    return block;
}

- (MMPopupBlock)customHideAnimation
{
    MMWeakify(self);
    MMPopupBlock block = ^(YZTPopupView *popupView){
        MMStrongify(self);
        
        [UIView animateWithDuration:0.3
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             
                             [self mas_updateConstraints:^(MASConstraintMaker *make) {
                                 make.center.equalTo(self.attachedView).centerOffset(CGPointMake(0, self.attachedView.bounds.size.height));
                             }];
                             
                             [self layoutIfNeeded];
                             
                         } completion:^(BOOL finished) {
                             
                             [self removeFromSuperview];
                             
                         }];
    };
    
    return block;
}

- (void)showKeyboard
{
    
}

- (void)hideKeyboard
{
    
}

- (void) showCompletionHandler
{
    
}

@end
