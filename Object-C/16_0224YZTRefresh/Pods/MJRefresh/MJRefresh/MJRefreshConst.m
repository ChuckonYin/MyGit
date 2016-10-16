//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
#import <UIKit/UIKit.h>

const CGFloat MJRefreshHeaderHeight = 35.0;
const CGFloat MJRefreshFooterHeight = 35.0;
const CGFloat MJRefreshFastAnimationDuration = 0.25;
const CGFloat MJRefreshSlowAnimationDuration = 0.4;

NSString *const MJRefreshKeyPathContentOffset = @"contentOffset";
NSString *const MJRefreshKeyPathContentInset = @"contentInset";
NSString *const MJRefreshKeyPathContentSize = @"contentSize";
NSString *const MJRefreshKeyPathPanState = @"state";

NSString *const MJRefreshHeaderLastUpdatedTimeKey = @"MJRefreshHeaderLastUpdatedTimeKey";

NSString *const MJRefreshHeaderIdleText = @"下拉刷新";
NSString *const MJRefreshHeaderPullingText = @"放手，是一种态度";
NSString *const MJRefreshHeaderRefreshingText = @"正在加载...";

NSString *const MJRefreshAutoFooterIdleText = @"点击或上拉加载更多";
NSString *const MJRefreshAutoFooterRefreshingText = @"正在加载...";
NSString *const MJRefreshAutoFooterNoMoreDataText = @"已显示全部";

NSString *const MJRefreshBackFooterIdleText = @"上拉可加载更多";
NSString *const MJRefreshBackFooterPullingText = @"放手，是一种态度";
NSString *const MJRefreshBackFooterRefreshingText = @"正在加载...";
NSString *const MJRefreshBackFooterNoMoreDataText = @"已显示全部";
