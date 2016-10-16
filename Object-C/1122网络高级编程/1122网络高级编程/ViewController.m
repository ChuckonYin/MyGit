//
//  ViewController.m
//  1122网络高级编程
//
//  Created by ChuckonYin on 15/11/22.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"

#define myFilePath @"/home/chuckon"

@interface ViewController ()
//{
//    NSTimer *_timer;
//    NSRunLoop *quequeLoop;
//    
//}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  CFNetwork 与BSD soket 的主要区别在于运行循环的集成
     */
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"线程开始执行");
        NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(test) userInfo:nil repeats:YES];
        NSRunLoop *quequeLoop = [NSRunLoop currentRunLoop];
        [quequeLoop addTimer:timer forMode:NSRunLoopCommonModes];
//        [timer setFireDate:[NSDate date]];
        /**
         *  子线程的消息循环必须手动启动
         */
        [quequeLoop run];
    });
   
    //url百分号编码
    NSString *str = @"http://myhost.com?query = this is my question";
    //http://myhost.com?query%20=%20this%20is%20my%20question
    NSString *ecodeStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",ecodeStr);
    
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com/"];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSLog(@"%@",data);
    }];
    
//    url.port;
    //url设置中若添加了非法字符，返回nil
    NSURL *invalidUrl = [NSURL URLWithString:@"http  s://www.   baidu.com/"];
    //使用非默认的缓存机制和超时时间
    NSURLRequest *rq = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20];
    //NSURLRequest默认get请求，且不可更改
    NSMutableURLRequest *mutaRequest = [rq mutableCopy];
    [mutaRequest setHTTPMethod:@"POST"];
    [mutaRequest setHTTPBody:[@"post body" dataUsingEncoding:NSUTF8StringEncoding]];
    
    /**
     *  以数据流的方式传递数据  NSInputStream
     */
    NSInputStream *fileStream = [NSInputStream inputStreamWithFileAtPath:myFilePath];
    [mutaRequest setHTTPBodyStream:fileStream];
    
    
}

-(void)test{
    NSLog(@"%@",[NSDate date]);
}

@end
