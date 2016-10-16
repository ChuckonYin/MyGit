//
//  CYCodeScanView.h
//  20160129二维码扫描
//
//  Created by ChuckonYin on 16/1/29.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef void(^ScanResult)(AVMetadataMachineReadableCodeObject*);

@protocol CYCodeScanViewDelegate <NSObject>

- (void)cy_codeScanViewResult:(AVMetadataMachineReadableCodeObject*)metadataObj;

@end
@class CYCodeScanSurfaceView;
@interface CYCodeScanView : UIView

@property (nonatomic, strong) CYCodeScanSurfaceView *surfaceView;

@property (nonatomic, copy) ScanResult result;

@property (nonatomic, assign, readwrite) CGRect centerRect;

@property (nonatomic, weak) id<CYCodeScanViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame andScanRect:(CGRect)centerRect;

- (BOOL)startReading;

- (void)stopReading;

@end

@interface CYCodeScanSurfaceView : UIView

@property (nonatomic, strong) UIColor *borderColor;

@property (nonatomic, strong) UIColor *rightaAngleColor;

@property (nonatomic, assign) CGRect scanFrame;

- (instancetype)initWithFrame:(CGRect)frame andScanFrame:(CGRect)scanFrame;

- (void)startRoll;

- (void)stopRoll;

@end

@interface CYRightAngle : UIView
@property (nonatomic, assign) CGFloat mWidth, mHeight;
@end


