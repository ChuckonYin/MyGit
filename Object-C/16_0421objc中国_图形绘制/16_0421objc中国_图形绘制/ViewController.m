//
//  ViewController.m
//  16_0421objc中国_图形绘制
//
//  Created by ChuckonYin on 16/4/21.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "ViewController.h"
#import "ScrollViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView *imv;

@property (nonatomic, strong) NSOperationQueue *queqe;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.imv];
    
//    for (int i=0; i<1000; i++) {
//        [self drawAnImage:i];
//    }
}

- (void)drawAnImage:(NSInteger)i{
    CGSize size = CGSizeMake(300, 300);
    [self.queqe addOperationWithBlock:^{
        UIGraphicsBeginImageContext(size);
        
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextMoveToPoint(ctx, 0, 0);
        CGContextAddLineToPoint(ctx, size.width, size.height);
        CGContextMoveToPoint(ctx, size.width, 0);
        CGContextAddLineToPoint(ctx, 0, size.height);
        CGContextSetRGBStrokeColor(ctx, 1, 0, 0, 1);
        CGContextStrokePath(ctx);
        
        UIImage *img =  UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.imv.image = img;
            NSLog(@"%li", i);
        }];
    }];
}


- (UIImageView *)imv{
    if (!_imv) {
        _imv = [[UIImageView alloc] initWithFrame:CGRectMake(50, 200, 200, 200)];
        _imv.backgroundColor = [UIColor lightGrayColor];
    }
    return _imv;
}

- (NSOperationQueue *)queqe{
    if (!_queqe) {
        _queqe = [[NSOperationQueue alloc] init];
    }
    return _queqe;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self presentViewController:[ScrollViewController new] animated:YES completion:nil];
}



@end
