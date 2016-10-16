//
//  UIButton+CYRacSupport.h
//  Yxk工程母板
//
//  Created by ChuckonYin on 15/10/10.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYSignal.h"

@interface UIControl (CYRacSupport)


-(CYSignal*)cyRac_signalForControlEvents:(UIControlEvents)event;

@end
