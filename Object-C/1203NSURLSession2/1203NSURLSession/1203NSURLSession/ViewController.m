//
//  ViewController.m
//  1203NSURLSession
//
//  Created by ChuckonYin on 15/12/3.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import <UIWebView+AFNetworking.h>
#import <objc/runtime.h>
#import "UILabel+CYAdd.h"
#import <UIButton+AFNetworking.h>
#import "AFImageDownloader.h"
#import <UIImageView+WebCache.h>
#import "URLSessionViewController.h"

#define imgUrl @"http://g.hiphotos.baidu.com/image/pic/item/0dd7912397dda14493557361b6b7d0a20df48680.jpg"

@interface ViewController ()<NSURLSessionDataDelegate,NSURLSessionDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(push)];
    
    [self loadData];
    [self testCategory];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor lightGrayColor];
    [btn setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:imgUrl]];
    
    AFImageDownloader *downLoader = [AFImageDownloader defaultInstance];
    [UIButton setSharedImageDownloader:downLoader];
    [btn setImageForState:UIControlStateNormal withURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imgUrl]] placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        NSLog(@"%@",image);
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 300, 200, 200)];
    [self.view addSubview:view];
    [view sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
    view.backgroundColor = [UIColor lightGrayColor];
    
    [self onlyAFNetworkingStudy];
 
    //默认下载
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.allowsCellularAccess = YES; //允许3g网络
    config.discretionary = YES; //允许后台自动发起请求
    
    [NSURLConnection sendAsynchronousRequest:nil queue:nil completionHandler:nil];//全局
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];//请求独立
    
    NSURLSessionDataTask; NSURLSessionUploadTask; NSURLSessionDownloadTask;
    
    NSURLSessionDownloadTask *downLoadTask = [session downloadTaskWithRequest:nil];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:nil];
    
    [downLoadTask resume];
    
    [dataTask resume];
    
    [dataTask suspend];
    
    [dataTask cancel];
    
}





- (void)loadData{
    AFURLSessionManager *sesMamager = [[AFURLSessionManager alloc] init];
    AFHTTPSessionManager *httpManager = [[AFHTTPSessionManager alloc] init];
}

- (void)testCategory
{
    UILabel *lab = [UILabel new];
    lab.labelID = @"99";
    NSLog(@"__________%@",lab.labelID);
}

- (void)onlyAFNetworkingStudy{
    
}

- (void)push{
    [self.navigationController pushViewController:[URLSessionViewController new] animated:YES];
}























@end
