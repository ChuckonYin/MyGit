//
//  BaseViewController.m
//  FoodStore
//
//  Created by liuguopan on 14-12-8.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBar];
}

- (void)setNavigationBar
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self setBarTintColor:[UIColor colorWithRed:0.55f green:0.0f blue:0.0f alpha:1.00f]];
}

- (void)setBarTintColor:(UIColor *)color
{
    if (IOS_VERSION >= 7.0f) {
        self.navigationController.navigationBar.barTintColor = color;
    } else {
        self.navigationController.navigationBar.tintColor = color;
    }
}
- (void)resetTitleView:(NSString *)title
{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text = title;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = label;
}
- (void)setTitleButton:(NSString *)title
                   sel:(SEL)sel
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 150, 30);
    [button addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:[NSString stringWithFormat:@"%@  ▾",title] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    button.titleLabel.numberOfLines = 2;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    self.navigationItem.titleView = button;
}
- (void)setSliderItem
{
    UIButton * slider = [UIButton buttonWithType:UIButtonTypeCustom];
    [slider setImage:[UIImage imageNamed:@"LeftSide.png"] forState:UIControlStateNormal];
    slider.frame = CGRectMake(0, 0, 30, 20);
    [slider addTarget:self action:@selector(sliderButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:slider];
}
- (void)sliderButtonClick
{
    [self.viewDeckController toggleLeftViewAnimated:YES];
}
- (void)sliderAbled:(BOOL)yesOrNo
{
    self.viewDeckController.enabled = yesOrNo;
}
- (void)setBackItem:(SEL)sel
{
    UIButton * back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    back.frame = CGRectMake(0, 0, 25, 25);
    [back addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:back];
}
- (void)backPop
{
    [SVProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)backDismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)setRightSearchItem:(SEL)sel
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:sel];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}

- (void)setLeftItem:(NSString *)title
                sel:(SEL)sel
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 20*title.length, 30);
    [button addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)setRightItem:(NSString *)title
                 sel:(SEL)sel
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 20*title.length, 30);
    [button addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
//    [button setBackgroundColor:[UIColor colorWithRed:0.6f green:0.0f blue:0.0f alpha:1.00f]];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)bPushBind:(BOOL)yesOrNo
{
    if (yesOrNo) {
        [BPush bindChannel];
    } else {
        [BPush unbindChannel];
    }
    
}

#pragma mark - 锁定竖屏

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

#ifdef __IPHONE_6_0
-(BOOL)shouldAutorotate
{
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations
{
    
    return UIInterfaceOrientationMaskPortrait;
}
#endif

#pragma mark -

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
