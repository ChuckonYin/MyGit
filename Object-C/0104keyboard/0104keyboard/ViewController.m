//
//  ViewController.m
//  0104keyboard
//
//  Created by ChuckonYin on 16/1/4.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import "CYKeyBoardManager.h"
@interface ViewController ()

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UITextView *textView;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _timerRec = @0;
    
    [CYKeyBoardManager share];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, 200, 30)];
    _textField.backgroundColor = [UIColor redColor];
    [self.view addSubview:_textField];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(50, 200, 200, 30)];
    _textView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_textView];
    
    [self addObserver:self forKeyPath:@"timerRec" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew  context:NULL];
    
    
    NSArray *appWindows = [UIApplication sharedApplication].windows;
    NSLog(@"%@", appWindows);
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAct) userInfo:nil repeats:YES];
    
    _model = [DataModel new];
    _model.age = @"8";
    [self.model addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSLog(@"%@___%@___%@", keyPath, object, change);
}

- (void)timerAct
{
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _model.age = @"11";
    _timerRec = [NSString stringWithFormat:@"%li", [_timerRec integerValue]+1];
}


@end












