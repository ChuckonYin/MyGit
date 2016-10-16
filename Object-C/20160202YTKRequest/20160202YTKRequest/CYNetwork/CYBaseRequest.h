//
//  CYBaseRequest.h
//  20160202YTKRequest
//
//  Created by ChuckonYin on 16/2/2.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CYBaseRequest;
@protocol CYBaseRequestDelegate <NSObject>

- (void)oneRequestfinish:(CYBaseRequest *)rq;

@end

@interface CYBaseRequest : NSURLRequest

@property (nonatomic, weak) id<CYBaseRequestDelegate>baseDelegate;

- (void)start;

- (void)finish;

@end
