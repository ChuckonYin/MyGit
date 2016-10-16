//
//  ViewController.m
//  1225CoreText
//
//  Created by ChuckonYin on 15/12/24.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import "CTDisplayView.h"
#import "CYAttributeLabel.h"
#import "CYFrameRef.h"
#import "CYTextSetter.h"
#import "UIView+CYAdd.h"
#import <CoreText/CoreText.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CTDisplayView *view = [[CTDisplayView alloc] initWithFrame:CGRectMake(30, 80, 300, 200)];
    view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view];
    
    CYAttributeLabel *label = [[CYAttributeLabel alloc] initWithFrame:CGRectMake(30, 300, 300, 300)];
    [self.view addSubview:label];
    
//    CYTextSetter *setter = [[CYTextSetter alloc] init];
//    CYFrameData *data = [CYFrameRef parseText:@"平安金科移动研发组,我不就是想要个富文本，怎么就这么麻烦，苹果干什么吃的，苹果干什么吃的苹果干什么吃的苹果干什么吃的苹果干什么吃的苹果干什么吃的苹果干什么吃的苹果干什么吃的苹果干什么吃的苹果干什么吃的苹果干什么吃的苹果干什么吃的苹果干什么吃的苹果干什么吃的苹果干什么吃的苹果干什么吃的苹果干什么吃的苹果干什么吃的苹果干什么吃的苹果干什么吃的苹果干什么吃的苹果干什么吃的" config:setter];
//    label.height = data.height;
//    label.data = data;
    
    NSMutableAttributedString *attrString2 = [[NSMutableAttributedString alloc] initWithString:@"🔚结束了哦"];
    [attrString2 addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, attrString2.length)];

    label.backgroundColor = [UIColor lightGrayColor];
    [label setObjcArr:@[@"当你老了，头发白了，睡思昏沉　炉火旁打盹请取下这部诗歌　慢慢读，回想你过去眼神的柔和　回想它们昔日浓重的阴影 多少人爱你青春欢畅的时辰 爱慕你的美丽，假意和真心 只有一个人爱你朝圣者的灵魂 爱你衰老了的脸上痛苦的皱纹 垂下头来，在红火闪耀的炉子旁 凄然地轻轻诉说那爱情的消逝 在头顶上的山上它缓缓...",@"诗经300首",attrString2]];
    
    NSLog(@"绘制");
    
//    UILabel *lab = [[UILabel alloc] initWithFrame:self.view.frame];
//    [self.view addSubview:lab];
//    
//    NSMutableAttributedString *attrString = [NSMutableAttributedString new];
//    
//    NSMutableAttributedString *attrString1 = [[NSMutableAttributedString alloc] initWithString:@"字段1"];
//    [attrString1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
//    
//
//    [attrString appendAttributedString:attrString1];
//    
//    [attrString appendAttributedString:attrString2];
//    
//    lab.attributedText = attrString;
    
}

@end








