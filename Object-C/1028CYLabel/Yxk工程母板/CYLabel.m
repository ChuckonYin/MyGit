//
//  CYLabel.m
//  Yxk工程母板
//
//  Created by ChuckonYin on 15/10/22.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "CYLabel.h"

@implementation CYLabel

-(instancetype)init{
    if (self = [super init]) {
        __unsafe_unretained CYLabel *weakSelf = self;
        _cy_Font = ^CYLabel*(CGFloat f){
            weakSelf.font = [UIFont systemFontOfSize:f];
            return weakSelf;
        };
        _cy_BgColor = ^CYLabel*(UIColor *c){
            weakSelf.backgroundColor = c;
            return weakSelf;
        };
        _cy_TextAligment = ^CYLabel*(NSTextAlignment a){
            weakSelf.textAlignment = a;
            return weakSelf;
        };
        _cy_text = ^CYLabel*(NSString*t){
            weakSelf.text = t;
            return weakSelf;
        };
    }
    return self;
}
-(void)test{
    
    self.cy_BgColor([UIColor redColor]);
    NSLog(@"-----------");
    
}

@end
