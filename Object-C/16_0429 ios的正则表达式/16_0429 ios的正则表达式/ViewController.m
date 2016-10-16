//
//  ViewController.m
//  16_0429 ios的正则表达式
//
//  Created by ChuckonYin on 16/4/29.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "ViewController.h"
//#define result() ({int a=99;int b=99;a+b;})

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"%i", result());

    NSString *oriString = @"123456tyui5432";
    NSRange range = NSMakeRange(0, oriString.length);
    
    NSString *regexSring = @"[0-9]";
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexSring options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *newString = [regex stringByReplacingMatchesInString:oriString options:NSMatchingReportProgress range:range withTemplate:@""];
    NSLog(@"%@", newString);
    NSUInteger i = [regex numberOfMatchesInString:oriString options:0 range:range];
    NSLog(@"%li", i);
    
    NSLog(@"_______%i", [self isPhoneNumber:@"qwerqwwe131q"]);
    NSLog(@"_______%i", [self isPhoneNumber:@"135768908981"]);
    NSLog(@"_______%i", [self isPhoneNumber:@"qwerqwtryuui"]);
    
    NSLog(@"_______%i", [self isCode:@"qwerqwwe131q"]);
    NSLog(@"_______%i", [self isCode:@"13576890898=1"]);
    NSLog(@"_______%i", [self isCode:@"qwerqwtryuu_i"]);
    
    
    [self isUserName:oriString];
}

- (BOOL)isUserName:(NSString *)userName{
    NSString *regexSring = @"[_A-Z0-9a-z\u4e00-\u9fa5*]";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexSring options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *newString = [regex stringByReplacingMatchesInString:userName options:0 range:NSMakeRange(0, userName.length) withTemplate:@""];
    if (newString.length>0) {
        return NO;
    }
    else{
        return YES;
    }
}


- (BOOL)isPhoneNumber:(NSString *)oriString{
    NSString *regexSring = @"[0-9]";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexSring options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *newString = [regex stringByReplacingMatchesInString:oriString options:NSMatchingReportProgress range:NSMakeRange(0, oriString.length) withTemplate:@""];
    if (newString.length==0) {
        return YES;
    }
    else{
        return NO;
    }
}

- (BOOL)isCode:(NSString *)oriString{
    NSString *regexSring = @"^[a-z0-9_-]{6,18}$";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexSring options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *newString = [regex stringByReplacingMatchesInString:oriString options:NSMatchingReportProgress range:NSMakeRange(0, oriString.length) withTemplate:@""];
    NSLog(@"code======%@", newString);
    if (newString.length==0) {
        return YES;
    }
    else{
        return NO;
    }
}


@end
