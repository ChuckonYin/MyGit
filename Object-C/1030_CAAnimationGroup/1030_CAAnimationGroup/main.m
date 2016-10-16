//
//  main.m
//  1030_CAAnimationGroup
//
//  Created by ChuckonYin on 15/10/30.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        @try {
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception.debugDescription);
        }
        @finally {
            
        }
        
    }
}
