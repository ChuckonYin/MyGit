//
//  FirstViewController.m
//  JSPatch
//
//  Created by ChuckonYin on 16/1/25.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "FirstViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JSContext *ctx = [[JSContext alloc] init];
    
    [ctx setExceptionHandler:^(JSContext *context, JSValue *jsvalue) {
        NSLog(@"%@", context.exception);
    }];
    
    ctx[@"log"] = ^(){
        NSArray *args = [JSContext currentArguments];
        for (NSString *arg in args) {
            NSLog(@"参数: %@", arg);
        }
    };
    //所有的对象其实可以视为一组键值对的集合
    [ctx evaluateScript:@"var anStudent = {name:'chuckon', age:'12'}; anStudent"];
    
    JSValue *value1 = ctx[@"anStudent"];
    
    [ctx evaluateScript:@"log(1)"];
    
    [ctx evaluateScript:@"function singASong:(){ }"];
    
    JSValue *func1 = ctx[@"singASong"];
    
    [func1 callWithArguments:nil];
    
    //用oc语法生成js对象
    NSDictionary *aPerson = @{@"name" : @"chockon", @"age" : @26};
    
    ctx[@"aPerson"] = aPerson;
    
    JSValue *jsPerson = ctx[@"aPerson"];
    
    [ctx evaluateScript:@"log('一个oc生成的对象:',aPerson, aPerson.name, aPerson.age)"];
    
    
    UILabel *label = [UILabel new];
    NSHashTable *hashTable = [NSHashTable weakObjectsHashTable];
    __unsafe_unretained id l = label;
    [hashTable addObject:l];
    for (UILabel *lab in hashTable) {
        NSLog(@"%@", lab);
    }
    label = nil;
    for (UILabel *lab in hashTable) {
        NSLog(@"%@", lab);
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end




