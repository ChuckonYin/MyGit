//
//  ViewController.m
//  MVP
//
//  Created by ChuckonYin on 15/12/23.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<ViewControllerPresenterDelegate>

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) ViewControllerPresenter *presenter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    for (int i= 0; i<10; i++) {
//        NSAssert(i%2==0, @"偶数");
//    }
    
    self.presenter = [[ViewControllerPresenter alloc] init];
    _presenter.delegate = self;
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:_label];
    _label.text = @"0";
    [_label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(normalUpdate)]];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_presenter update];
}
-(void)normalUpdate
{
    _label.text = [_presenter getUpdate:_label.text];
}
-(void)ViewControllerPresenterUpdate
{
    _label.text = [NSString stringWithFormat:@"%li", [_label.text integerValue] + 1 ];
}

@end
