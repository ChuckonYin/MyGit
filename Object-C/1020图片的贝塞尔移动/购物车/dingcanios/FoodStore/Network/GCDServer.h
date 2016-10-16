//
//  GCDServer.h
//  FoodStore
//
//  Created by ZhangShouC on 12/10/14.
//  Copyright (c) 2014 viewcreator3d. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "Model.h"

//@protocol GCDServerDelegate <NSObject>
//
//@optional
//- (void)sucessWithData:(NSData *)data;
//- (void)failLoad;
//
//@end

@interface GCDServer : NSObject

//@property (nonatomic,weak) __weak id<GCDServerDelegate> delegate;

//- (void)dataWithModel:(NetInfo *)info;
//- (void)dataWithModel:(NSString *)url;
+ (void)setImageWithUrl:(NSString *)url
                   view:(id)view;

+ (void)serverWithUrl:(NSString *)url
             complete:(void(^)(NSData*))complete;
+ (void)serverWithUrl:(NSString *)url
             complete:(void(^)(NSData*))complete
                error:(void(^)(NSError*))error;
@end
