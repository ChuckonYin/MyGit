//
//  ViewControllerPresenter.m
//  MVP
//
//  Created by ChuckonYin on 15/12/23.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewControllerPresenter.h"

@implementation ViewControllerPresenter

//-(void)setModel:(ViewControllerModel *)model
//{
//    _model = model;
//    [self reloadData];
//}
//- (void)reloadData
//{
//    
////    NSAssert(NO, @"This is an abstract method and should be overridden");
//}

-(void)update
{
    if (_delegate && [_delegate respondsToSelector:@selector(ViewControllerPresenterUpdate)]) {
        [_delegate ViewControllerPresenterUpdate];
    }
}
-(NSString *)getUpdate:(NSString *)str
{
    return [NSString stringWithFormat:@"%li", [str integerValue] +1 ];
}

@end
