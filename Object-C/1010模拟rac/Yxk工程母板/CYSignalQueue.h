//
//  CYSignalQueue.h
//  Yxk工程母板
//
//  Created by ChuckonYin on 15/10/10.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYSignal.h"

@interface CYSignalQueue : NSObject

@property (nonatomic, strong) CYSignal *currentSignal;

@property (nonatomic, strong) NSMutableArray *signalArr;

+(id)queue;

-(void)addCYSignal:(CYSignal*)signal;


@end
