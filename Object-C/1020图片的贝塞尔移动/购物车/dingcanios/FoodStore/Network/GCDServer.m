//
//  GCDServer.m
//  FoodStore
//
//  Created by ZhangShouC on 12/10/14.
//  Copyright (c) 2014 viewcreator3d. All rights reserved.
//

#import "GCDServer.h"
#import "Public.h"
@implementation GCDServer

//- (void)dataWithModel:(NSString *)url
//{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            if (data) {
//                if ([_delegate respondsToSelector:@selector(sucessWithData:) ]) {
//                    [_delegate sucessWithData:data];
//                }
//            } else {
//                if ([_delegate respondsToSelector:@selector(failLoad)]) {
//                    [_delegate failLoad];
//                }
//            }
//        });
//        
//    });
//}
+ (void)serverWithUrl:(NSString *)url complete:(void(^)(NSData*))complete
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                 [Public sharedPublic].dataBites += [data length];
                complete(data);
            }
        });
    });
}

+ (void)setImageWithUrl:(NSString *)url
                   view:(id)view
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                [Public sharedPublic].dataBites += [data length];
                if ([view isKindOfClass:[UIImageView class]]) {
                    [(UIImageView *)view setImage:[UIImage imageWithData:data]];
                } else if ([view isKindOfClass:[UIButton class]]) {
                    [(UIButton *)view setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
                }
            }
        });
        
    });
}
+ (void)serverWithUrl:(NSString *)url
             complete:(void(^)(NSData*))complete
                error:(void(^)(NSError*))error
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                 [Public sharedPublic].dataBites += [data length];
                complete(data);
            } else {
                NSError * err = [[NSError alloc] init];
                error(err);
            }
        });
    });
}
@end
