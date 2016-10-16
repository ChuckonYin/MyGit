//
//  Public.m
//  FoodStore
//
//  Created by liuguopan on 14-12-9.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import "Public.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "NetworkMonitor.h"
#import "netdb.h"

@implementation Public

+ (Public *)sharedPublic
{
    static Public *_sharedPublic = nil;
    if (nil == _sharedPublic) {
        _sharedPublic = [[Public alloc] init];
        _sharedPublic.userInfo = [[UserInfo alloc] init];
    }
    return _sharedPublic;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(networkChanged:)
                                                     name:Public_Network_Change object:nil];
        [NetworkMonitor getInstance];
    }
    return self;
}
- (CartInfo *)cartInfo
{
    if (_cartInfo == nil) {
        _cartInfo = [[CartInfo alloc] init];
        _cartInfo.userID = @"0";
        _cartInfo.foodsArray = [[NSMutableArray alloc] init];
        
    }
    return _cartInfo;
}
+ (NSString *)getMac
{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}
- (void)networkChanged:(NSNotification *)notify
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if ([self checkNetworkConnection]) {
        NetworkStatus state = (NetworkStatus)[[notify object] intValue];
        switch (state) {
            case kNotReachable: {
                LOG(@"Network status -- 局域网");
                self.networkState = NetworkisLAN;
                break;
            }
            case kReachableViaWWAN: {
                LOG(@"Network status -- 3G");
                self.networkState = NetworkisWWAN;
                break;
            }
            case kReachableViaWiFi: {
                LOG(@"Network status -- WiFi");
                self.networkState = NetworkisWiFi;
                break;
            }
            default:
                break;
        }
        
    } else {
        LOG(@"Network status -- 无网!");
        self.networkState = NotNetworkStatu;
    }
}

- (BOOL)checkNetworkConnection
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags) {
        //        NSLog(@"Error. Count not recover network <u><font color="\"red\"">reachability</font></u> flags\n");
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

@end
