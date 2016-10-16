//
//  ViewController.m
//  20160129二维码扫描
//
//  Created by ChuckonYin on 16/1/29.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "CYCodeScanView.h"

@interface ViewController ()<CYCodeScanViewDelegate>

@property (nonatomic, strong) CYCodeScanView *scanView;

@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
     _scanView = [[CYCodeScanView alloc] initWithFrame:self.view.bounds andScanRect:CGRectMake(0.15, 0.3, 0.7, 0.4)];
    [self.view addSubview:_scanView];
    
    [_scanView startReading];
    
    _scanView.delegate = self;
}

- (void)cy_codeScanViewResult:(AVMetadataMachineReadableCodeObject *)metadataObj{
    [_scanView stopReading];
    NSLog(@"");
}


@end



















