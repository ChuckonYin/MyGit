//
//  CYFrameData.h
//  1225CoreText
//
//  Created by ChuckonYin on 15/12/25.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

@interface CYFrameData : NSObject

@property (nonatomic, assign) CTFrameRef ctFrame;

@property (nonatomic, assign) CGFloat height;

@end
