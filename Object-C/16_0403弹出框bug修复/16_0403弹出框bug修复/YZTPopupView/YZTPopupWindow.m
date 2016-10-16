//
//  YZTPopupWindow.m
//  YZTPopupView
//
//  Created by Ralph Li on 9/6/15.
//  Copyright © 2015 LJC. All rights reserved.
//

#import "YZTPopupWindow.h"
#import "MMPopupCategory.h"
#import "MMPopupDefine.h"
#import "YZTPopupView.h"

@interface YZTPopupWindow()

@property (nonatomic, assign) CGRect keyboardRect;

@end

@implementation YZTPopupWindow

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if ( self )
    {
        self.windowLevel = UIWindowLevelStatusBar + 1;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyKeyboardChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap:)];
        gesture.cancelsTouchesInView = NO;
        [self addGestureRecognizer:gesture];
    }
    return self;
}

+ (YZTPopupWindow *)sharedWindow
{
    static YZTPopupWindow *window;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        window = [[YZTPopupWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        
    });
    
    return window;
}

- (void)cacheWindow
{
    [self makeKeyAndVisible];
    [[[UIApplication sharedApplication].delegate window] makeKeyWindow];
    
    self.hidden = YES;
}

- (void)actionTap:(UITapGestureRecognizer*)gesture
{
    if ( self.touchWildToHide && !self.mm_dimBackgroundAnimating )
    {
        for ( UIView *v in self.mm_dimBackgroundView.subviews )
        {
            if ( [v isKindOfClass:[YZTPopupView class]] )
            {
                YZTPopupView *popupView = (YZTPopupView*)v;
                [popupView cancle];
            }
        }
    }
}

- (void)notifyKeyboardChangeFrame:(NSNotification *)n
{
    NSValue *keyboardBoundsValue = [[n userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    self.keyboardRect = [keyboardBoundsValue CGRectValue];
}

@end
