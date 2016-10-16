//
//  VCView.m
//  Ailv_UI_0902
//
//  Created by liuguopan on 14-10-10.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import "VCView.h"

@implementation VCView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.enable = NO;
    }
    return self;
}

- (void)setEnable:(BOOL)enable
{
    _enable = enable;
    if (_enable) {
        //  添加手势
        UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction:)];
        [self addGestureRecognizer:tgr];
    }
}

- (void)clickAction:(UITapGestureRecognizer *)tgr
{
    [self.vcViewDelegate vcViewPress:self];
    NSLog(@"VCImageview  %ld press", (long)tgr.view.tag);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
