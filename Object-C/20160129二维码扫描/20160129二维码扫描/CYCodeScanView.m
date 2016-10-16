//
//  CYCodeScanView.m
//  20160129二维码扫描
//
//  Created by ChuckonYin on 16/1/29.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "CYCodeScanView.h"
@class CYRightAngle;
@interface CYCodeScanView ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, assign) BOOL isReading;

@property (nonatomic, strong) AVCaptureSession *captureSession;

@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@property (nonatomic, assign) BOOL qrcodeFlag;

@property (nonatomic, assign, readonly) CGRect reallyScanFrame;

@end

@implementation CYCodeScanView

- (instancetype)initWithFrame:(CGRect)frame andScanRect:(CGRect)centerRect{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.centerRect = centerRect;
        
        _surfaceView = [[CYCodeScanSurfaceView alloc] initWithFrame:self.bounds andScanFrame:self.reallyScanFrame];
        [self addSubview:_surfaceView];
        [_surfaceView startRoll];
    }
    return self;
}


- (BOOL)startReading {
    _isReading = YES;
    NSError *error;
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if  (!input) {
        NSLog(@ "%@" , [error localizedDescription]);
        return  NO;
    }
    
    _captureSession = [[AVCaptureSession alloc] init];
    // Set the input device on the capture session.
    [_captureSession setSessionPreset:AVCaptureSessionPresetHigh];
    [_captureSession addInput:input];
    
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:captureMetadataOutput];
    
    
    // Create a new serial dispatch queue.
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create( "myQueue" , NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObjects:AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode, AVMetadataObjectTypeQRCode, nil]];
    captureMetadataOutput.rectOfInterest = self.centerRect;
//    if  (self.qrcodeFlag)
//        [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
//    else
//        [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObjects:AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode, nil]];
    
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:self.bounds];
    [self.layer insertSublayer:_videoPreviewLayer atIndex:0];
    
    [_captureSession startRunning];
    
    return  YES;
}

-(void)stopReading{
    [_captureSession stopRunning];
    _captureSession = nil;
    [_videoPreviewLayer removeFromSuperlayer];
    [_surfaceView stopRoll];
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects
      fromConnection:(AVCaptureConnection *)connection
{
    if  (!_isReading){
        return ;
    }
    else{
        _isReading = NO;
    }
    if  (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@", metadataObj);
            if (_result) {
                _result(metadataObj);
            }
            if (_delegate && [_delegate respondsToSelector:@selector(cy_codeScanViewResult:)]) {
                [_delegate cy_codeScanViewResult:metadataObj];
            }
        });
    }
}

- (CGRect)reallyScanFrame{
    return CGRectMake(_centerRect.origin.x*self.frame.size.width, _centerRect.origin.y*self.frame.size.height, _centerRect.size.width*self.frame.size.width, _centerRect.size.height*self.frame.size.height);
}

- (CGRect)centerRect{
    return CGRectMake(_centerRect.origin.y, _centerRect.origin.x, _centerRect.size.height, _centerRect.size.width);
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
}

@end

NSInteger const lineCount = 25;

@interface CYCodeScanSurfaceView ()
//边框阴影
@property (nonatomic, strong) UIBezierPath *outPath;
//滚动动画
@property (nonatomic, strong) UIBezierPath *movePath;

@property (nonatomic, strong) NSTimer *timer;
//定时器标记0-100
@property (nonatomic, assign) NSInteger timerFlag;

@end

@implementation CYCodeScanSurfaceView

- (void)startRoll{
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:0.05 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        [_timer setFireDate:[NSDate date]];
    }
}

- (void)stopRoll{
    [_timer setFireDate:[NSDate distantFuture]];
}

- (void)timerAction{
    _timerFlag = _timerFlag == lineCount+1 ? 0 : _timerFlag + 1;
    [self setNeedsDisplay];
}

