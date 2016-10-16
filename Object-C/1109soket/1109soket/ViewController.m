//
//  ViewController.m
//  1109soket
//
//  Created by ChuckonYin on 15/11/9.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import <CocoaAsyncSocket.h>

@interface ViewController ()<AsyncSocketDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AsyncSocket *socket = [[AsyncSocket alloc] initWithDelegate:self];
    [socket connectToHost:@"www.baidu.com" onPort:80 error:nil];
    [socket readDataWithTimeout:3 tag:1];
    [socket writeData:[@"GET / HTTP/1.1\n\n" dataUsingEncoding:NSUTF8StringEncoding] withTimeout:3 tag:1];
    
    NSString *s = @"\U0001F30D"; //earth emoji,lenght 2 ,is wrong
    NSLog(@"%li",[s lengthOfBytesUsingEncoding:NSUTF32StringEncoding]/4);
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 30, 30)];
    [self.view addSubview:lab];
    lab.text = s;
    
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSLog(@"did read data : ");
    
}
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"did connect to host");
}

- (void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    NSLog(@"Disconnect");
}


@end



