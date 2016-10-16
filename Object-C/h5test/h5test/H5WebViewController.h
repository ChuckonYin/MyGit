//
//  H5WebViewController.h
//  h5test
//
//  Created by ChuckonYin on 16/5/11.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class H5ServiceDelegate;

@interface H5WebViewController : UIViewController

- (id)initWithUrl:(id) url delegate:(H5ServiceDelegate *)delegate;

@end
