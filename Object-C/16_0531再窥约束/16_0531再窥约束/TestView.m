//
//  TestView.m
//  16_0531再窥约束
//
//  Created by apple on 16/5/31.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "TestView.h"
#import "Masonry.h"

@implementation TestView

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    
}

- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.superview);
    }];
    [self.superview layoutIfNeeded];
    [UIView animateWithDuration:1 animations:^{
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.superview).offset(100);
        }];
        [self.superview layoutIfNeeded];
    }];
}

- (void)addConstraints:(NSArray<__kindof NSLayoutConstraint *> *)constraints{
    [super addConstraints:constraints];
    NSLog(@"addConstraints");
}

- (void)updateConstraints{
    [super updateConstraints];
    NSLog(@"updateConstraints");

}

- (void)removeConstraint:(NSLayoutConstraint *)constraint{
    [super removeConstraint:constraint];
    NSLog(@"removeConstraint");

}


@end










