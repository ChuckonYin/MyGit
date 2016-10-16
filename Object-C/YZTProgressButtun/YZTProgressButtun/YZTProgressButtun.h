//
//  YZTProgressButtun.h
//  YZTProgressButtun
//
//  Created by ChuckonYin on 16/4/22.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZTProgressButtun : UIButton

- (void)startWithTimeInterval:(NSTimeInterval)interval clickAction:(void(^)())clickAction endAction:(void(^)())endAction;

@end
