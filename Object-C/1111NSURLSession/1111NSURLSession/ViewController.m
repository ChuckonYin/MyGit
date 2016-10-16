//
//  ViewController.m
//  1111NSURLSession
//
//  Created by ChuckonYin on 15/11/11.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionDownloadDelegate>

@property (nonatomic, strong) UIProgressView *progressBar;

@property (nonatomic, strong) UIButton *startBtn;
@property (nonatomic, strong) UIButton *pauseBtn;
@property (nonatomic, strong) UIButton *resumeBtn;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) NSURLSessionDownloadTask *task;
//@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSData *partialData;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _progressBar = [[UIProgressView alloc] initWithFrame:CGRectMake(50, 300, 250, 20)];
    [self.view addSubview:_progressBar];
    _progressBar.progress = 0.5f;
    
    _startBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 150, 70, 30)];
    _startBtn.backgroundColor = [UIColor redColor];
    [_startBtn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_startBtn];
    
    _pauseBtn = [[UIButton alloc] initWithFrame:CGRectMake(130, 150, 70, 30)];
    _pauseBtn.backgroundColor = [UIColor redColor];
    [_pauseBtn addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_pauseBtn];
    
    _resumeBtn = [[UIButton alloc] initWithFrame:CGRectMake(230, 150, 70, 30)];
    _resumeBtn.backgroundColor = [UIColor redColor];
    [_resumeBtn addTarget:self action:@selector(resume) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_resumeBtn];
    
}

- (NSURLSession *)session
{
    //创建NSURLSession
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession  *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    return session;
}

- (NSURLRequest *)request
{
    //创建请求
    NSURL *url = [NSURL URLWithString:@"https://image.baidu.com/search/detail?ct=503316480&z=0&ipn=false&word=%E9%AB%98%E6%B8%85%E5%A3%81%E7%BA%B8&pn=3&spn=0&di=59749922980&pi=0&rn=1&tn=baiduimagedetail&is=0%2C0&ie=utf-8&oe=utf-8&in=3354&cl=2&lm=-1&cs=1216347794%2C3395334200&os=2813329614%2C1228458700&simid=3414930286%2C250973737&adpicid=0&fr=ala&sme=&statnum=wallpaper&cg=wallpaper&bdtype=0&objurl=http%3A%2F%2Fi3.topit.me%2F3%2F9c%2Fbc%2F1133861393232bc9c3o.jpg&fromurl=http%3A%2F%2Fwww.topit.me%2Fitem%2F11740553&gsm=0"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    return request;
}

-(void)start
{
    //用NSURLSession和NSURLRequest创建网络任务
    self.task = [[self session] downloadTaskWithRequest:[self request]];
    [self.task resume];
}

-(void)pause
{
    NSLog(@"Pause download task");
    if (self.task) {
        //取消下载任务，把已下载数据存起来
        [self.task cancelByProducingResumeData:^(NSData *resumeData) {
            self.partialData = resumeData;
            self.task = nil;
        }];
    }
}

-(void)resume
{
    NSLog(@"resume download task");
    if (!self.task) {
        //判断是否又已下载数据，有的话就断点续传，没有就完全重新下载
        if (self.partialData) {
            self.task = [[self session] downloadTaskWithResumeData:self.partialData];
        }else{
            self.task = [[self session] downloadTaskWithRequest:[self request]];
        }
    }
    [self.task resume];
}

//创建文件本地保存目录
-(NSURL *)createDirectoryForDownloadItemFromURL:(NSURL *)location
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *urls = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentsDirectory = urls[0];
    return [documentsDirectory URLByAppendingPathComponent:[location lastPathComponent]];
}
//把文件拷贝到指定路径
-(BOOL) copyTempFileAtURL:(NSURL *)location toDestination:(NSURL *)destination
{
    
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtURL:destination error:NULL];
    [fileManager copyItemAtURL:location toURL:destination error:&error];
    if (error == nil) {
        return true;
    }else{
        NSLog(@"%@",error);
        return false;
    }
}

#pragma mark NSURLSessionDownloadDelegate
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    //下载成功后，文件是保存在一个临时目录的，需要开发者自己考到放置该文件的目录
    NSLog(@"Download success for URL: %@",location.description);
    NSURL *destination = [self createDirectoryForDownloadItemFromURL:location];
    BOOL success = [self copyTempFileAtURL:location toDestination:destination];
    
    if(success){
        //        文件保存成功后，使用GCD调用主线程把图片文件显示在UIImageView中
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithContentsOfFile:[destination path]];
            self.imageView.image = image;
            self.imageView.contentMode = UIViewContentModeScaleAspectFit;
            self.imageView.hidden = NO;
        });
    }else{
        NSLog(@"Meet error when copy file");
    }
    self.task = nil;
}

/* Sent periodically to notify the delegate of download progress. */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    //刷新进度条的delegate方法，同样的，获取数据，调用主线程刷新UI
    double currentProgress = totalBytesWritten/(double)totalBytesExpectedToWrite;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.progressBar.progress = currentProgress;
        self.progressBar.hidden = NO;
    });
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes
{
}

@end