- (instancetype)initWithFrame:(CGRect)frame andScanFrame:(CGRect)scanFrame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _scanFrame = scanFrame;
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews{
    CYRightAngle *angle0 = [[CYRightAngle alloc] initWithFrame:CGRectMake(_scanFrame.origin.x, _scanFrame.origin.y, 25, 25)];
    [self addSubview:angle0];
    
    CYRightAngle *angle1 = [[CYRightAngle alloc] initWithFrame:CGRectMake(_scanFrame.origin.x+_scanFrame.size.width-25, _scanFrame.origin.y, 25, 25)];
    [self addSubview:angle1];
    angle1.transform = CGAffineTransformMakeRotation(M_PI/2);
    
    CYRightAngle *angle2 = [[CYRightAngle alloc] initWithFrame:CGRectMake(_scanFrame.origin.x+_scanFrame.size.width-25, _scanFrame.origin.y+_scanFrame.size.height-25, 25, 25)];
    [self addSubview:angle2];
    angle2.transform = CGAffineTransformMakeRotation(M_PI);

    CYRightAngle *angle3 = [[CYRightAngle alloc] initWithFrame:CGRectMake(_scanFrame.origin.x, _scanFrame.origin.y+_scanFrame.size.height-25, 25, 25)];
    [self addSubview:angle3];
    angle3.transform = CGAffineTransformMakeRotation(M_PI*3/2);

    
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!_outPath) {
        _outPath = [UIBezierPath bezierPath];
        //外围
        [_outPath moveToPoint:CGPointMake(0, 0)];
        [_outPath addLineToPoint:CGPointMake(0, self.frame.size.height)];
        [_outPath addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
        [_outPath addLineToPoint:CGPointMake(self.frame.size.width, 0)];
        [_outPath addLineToPoint:CGPointMake(0, 0)];
        //内围
        [_outPath addLineToPoint:CGPointMake(_scanFrame.origin.x, _scanFrame.origin.y)];
        [_outPath addLineToPoint:CGPointMake(_scanFrame.origin.x + _scanFrame.size.width, _scanFrame.origin.y)];
        [_outPath addLineToPoint:CGPointMake(_scanFrame.origin.x + _scanFrame.size.width, _scanFrame.origin.y + _scanFrame.size.height)];
        [_outPath addLineToPoint:CGPointMake(_scanFrame.origin.x, _scanFrame.origin.y + _scanFrame.size.height)];
        [_outPath addLineToPoint:CGPointMake(_scanFrame.origin.x, _scanFrame.origin.y)];
        
        [_outPath addLineToPoint:CGPointMake(0, 0)];
    }
    [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3] setFill];
    [_outPath fill];
    
    //画横线
    UIBezierPath *planeLinePath = [UIBezierPath bezierPath];
    for (int i=0; i<_timerFlag; i++) {
        [planeLinePath moveToPoint:CGPointMake(_scanFrame.origin.x, _scanFrame.origin.y+i*_scanFrame.size.height/lineCount)];
        [planeLinePath addLineToPoint:CGPointMake(_scanFrame.origin.x+_scanFrame.size.width,_scanFrame.origin.y+i*_scanFrame.size.height/lineCount)];
    }
    [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
//    [[UIColor colorWithWhite:1.0 alpha:0.5] setStroke];
    [planeLinePath stroke];
    //画竖线
    UIBezierPath *verticalLinePath = [UIBezierPath bezierPath];
    for (int i=0; i<lineCount; i++) {
        [verticalLinePath moveToPoint:CGPointMake(_scanFrame.origin.x+i*_scanFrame.size.width/lineCount, _scanFrame.origin.y)];
        [verticalLinePath addLineToPoint:CGPointMake(_scanFrame.origin.x+i*_scanFrame.size.width/lineCount, _scanFrame.origin.y+(_timerFlag-1>=0?_timerFlag-1:0)*_scanFrame.size.height/lineCount)];
    }
    [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
//    [[UIColor colorWithWhite:1.0 alpha:0.5] setStroke];
    [verticalLinePath stroke];
}

@end

@implementation CYRightAngle

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.mWidth = frame.size.width;
        self.mHeight = frame.size.height;
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(2, 2)];
    [path addLineToPoint:CGPointMake(_mWidth-2, 2)];
    [path addLineToPoint:CGPointMake(_mWidth-2, 4)];
    [path addLineToPoint:CGPointMake(4, 4)];
    [path addLineToPoint:CGPointMake(4, _mHeight-2)];
    [path addLineToPoint:CGPointMake(2, _mHeight-2)];
    [path addLineToPoint:CGPointMake(2, 2)];
    [[UIColor redColor] setFill];
    [path fill];
    
}

@end

