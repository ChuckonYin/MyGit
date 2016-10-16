//
//  ViewController.m
//  1130渐变色
//
//  Created by ChuckonYin on 15/11/30.
//  Copyright © 2015年 PingAn. All rights reserved.
//


#import "GradientViewController.h"
#import "ShapeViewController.h"

@interface GradientViewController ()

@end

@implementation GradientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(push)];
    
    self.view.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"777.jpg"].CGImage);
    CALayer *layer0 = [self getGradientLayerCGRect:self.view.bounds colors:@[(id)[UIColor clearColor].CGColor,(id)[UIColor clearColor].CGColor,
                                                           (id)[UIColor yellowColor].CGColor] startPoint:CGPointMake(0.5, 0) endPoint:point(0.5, 1)];
    [self.view.layer addSublayer:layer0];
    
    NSArray *colors1 = [NSArray arrayWithObjects:(id)[UIColor yellowColor].CGColor,
     (id)[UIColor redColor].CGColor,nil
     ];
    NSArray *colors2 = [NSArray arrayWithObjects:(id)[UIColor redColor].CGColor,
                        (id)[UIColor yellowColor].CGColor,nil
                        ];
    
    CAGradientLayer *layer1 = [self getGradientLayerCGRect:CGRectMake(0, 200, 300, 100) colors:colors1 startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 1)];
    [self.view.layer addSublayer:layer1];
    
    CAGradientLayer *layer2 = [self getGradientLayerCGRect:CGRectMake(0, 301, 300, 100) colors:colors2 startPoint:CGPointMake(1, 0) endPoint:CGPointMake(0, 1)];
    [self.view.layer addSublayer:layer2];
    
    
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(push)]];
}

- (CAGradientLayer*)getGradientLayerCGRect:(CGRect)rect colors:(NSArray*)colors startPoint:(CGPoint)startP endPoint:(CGPoint)endP
{
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    gradientLayer.colors = colors;
    gradientLayer.frame = rect;
    gradientLayer.startPoint = startP;
    gradientLayer.endPoint = endP;
//    gradientLayer.locations = @[@0.0f,@0.25,@1.0f];
    return gradientLayer;
}
-(void)push{
    [self.navigationController pushViewController:[ShapeViewController new] animated:YES];
}




@end
