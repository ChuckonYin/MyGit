//
//  ViewController.m
//  Yxk工程母板
//
//  Created by yxk-yxk on 15/9/21.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

{
    NSMutableSet *set;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
 
  
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(act) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    
//    set = [[NSMutableSet alloc] init];
//    for (int i = 0; i < 10000000; i++) {
//        UINavigationController *lab = [[UINavigationController alloc] init];
//        [set addObject:lab];
//        NSLog(@"%i",i);
//    }
    NSArray *arr = @[@1,@2,@3];
    arr[6];
    
    [self performSelector:@selector(createLab) withObject:nil afterDelay:4];
}
-(void)createLab{
    self.view.backgroundColor = [UIColor redColor];
}
-(void)act{
    NSLog(@"sfdsfdgafsdfas");
}
-(void)didReceiveMemoryWarning
{
    NSLog(@"_____");
}

@end
