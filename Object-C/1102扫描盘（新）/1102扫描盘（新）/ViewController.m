//
//  ViewController.m
//  1102扫描盘（新）
//
//  Created by ChuckonYin on 15/11/2.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import "PercentScanView.h"
#import "Person.h"
@interface ViewController ()
{
    PercentScanView *view;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    view = [[PercentScanView alloc] initWithFrame:CGRectMake(0, 100, 400, 300)];
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    [view refreshViewValue:@0.88 and:@[@"999",@"信用很烂",@"高于66%的用户"] animate:YES];
    
    UIImageView *imav = [[UIImageView alloc] initWithFrame:CGRectMake(0, 400, 400, 300)];
    [self.view addSubview:imav];
    imav.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"43211.png"]];
    
    
    Person *p = [Person new];
    [p setValuesForKeysWithDictionary:@{@"age":@12}];
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    float  a = 0.1;
    
    NSNumber *nuber = [NSNumber numberWithFloat:a];
 
}


@end
