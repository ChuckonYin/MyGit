//
//  CYParabolaView.h
//  CYParabolaView
//
//  Created by ChuckonYin on 15/10/19.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CYParabolaViewDelegate <NSObject>

-(void)CYParabolaViewAnimationStop;

@end


typedef void(^endBlock)();

@interface CYParabolaView : UIView
{
    CALayer *_layer;
}
@property (nonatomic, assign) CGFloat interval;

@property (nonatomic, strong) UIImage *moveImg;

@property (nonatomic, assign) CGPoint startP;

@property (nonatomic, assign) CGPoint stopP;

@property (nonatomic, assign) CGFloat minScale;

@property (nonatomic, copy) endBlock endblock;
//贝塞尔 控制点
@property (nonatomic, assign) CGPoint controlP;

@property (nonatomic, strong, readonly) UIBezierPath *path;


@property (nonatomic, assign) id <CYParabolaViewDelegate> delegate;

-(id)initWithSuperView:(UIView*)superView delegate:(id<CYParabolaViewDelegate>)delegate;

- (void)startMove:(UIImage*)img startCenter:(CGPoint)startP stopCenter:(CGPoint)stopP
          interval:(CGFloat)interval minScale:(CGFloat)minScale callback:(endBlock)endblock;
@end









