//
//  AppDelegate.h
//  1130iconsolse
//
//  Created by ChuckonYin on 15/11/30.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iConsole.h>

@interface CYWindow : iConsoleWindow

@end


@interface AppDelegate : UIResponder <UIApplicationDelegate,iConsoleDelegate>

@property (strong, nonatomic) CYWindow *window;


@end

