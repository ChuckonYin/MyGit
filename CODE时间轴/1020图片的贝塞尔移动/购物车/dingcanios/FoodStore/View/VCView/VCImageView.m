//
//  VCImageView.m
//  Ailv_UI_0902
//
//  Created by liuguopan on 14-9-30.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import "VCImageView.h"

@implementation VCImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.enable = NO;
        self.videoButtonHidden = YES;
        self.userInteractionEnabled = YES;
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

- (void)setVideoButtonHidden:(BOOL)videoButtonHidden
{
    _videoButtonHidden = videoButtonHidden;
    if (!_videoButtonHidden) {
        UIButton *videoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat w = [[UIScreen mainScreen] bounds].size.width;
        CGFloat h = [[UIScreen mainScreen] bounds].size.height;
        videoButton.frame = CGRectMake(w / 2 - 30, h / 2 - 30, 60, 60);
        videoButton.frame = CGRectMake(130, 300, 60, 60);
        [videoButton addTarget:self action:@selector(videoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:videoButton];
    }

}

- (void)videoButtonClick:(UIButton *)videoBtn
{
    [_vcImageViewDelegate videoImagePress:videoBtn];
}

- (void)clickAction:(UITapGestureRecognizer *)tgr
{
    [self.vcImageViewDelegate vcImageViewPress:self];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
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
