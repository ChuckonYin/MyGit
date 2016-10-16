//
//  ViewController.m
//  1022runloop
//
//  Created by ChuckonYin on 15/10/22.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITabBarControllerDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) BOOL btnClick;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _btnClick = NO;
 
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 150, 375, 600) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;

    NSLog(@"%@",[NSRunLoop currentRunLoop].currentMode);
    
//    [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(act) userInfo:nil repeats:YES];
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.3 target:self selector:@selector(act) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    NSRunLoop *loop = [NSRunLoop currentRunLoop];
//    loop runMode:<#(nonnull NSString *)#> beforeDate:<#(nonnull NSDate *)#>
    BOOL complete = NO;
    while (!complete) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}
-(void)act{
    NSLog(@"%@",[NSDate date]);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 200;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"%@",[NSRunLoop currentRunLoop].currentMode);
//    NSLog(@"fsfs");
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    NSLog(@"________%@",[NSRunLoop currentRunLoop].currentMode);
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[touches anyObject] locationInView:self.view];
    _btnClick = YES;
}

@end
