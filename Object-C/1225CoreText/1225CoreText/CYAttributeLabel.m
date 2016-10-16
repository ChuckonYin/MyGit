//
//  CYAttributeLabel.m
//  1225CoreText
//
//  Created by ChuckonYin on 15/12/25.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "CYAttributeLabel.h"
#import "CYFrameRef.h"
typedef void(^OutParam)(CYFrameData*data);
@interface CYAttributeLabel()
@property (nonatomic, strong, readonly) CYFrameData *data;
@end

@implementation CYAttributeLabel
-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    //排版文字信息
    if (_data) {
        CTFrameDraw(_data.ctFrame, context);
    }
    //排版图片信息
}

- (void)setObjcArr:(NSMutableArray *)objcArr
{
    [CYAttributeLabel getDataWithObjects:objcArr complete:^(CYFrameData *data) {
        _data = data;
    }];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _data.height);
    [self setNeedsDisplay];
}

+ (CGFloat)heightForObjcArr:(NSArray*)objcArr withWidth:(CGFloat)width 
{
    __block CGFloat height = 0;
    [self getDataWithObjects:objcArr complete:^(CYFrameData *data) {
        height = data.height;
    }];
    return height;
}

+ (void)getDataWithObjects:(NSArray*)objcArr complete:(OutParam)cb
{
    NSMutableAttributedString *muAttrSting = [NSMutableAttributedString new];
    for (id obj in objcArr) {
        [muAttrSting appendAttributedString:[CYFrameRef objcToAttributedString:obj]];
    }
    CYFrameData *data = [CYFrameRef parseAttributeSting:muAttrSting config:[[CYTextSetter alloc] init]];
    cb(data);
}

@end
