//
//  URLSessionViewController.m
//  1203NSURLSession
//
//  Created by ChuckonYin on 15/12/4.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "URLSessionViewController.h"

#define imgUrl @"http://g.hiphotos.baidu.com/image/pic/item/0dd7912397dda14493557361b6b7d0a20df48680.jpg"

@interface URLSessionViewController ()<NSURLSessionDownloadDelegate,NSURLSessionDataDelegate>

@property (nonatomic, strong) NSURLSessionDownloadTask *downLoadTask;

@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@end

@implementation URLSessionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startDownloadTask];
//    [self startDataTask];
    
}

-(void)startDownloadTask{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    NSURLRequest *rq = [NSURLRequest requestWithURL:[NSURL URLWithString:imgUrl]];
    _downLoadTask = [session downloadTaskWithRequest:rq];
    _dataTask = [session dataTaskWithRequest:rq];
    [_dataTask resume];
    [_downLoadTask resume];
}

#pragma mark - NSURLSessionDownloadDelegate
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
//    NSLog(@"%@=====%@", downloadTask, location);
//    NSData *data = [NSData dataWithContentsOfURL:location];
//    NSLog(@"data=%@", data);
//    //此处仍然处于子线程中
//    NSRunLoop *r1 = [NSRunLoop mainRunLoop];
//    NSRunLoop *r2 = [NSRunLoop currentRunLoop];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        self.view.layer.contents = (id)([UIImage imageWithData:data].CGImage);
//    });
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
    
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    NSLog(@"%lld___%lld___%lld", bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
}
#pragma mark - data

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    //此处仍然处于子线程中
    BOOL isMain = [NSThread isMainThread];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.view.layer.contents = (id)([UIImage imageWithData:data].CGImage);
    });
}




@end
