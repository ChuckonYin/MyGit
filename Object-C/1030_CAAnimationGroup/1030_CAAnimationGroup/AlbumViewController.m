//
//  AlbumViewController.m
//  1030_CAAnimationGroup
//
//  Created by ChuckonYin on 15/11/3.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "AlbumViewController.h"
#define IMAGE_COUNT 5

@interface AlbumViewController ()
{
    UIImageView *_imageView;
    NSInteger _currentIndex;
}


@end

@implementation AlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //定义图片控件
    _imageView=[[UIImageView alloc]init];
    _imageView.frame=[UIScreen mainScreen].applicationFrame;
//    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.image=[UIImage imageNamed:@"动画api.png"];//默认图片
    [self.view addSubview:_imageView];
        //添加手势
    UISwipeGestureRecognizer *leftSwipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe:)];
    leftSwipeGesture.direction  = UISwipeGestureRecognizerDirectionLeft;
        [self.view addGestureRecognizer:leftSwipeGesture];

    UISwipeGestureRecognizer *rightSwipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe:)];
    rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
        [self.view addGestureRecognizer:rightSwipeGesture];
}

#pragma mark 向左滑动浏览下一张图片
-(void)leftSwipe:(UISwipeGestureRecognizer *)gesture{
    [self transitionAnimation:YES];
}

#pragma mark 向右滑动浏览上一张图片
-(void)rightSwipe:(UISwipeGestureRecognizer *)gesture{
    [self transitionAnimation:NO];
}
#pragma mark 转场动画
-(void)transitionAnimation:(BOOL)isNext{
        //1.创建转场动画对象
        CATransition *transition=[[CATransition alloc]init];

        //2.设置动画类型,注意对于苹果官方没公开的动画类型只能使用字符串，并没有对应的常量定义
    /**
     *  左侧存有博客API截图@“动画api.png”
     */
        transition.type=@"push";
        //设置子类型
        if(isNext){
    transition.subtype          = kCATransitionFromRight;
        }else{
    transition.subtype          = kCATransitionFromLeft;
        }
        //设置动画时常
    transition.duration         = 1.0f;

        //3.设置转场后的新视图添加转场动画
        _imageView.image=[self getImage:isNext];
        [_imageView.layer addAnimation:transition forKey:@"KCTransitionAnimation"];
}

#pragma mark 取得当前图片
-(UIImage *)getImage:(BOOL)isNext{
    if(isNext) {
       _currentIndex=(_currentIndex+1)%IMAGE_COUNT;
    }
    else{
       _currentIndex=(_currentIndex-1+IMAGE_COUNT)%IMAGE_COUNT;
    }
    NSString *imageName=[NSString stringWithFormat:@"girl.jpg"];
    return [UIImage imageNamed:imageName];
}

@end

