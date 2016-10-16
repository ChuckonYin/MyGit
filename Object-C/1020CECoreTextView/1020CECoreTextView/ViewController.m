//
//  ViewController.m
//  1020CECoreTextView
//
//  Created by ChuckonYin on 15/10/20.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "SETextView.h"
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width

@interface ViewController ()<SETextViewDelegate>
{
    SETextView *_textView1;
//    SETextView *_textView2;
    SELinkText *linktext;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    _textView1 = [[SETextView alloc] init];
    [self.view addSubview:_textView1];
    [_textView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(50);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(600);
    }];
    _textView1.backgroundColor = [UIColor lightGrayColor];
    _textView1.delegate = self;
    _textView1.editable = YES;
    _textView1.selectable = YES;
    [self init_textView1];
    
    [NSObject alloc];
    
}
- (void)init_textView1{
    _textView1.font = [UIFont systemFontOfSize:17];
    _textView1.text = @"用SECoreTextView遇到的几个问题\n:项目中有类r6789uhonuhgybhun似于微博的界面展示";
    
//    _textView1.lineHeight = 50;
    _textView1.lineSpacing = 10;
    _textView1.textAlignment = NSTextAlignmentCenter;
    _textView1.linkHighlightColor = [UIColor redColor];
    _textView1.linkRolloverEffectColor = [UIColor blueColor];
    
    
    _textView1.inputView.backgroundColor = [UIColor redColor];
    _textView1.inputAccessoryView.backgroundColor = [UIColor yellowColor];
    
    
    UIImageView *insertView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 25, 50, 50)];
//    insertView.backgroundColor = [UIColor redColor];
    insertView.image = [UIImage imageNamed:@"payzt.jpg"];
    
    [_textView1 addObject:insertView size:CGSizeMake(50, 50) atIndex:5];
//    [_textView1 insertObject:insertView size:CGSizeMake(50, 50)];
    
    
    NSString *url = @"http://m.baidu.com";
    linktext = [[SELinkText alloc] initWithText:@"http://m.baidu.com" object:nil range:NSMakeRange(0, 12)];
    [_textView1 addObject:linktext size:CGSizeMake(url.length*5, 10) atIndex:8];
    
    _textView1.linkRolloverEffectColor = [UIColor redColor];
    _textView1.linkHighlightColor = [UIColor redColor];
    
}

- (BOOL)textView:(SETextView *)textView clickedOnLink:(SELinkText *)link atIndex:(NSUInteger)charIndex{
    NSLog(@"%s",__func__);
    return YES;
}
- (BOOL)textView:(SETextView *)textView longPressedOnLink:(SELinkText *)link atIndex:(NSUInteger)charIndex{
    NSLog(@"%s",__func__);
    return YES;
}

@end







