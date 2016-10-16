//
//  ViewController.m
//  1025widow、字体
//
//  Created by ; on 15/10/25.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    self.addWindow = [[UIWindow alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
//    _addWindow.backgroundColor = [UIColor lightGrayColor];
//    _addWindow.windowLevel = 10000;
//    
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
//    label.backgroundColor = [UIColor redColor];
//    [_addWindow addSubview:label];
//    _addWindow.hidden = NO;
////t
//    ViewController *vc = [[ViewController alloc] init];
//    vc.view.backgroundColor = [UIColor redColor];
//    _addWindow.rootViewController = vc;
//    [_addWindow makeKeyAndVisible];
    
    UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(50, 200, 200, 50)];
    [self.view addSubview:field];
    field.backgroundColor = [UIColor lightGrayColor];
    
    [field becomeFirstResponder];
    
//    NSLog(@"%@",_addWindow);
    
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}





@end
