//
//  QQSectionModel.h
//  1231QQ分栏
//
//  Created by ChuckonYin on 15/12/31.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQSectionModel : NSObject

@property (nonatomic, assign) BOOL isUnfold;

@property (nonatomic, copy) NSString *sectionTitle;

@property (nonatomic, strong) NSArray *friendArr;

@end
