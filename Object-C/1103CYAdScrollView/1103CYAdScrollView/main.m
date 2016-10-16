//
//  main.m
//  1103CYAdScrollView
//
//  Created by ChuckonYin on 15/11/3.
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
