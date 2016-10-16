//
//  VCCollectionViewCell.m
//  ailvgo
//
//  Created by liuguopan on 14-11-28.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import "VCCollectionViewCell.h"

@implementation VCCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        [self createImageView:frame];
//        [self createVideoButton:frame];
    }
    return self;
}

- (void)createImageView:(CGRect)frame
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
//    UIImage * i = [UIImage imageNamed:@"trip_holder.png"];
//    [imageView setImage:i];
//    Log(@"\n\nclass %@\nmethod %@\nimageView %@\nimage %@",
//                                                        NSStringFromClass([self class]),
//                                                        NSStringFromSelector(_cmd),
//                                                        imageView,
//                                                        i)
//    [imageView setImage:[UIImage imageNamed:@"trip_holder.png"]];
    imageView.userInteractionEnabled = YES;
    [self addSubview:imageView];
    self.imageView = imageView;
}

//  播放音频
- (void)createVideoButton:(CGRect)frame
{
    UIButton *videoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    videoButton.frame = CGRectMake(frame.size.width / 2 - 30.0f,
                                   frame.size.height / 2 - 30.0f,
                                   60.0f,
                                   60.0f);
    [videoButton setImage:[UIImage imageNamed:@"trip_video.png"]
                 forState:UIControlStateNormal];
    [self addSubview:videoButton];
    self.videoButton = videoButton;
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
