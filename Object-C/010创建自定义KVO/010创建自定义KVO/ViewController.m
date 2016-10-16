//
//  ViewController.m
//  010创建自定义KVO
//
//  Created by ChuckonYin on 16/1/5.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@property (nonatomic, strong) Person *person;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _person = [Person new];
    _person.age = 18;
    
    [_person addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    
    _person.age = 0;
    
    NSLog(@"%@", _person.class);
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
}


@end

















