//
//  ViewController.m
//  16_0419布局动作
//
//  Created by ChuckonYin on 16/4/19.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "ViewController.h"
#import "LayoutTestView.h"
#import <Masonry.h>

@interface ViewController ()

@property (nonatomic, strong) LayoutTestView *testView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.testView];
    
    __unsafe_unretained ViewController *weakSelf = self;
    
    [self.testView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:2 animations:^{
        [weakSelf.testView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(weakSelf.view).offset(100);
            make.right.bottom.equalTo(weakSelf.view).offset(-100);
        }];
        [self.view layoutIfNeeded];
    }];
    [UIView animateWithDuration:10 delay:2 usingSpringWithDamping:0.1 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        //        [self.testView mas_updateConstraints:^(MASConstraintMaker *make) {
        //            make.right.equalTo(self.view);
        //            make.bottom.equalTo(self.view);
        //        }];
        self.testView.transform = CGAffineTransformMakeTranslation(100, 100);
        //        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
    self.view.contentMode = UIViewContentModeTop;
    [self.view sizeToFit];
}


- (void)viewDidLayoutSubviews{
    NSLog(@"%s", __func__);
}

- (LayoutTestView *)testView{
    if (!_testView) {
        _testView = [[LayoutTestView alloc] initWithFrame:CGRectMake(0, 0, 30, 100)];
        _testView.backgroundColor = [UIColor redColor];
    }
    return _testView;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [UIView animateWithDuration:10 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        [self.testView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.view);
//            make.bottom.equalTo(self.view);
//        }];
        self.testView.transform = CGAffineTransformMakeTranslation(-100, -100);
//        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
    
}


@end
