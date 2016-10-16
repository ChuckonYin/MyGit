//
//  ViewController.m
//  JSPatch
//
//  Created by ChuckonYin on 16/1/15.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    JSContext *ctx = [JSContext new];
    [ctx setExceptionHandler:^(JSContext *erroContext, JSValue *value) {
        NSLog(@"异常1%@异常2%@", erroContext.exception, value);
    }];
    
    
    //#import "JSContext.h"
    //#import "JSValue.h"
    //#import "JSManagedValue.h"
    //#import "JSVirtualMachine.h"
    //#import "JSExport.h"
    
//    JSVirtualMachine *jsMachine = [[JSVirtualMachine alloc] init];
//    
//    JSContext *context = [[JSContext alloc] initWithVirtualMachine:jsMachine];
//    
//    JSValue *jsValue = [JSValue valueWithNewArrayInContext:context];
//    
////    JSExportAs(@"dd", @selector(commit));
//    JSManagedValue *mv = [[JSManagedValue alloc] initWithValue:jsValue];
    

    JSValue *jsValue = [ctx evaluateScript:@"21+5"];
    NSLog(@"%@", jsValue);
    
    [ctx evaluateScript:@"var arr = [123, 'yinxukun', 'Chuckon']"];
    
    JSValue *jsArr = ctx[@"arr"];
    jsArr[6];
    
    NSLog(@"%@, %i", [jsArr toArray], [jsArr[@"length"] toInt32]);
    
    UIWebView *web = [UIWebView new];
    [web stringByEvaluatingJavaScriptFromString:@""];
    
    //此处注意内存泄漏
    ctx[@"myFunction"] = ^(){
        
        NSArray *args = [JSContext currentArguments];
        JSValue *window = [JSContext currentThis];
        NSLog(@"_____%@___%@", args, window);
        
    };
    [ctx evaluateScript:@"myFunction(1,2,3,4,5,6)"];
    
    [ctx evaluateScript:@"function add(a, b){return a+b;}"];
    
    [ctx evaluateScript:@"add(99,999)"];
    
    JSValue *funcValue = ctx[@"add"];
    
    JSValue *sumValue = [funcValue callWithArguments:@[@2,@3]];
    
    NSLog(@"%@", sumValue);
    
//    JSValue *addSum = [ invokeMethod:@"add" withArguments:@[@7, @3]];
    
//    NSLog(@"%@", addSum);
    //异常处理
    [ctx evaluateScript:@"function 抛出一个错误"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(nextViewController)];
    
}

- (void)commit{
    
}

- (void)nextViewController{
    
    [self.navigationController pushViewController:[FirstViewController new] animated:YES];
    
}


@end






