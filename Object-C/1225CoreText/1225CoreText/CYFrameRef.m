//
//  CYFrameRef.m
//  1225CoreText
//
//  Created by ChuckonYin on 15/12/25.
//  Copyright © 2015年 PingAn. All rights reserved.
//
#import "UIView+CYAdd.h"
#import "CYFrameRef.h"
#import <CoreText/CoreText.h>
#import "CYTextSetter.h"

@implementation CYFrameRef

+ (NSDictionary*)buildAnAttributes:(CYTextSetter*)setter
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.paragraphSpacing = 0.0f;
    paragraphStyle.lineSpacing = setter.lineSpace;//设置文字间距
    return @{NSForegroundColorAttributeName:arc4random()%2==0?[UIColor redColor]:[UIColor yellowColor],NSFontAttributeName:[UIFont systemFontOfSize:setter.fontSize ],NSParagraphStyleAttributeName:paragraphStyle};
}

//生成绘制数据
+ (CYFrameData*)parseAttributeSting:(NSAttributedString*)attrStr config:(CYTextSetter*)setter
{
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attrStr);
    
    CGSize tempSize = CGSizeMake(setter.width, CGFLOAT_MAX);
    CGSize realSize = CTFramesetterSuggestFrameSizeWithConstraints(frameSetter, CFRangeMake(0, 0), nil, tempSize, nil);
    CGFloat heiht = realSize.height;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, setter.width, heiht));
    
    CTFrameRef frameRef = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    
    CYFrameData *data = [[CYFrameData alloc] init];
    data.ctFrame = frameRef;
    data.height = heiht;
    return data;
}
//任意对象处理
+ (NSAttributedString*)objcToAttributedString:(id)obj{
    
    if ([obj isKindOfClass:[UIView class]]) {
        UIImage *img = [self imageShotAllLayer:[obj layer]];
        return [self imageToAttributeSting:img];
    }
    else if ([obj isKindOfClass:[UIImage class]]){
        return [self imageToAttributeSting:obj];
    }
    else if ([obj isKindOfClass:[NSString class]]){
        return [self stringToAttributeSting:obj];
    }
    else if ([obj isKindOfClass:[NSAttributedString class]]){
        return obj;
    }
    return nil;
}
//图片处理
+ (NSAttributedString*)imageToAttributeSting:(UIImage*)img
{
    return nil;
}

//字符串处理
+ (NSAttributedString*)stringToAttributeSting:(NSString*)text
{
    CYTextSetter *setter = [[CYTextSetter alloc] init];
    NSDictionary *attributes = [self buildAnAttributes:setter];
    NSAttributedString *attriText = [[NSAttributedString alloc] initWithString:text attributes:attributes];
    return attriText;
}

+ (UIImage *)imageShotAllLayer:(CALayer*)layer{
    UIGraphicsBeginImageContextWithOptions(layer.bounds.size, layer.opaque, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end







