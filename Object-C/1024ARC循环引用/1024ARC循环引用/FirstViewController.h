//
//  FirstViewController.h
//  1024ARC循环引用
//
//  Created by ChuckonYin on 15/10/24.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FirstViewControllerDelegate <NSObject>

-(void)FirstViewControllerAct;

@end

@interface FirstViewController : UIViewController

@property (nonatomic, assign) id<FirstViewControllerDelegate> delegate;

@end
