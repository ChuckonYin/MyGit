//
//  ViewControllerPresenter.h
//  MVP
//
//  Created by ChuckonYin on 15/12/23.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewControllerModel.h"

@protocol ViewControllerPresenterDelegate <NSObject>

- (void)ViewControllerPresenterUpdate;

@end

@interface ViewControllerPresenter : UIView

@property (nonatomic, assign) id delegate;

- (NSString*)getUpdate:(NSString*)str;

- (void)update;

@end
