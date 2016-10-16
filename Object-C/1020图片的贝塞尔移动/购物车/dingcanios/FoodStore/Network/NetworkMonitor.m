//
//  NetworkMonitor.m
//  SaffronClient
//
//  Created by Sam on 12-4-18.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "NetworkMonitor.h"

@implementation NetworkMonitor
@synthesize netStatus;

static NetworkMonitor *uniqueNetworkMonitor = nil;

+(id)getInstance
{
    @synchronized(self)
    {
        if (nil == uniqueNetworkMonitor)
        {
            // 唯一实例
            uniqueNetworkMonitor = [[NetworkMonitor alloc] init];
        }
    }
	return uniqueNetworkMonitor;
}

-(id)init
{
	if (self=[super init])
	{
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
		
		hostReach=[Reachability reachabilityWithHostName:NetworkMonitor_Host];//可以以多种形式初始化
//#if ! __has_feature(objc_arc)
#if !__has_feature(objc_arc) 
        [hostReach retain];
#endif
		[hostReach startNotifier];  //开始监听,会启动一个run loop
	}
	return self;
}

- (void) updateInterfaceWithReachability:(Reachability*) curReach

{
    //对连接改变做出响应的处理动作。
	NetworkStatus staus = [curReach currentReachabilityStatus];
	
	NSString *objSend = [NSString stringWithFormat:@"%i",staus];
	[[NSNotificationCenter defaultCenter] postNotificationName:Public_Network_Change
                                                        object:objSend];
}

- (void) reachabilityChanged: (NSNotification* )note
{
	Reachability* curReach = [note object];
	
	NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
	
	[self updateInterfaceWithReachability: curReach];
}

-(void)dealloc
{
    if (hostReach) {
#if !__has_feature(objc_arc)
        [hostReach release];
#endif
        hostReach = nil;
    }
#if !__has_feature(objc_arc)
    [super dealloc];
#endif
    
}

@end
