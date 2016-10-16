//
//  CYFrameSet.h
//  1016CYCoreText
//
//  Created by ChuckonYin on 15/10/18.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "CYTextConfig.h"
#import "CoreTextData.h"

@interface CYFrameSet : NSObject

+ (CoreTextData*) parseContext:(NSString*)context config:(CYTextConfig*)config;

@end
