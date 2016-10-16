//
//  H5ServiceDelegate.h
//  h5test
//
//  Created by ChuckonYin on 16/5/11.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import <UIKit/UIKit.h>

//可以放到common层

@interface H5ServiceDelegate : NSObject

- (BOOL)jsCallNormalNativeMethod:(NSString *)methodName;

@end
