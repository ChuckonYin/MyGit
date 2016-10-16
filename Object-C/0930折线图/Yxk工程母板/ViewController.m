//
//  ViewController.m
//  Yxk工程母板
//
//  Created by 尹绪坤 on 15/10/07.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import "InvestSnapView.h"

@interface ViewController ()
{
    InvestSnapView *_snapView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _snapView = [[InvestSnapView alloc] initWithFrame:CGRectMake(25, 100,kScreenWidth-50, 300)];
    [self.view addSubview:_snapView];
    _snapView.backgroundColor = [UIColor brownColor];
//    _snapView.backgroundColor = colorWhite;
    
  
    
    [_snapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    NSMutableArray *array = [NSMutableArray new];
    for (int i = 0; i < 30; i++) {
        [array addObject:@((arc4random()%50)*0.01+0.3)];
    }
    
    [_snapView setNeedsDisplay:array];
}


//}

@end
