//
//  CYFrameRef.h
//  1225CoreText
//
//  Created by ChuckonYin on 15/12/25.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYTextSetter.h"
#import "CYFrameData.h"
/**
 *  生成一个绘制命令，类似
 */
@interface CYFrameRef : NSObject

//解析任意对象
+ (NSAttributedString*)objcToAttributedString:(id)obj;

+ (CYFrameData*)parseAttributeSting:(NSAttributedString*)attrStr config:(CYTextSetter*)setter;

@end
