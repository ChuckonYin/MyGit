//
//  MoreViewController.h
//  pageViewControllow
//
//  Created by 刘志刚 on 16/5/25.
//  Copyright © 2016年 刘志刚. All rights reserved.
//

#import "ViewController.h"

@interface MoreViewController : UIViewController<UIWebViewDelegate>
@property (nonatomic, retain) UIWebView *myWebView;
@property (nonatomic, retain) id dataObject;
@end
