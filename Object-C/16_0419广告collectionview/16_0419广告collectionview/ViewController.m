//
//  ViewController.m
//  16_0419广告collectionview
//
//  Created by ChuckonYin on 16/4/19.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "ViewController.h"
#import "CYAdView.h"
#import "UIView+KeyBoardHelp.h"
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width

@interface ViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    
    CYAdView *adView = [[CYAdView alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height-10, kScreenWidth-30, 100) scrollDirection:CYAdViewPositionHorizontally];
    [self.view addSubview:adView];
    
    NSMutableArray *array = [NSMutableArray new];
    for (int i=0; i<3; i++) {
        CYAdModel *model = [CYAdModel new];
        model.image = [UIImage imageNamed:[NSString stringWithFormat:@"%i.jpg", i]];
        [array addObject:model];
    }
    [adView refreshWithImages:array clickAction:^(CYAdModel *model) {
        
    }];
    
    [self.view addSubview:self.textField];
    self.textField.autoMovingRelyOnKeyBoard = YES;
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height-50, kScreenWidth, 50)];
        _textField.borderStyle = UITextBorderStyleLine;
        _textField.delegate = self;
    }
    return _textField;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_textField resignFirstResponder];
    return YES;
}

@end








