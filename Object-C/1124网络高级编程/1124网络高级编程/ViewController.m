//
//  ViewController.m
//  1124网络高级编程
//
//  Created by ChuckonYin on 15/11/24.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"
#define filePath @"/apple/book"


@interface ViewController ()<NSURLConnectionDelegate,NSURLConnectionDataDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     *  NSMutableURLRequest
     */
    NSMutableURLRequest *rq = [[NSMutableURLRequest alloc] init];
    [rq setHTTPMethod:@"POST"];
    //通过内存
    [rq setHTTPBody:[@"尹" dataUsingEncoding:NSUTF8StringEncoding]];
    //通过路径
    [rq setHTTPBodyStream:[NSInputStream inputStreamWithFileAtPath:filePath]];
    [rq setHTTPBody:nil];
    rq.allowsCellularAccess = NO;//不允许蜂窝网络发送数据
    
    /**
     *  NSURLResponse
     */
    NSURLResponse *response = [[NSURLResponse alloc] init];
    NSURL *url =  response.URL;// 返回的url不一定与发送的相同
    NSString *type = response.MIMEType;//数据的mime类型
    NSInteger lenth = response.expectedContentLength;//返回内容大小
    NSString *ecodeName = response.textEncodingName;//数据源使用的文本编码名
    NSString *fileName = response.suggestedFilename;//文件名或是url、mime
    //NSHTTPURLResponse : NSURLResponse
    /**
     *  同步请求
     */
    //有些api默认调用同步请求。
    [NSString stringWithContentsOfURL:[NSURL URLWithString:filePath] encoding:NSStringEncodingConversionAllowLossy error:nil];//可以是本地或网络路径
    [NSURLConnection sendSynchronousRequest:rq returningResponse:&response error:nil];
    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
        //获取到了网络请求
    }
    //非本地数据不可用同步请求。
    //请求1G数据，在执行解析时可能占用的是2g数据。极易造成内存溢出

    /**
     *  队列式异步请求
     */
    rq.timeoutInterval = 30.0f;//超时30秒
    rq.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;//不缓存
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:rq queue:queue completionHandler:^(NSURLResponse * response, NSData * data, NSError * connectionError) {
        
    }];
    
    /**
     *  异步请求
     */
    NSURLConnection *urlCN = [NSURLConnection connectionWithRequest:rq delegate:self];
    //子线程的异步请求需要消息循环
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURLConnection *urlCN = [NSURLConnection connectionWithRequest:rq delegate:self];
        [urlCN start];
        [urlCN scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        [[NSRunLoop currentRunLoop] run];
        [urlCN start];
    });
    /**
     *  POST请求,更改服务器资源
     */
    NSDictionary *dict = @{@"jack":@22};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    rq.HTTPBody = jsonData;
    /**
     *  PUT请求,类似POST请求，向服务器添加资源
     */
    /**
     *  cookie 只针对http请求
     */
    NSArray *cookieArr = [NSHTTPCookie cookiesWithResponseHeaderFields:dict forURL:url];
    NSHTTPCookie *cookie = cookieArr[0];
    cookie.name;
    cookie.value;
    cookie.domain; //DNS域
    cookie.expiresDate; //cookie在客户端删除的时间
    cookie.sessionOnly;
    cookie.secure; //只会用于https
    cookie.comment; //说明目的注释值
    cookie.commentURL;//html文档说明目的文档路径
    cookie.HTTPOnly;//不与javascript共享cookie
    cookie.version;//cookie遵循的版本
    /**
     *  NSHTTPCookieStorage 存储cookie的单例，类似沙箱不会在应用间共享
     */
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyNever];//永不保存
    /**
     *  1\响应中获取cookie
     */
    [NSURLConnection sendAsynchronousRequest:rq queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSDictionary *cookieDict = [(NSHTTPURLResponse*)response allHeaderFields];
        NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:cookieDict forURL:url];
        for (NSHTTPCookie *cookie in cookies) {
            if ([cookie.name isEqualToString:@"yxk"]) {
                NSLog(@"找到了想要的cookie");
            }
        }
    }];
    /**
     *  2\删除cookie
     */
    for (NSHTTPCookie *cookie in [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
    /**
     *  请求头
     */
    NSString *clientNo = @"12345654355213458765";
//    NSArray *arrCookies = [NSArray arrayWithObjects: clientNo, nil];
    
    NSDictionary *dictCookieUId = [NSDictionary dictionaryWithObjectsAndKeys:@"clientNo", NSHTTPCookieName,
                                   
                                   clientNo, NSHTTPCookieValue,
                                   
                                   @"/", NSHTTPCookiePath,
                                   
                                   @"test.com", NSHTTPCookieDomain,
                                   
                                   nil];
    
    NSHTTPCookie *cook = [NSHTTPCookie cookieWithProperties:dictCookieUId];
    
    NSDictionary *dictCookies = [NSHTTPCookie requestHeaderFieldsWithCookies:@[cook]];
    
    
    id value = [dictCookies objectForKey:@"Cookie"];
    
    [rq setValue: [dictCookies objectForKey:@"Cookie"] forHTTPHeaderField: @"Cookie"];
    
//    UIWebView *web = [[UIWebView alloc] init];
    
    [rq setHTTPShouldHandleCookies:YES];
    [rq setValue:[NSString stringWithFormat:@"%@=%@", @"clientNo", clientNo] forHTTPHeaderField:@"Cookie"];
 
//    UILocalNotification
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
    //可能不被调用或调用多次
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
}
- (NSInputStream *)connection:(NSURLConnection *)connection needNewBodyStream:(NSURLRequest *)request{
    return [NSInputStream alloc];
}
-(void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    
}
-(NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse{
    return [NSCachedURLResponse new];
}


#pragma mark - NSURLConnectionDataDelegate




@end













