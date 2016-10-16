//
//  UILabel+Associate.h
//  1120runtime添加属性
//
//  Created by ChuckonYin on 15/11/20.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Associate)

- (void)setIdentifier:(NSString*)newIdName;

- (NSString*)getIdentifer;

@end
