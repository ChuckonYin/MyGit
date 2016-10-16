//
//  ViewController.m
//  1130iconsolse
//
//  Created by ChuckonYin on 15/11/30.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import <iConsole.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEventAction)]];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    [super touchesBegan:touches withEvent:event];
}

-(void)tapEventAction
{
    NSLog(@"tap");
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (event.subtype == UIEventSubtypeMotionShake) {
        NSLog(@"摇一摇");
        [iConsole show];
    }
    [super motionEnded:motion withEvent:event];
}



@end
