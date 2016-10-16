//
//  CYTextSetter.h
//  1225CoreText
//
//  Created by ChuckonYin on 15/12/25.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CoreTextContentType){
    CoreTextContentTypeImage = 0,
    CoreTextContentTypeString,
};
/**
 *  配置文字颜色、字体、行间距等信息
 */
@interface CYTextSetter : NSObject

@property (nonatomic, assign) CoreTextContentType type;

@property (nonatomic, copy) NSString *imgName;

@property (nonatomic, assign) CGFloat width, fontSize, lineSpace;

@property (nonatomic, strong) UIColor *color;

@end
