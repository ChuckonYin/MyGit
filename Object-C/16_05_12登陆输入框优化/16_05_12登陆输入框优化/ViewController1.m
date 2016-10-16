//
//  ViewController1.m
//  16_05_12登陆输入框优化
//
//  Created by ChuckonYin on 16/5/13.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "ViewController1.h"
#import "Masonry.h"

@interface ViewController1 ()

@property (nonatomic, strong) UIButton *btn;

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
        make.top.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    NSLog(@"%@", self.view.constraints);
}

- (UIButton *)btn{
    if (!_btn) {
        _btn = [[UIButton alloc] init];
    }
    return _btn;
}

@end
