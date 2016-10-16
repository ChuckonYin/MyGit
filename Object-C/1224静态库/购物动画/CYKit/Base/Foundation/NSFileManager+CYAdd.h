//
//  NSFileManager+CYAdd.h
//  CYKitDemo
//
//  Created by ChuckonYin on 15/12/4.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NSFileManagerShare [NSFileManager defaultManager]
#define homePath NSHomeDirectory()
#define documentsPath [NSHomeDirectory() stringByAppendingPathComponent:@"documents"]
@interface NSFileManager (CYAdd)


@end
