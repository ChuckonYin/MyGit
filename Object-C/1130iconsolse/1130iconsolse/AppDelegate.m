//
//  AppDelegate.m
//  1130iconsolse
//
//  Created by ChuckonYin on 15/11/30.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation CYWindow

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    return [super hitTest:point withEvent:event];
}

//-(void)sendEvent:(UIEvent *)event
//{
//    NSArray *touches = [[event allTouches] allObjects];
//    NSLog(@"______%li",touches.count);
//    if (event.type == UIEventTypeTouches) {
//        UITouch *touch0 = touches[0];
//        NSLog(@"%f",[touch0 locationInView:self].y);
//        NSLog(@"%f",[touch0 previousLocationInView:self].y);
//    }
//    [super sendEvent:event];
//}


@end


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [iConsole sharedConsole].delegate = self;
    [iConsole sharedConsole].enabled = YES;
    
    self.window = [[CYWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor redColor];
    self.window.rootViewController = [[ViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)handleConsoleCommand:(NSString *)command
{
    if ([command isEqualToString:@"email"]) {
        //发送命令或执行命令
    }
}


@end
