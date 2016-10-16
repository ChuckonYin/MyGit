//
//  YZTCheckResultView.m
//  16_0324密码状态图表
//
//  Created by ChuckonYin on 16/3/24.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "YZTCheckResultView.h"

const CGFloat YZTCheckResultViewInfoDefaultFont = 12.0f;
const CGFloat YZTCheckResultViewInfoDefaultWidth = 150.0f;
const CGFloat YZTCheckResultViewImageDefaultHeight = 20.0f;
const CGFloat YZTCheckResultViewTriangleDefaultHeight = 6.0f;
@interface YZTCheckResultView()

@property (nonatomic, assign) CGPoint mCenter;

@property (nonatomic, assign) YZTCheckResultViewPopDirection direction;

@property (nonatomic, assign) YZTCheckResultViewResult result;

@property (nonatomic, strong) YZTCheckResultViewDetailView *detailView;

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation YZTCheckResultView

- (instancetype)initWithCenter:(CGPoint)center popDirection:(YZTCheckResultViewPopDirection)direction{
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor lightGrayColor];
        _mCenter = center;
        _direction = direction;
        _infoWidth = YZTCheckResultViewInfoDefaultWidth;
        [self initUI];
    }
    return self;
}

- (void)initUI{
    self.frame = CGRectMake(_mCenter.x-200, _mCenter.y-100, 400, 100 + YZTCheckResultViewImageDefaultHeight/2.0f);
    [self addSubview:self.detailView];
    [self addSubview:self.imageView];
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, YZTCheckResultViewImageDefaultHeight, YZTCheckResultViewImageDefaultHeight)];
        _imageView.center = CGPointMake(200, 100);
    }
    return _imageView;
}

- (void)popWithInfo:(NSString *)info resultType:(YZTCheckResultViewResult)result{
    switch (result) {
        case YZTCheckResultViewResultNormal: {
            self.imageView.image = [UIImage imageNamed:@"1"];
            break;
        }
        case YZTCheckResultViewResultRight: {
            self.imageView.image = [UIImage imageNamed:@"2"];
            break;
        }
        case YZTCheckResultViewResultFalse: {
            self.imageView.image = [UIImage imageNamed:@"3"];
            break;
        }
        case YZTCheckResultViewResultWarn: {
            self.imageView.image = [UIImage imageNamed:@"gantanhao"];
            break;
        }
    }
    [self.detailView refreshWithInfo:info];
}

- (YZTCheckResultViewDetailView *)detailView{
    if (!_detailView) {
        _detailView = [[YZTCheckResultViewDetailView alloc] initWithHostView:self];
        _detailView.hostView = self;
    }
    return _detailView;
}

- (void)dismiss{
    self.hidden = YES;
}

@end

@interface YZTCheckResultViewDetailView()

@property (nonatomic, assign) YZTCheckResultViewPopDirection direction;

@property (nonatomic, strong) UILabel *infoLab;

@property (nonatomic, strong) UIView *backCover;

@property (nonatomic, assign) CGFloat infoWidth;

@property (nonatomic, assign) CGFloat infoHeight;

@property (nonatomic, copy) NSString *info;

@property (nonatomic, assign) CGFloat infoLabBottomY;

@end

@implementation YZTCheckResultViewDetailView

- (instancetype)initWithHostView:(YZTCheckResultView *)hostView{
    if (self = [super initWithFrame:hostView.bounds]) {
        
        _hostView = hostView;
        
        self.backgroundColor = [UIColor clearColor];
        
        
        _backCover = [[UIView alloc] init];
        _backCover.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        _backCover.clipsToBounds = YES;
        _backCover.layer.cornerRadius = 4;
        [self addSubview:_backCover];
        
        _infoLabBottomY = 100 - YZTCheckResultViewImageDefaultHeight/2.0 - YZTCheckResultViewTriangleDefaultHeight;
        
        _infoLab = [[UILabel alloc] init];
        _infoLab.textColor = [UIColor whiteColor];
        _infoLab.textAlignment = NSTextAlignmentCenter;
        _infoLab.numberOfLines = 0;
        _infoLab.font = [UIFont systemFontOfSize:YZTCheckResultViewInfoDefaultFont];
        [self addSubview:_infoLab];
    }
    return self;
}

- (void)refreshWithInfo:(NSString *)iofo{
    _info = iofo;
    _infoWidth = YZTCheckResultViewInfoDefaultWidth;
    _infoHeight = [_info cr_heightForFont:[UIFont systemFontOfSize:YZTCheckResultViewInfoDefaultFont] width:_infoWidth];
    if (_infoHeight<[UIFont systemFontOfSize:YZTCheckResultViewInfoDefaultFont].ascender+4) {
        //只有一行,调整宽度
        [self adjustDetailInfoWidth:[_info cr_widthForFont:[UIFont systemFontOfSize:YZTCheckResultViewInfoDefaultFont]] height:_infoHeight];
    }
    else{
        //多行，调整宽度
        [self adjustDetailInfoWidth:_infoWidth height:_infoHeight];
    }
    _infoLab.text = iofo;
    self.hostView.hidden = NO;
    [self setNeedsDisplay];
    self.hostView.transform = CGAffineTransformMakeScale(1, 0);
    [UIView animateWithDuration:1 animations:^{
        self.hostView.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)adjustDetailInfoWidth:(CGFloat)width height:(CGFloat)height{
    switch (_hostView.direction) {
        case YZTCheckResultViewPopDirectionLeft: {
            _infoLab.frame = CGRectMake(200.0- width*8.0/10.0, _infoLabBottomY - height-7.5, width, height);
            break;
        }
        case YZTCheckResultViewPopDirectionCenter: {
            _infoLab.frame = CGRectMake(200.0- width*5.0/10.0, _infoLabBottomY - height-7.5, width, height);
            break;
        }
        case YZTCheckResultViewPopDirectionRight: {
            _infoLab.frame = CGRectMake(200.0- width*2.0/10.0, _infoLabBottomY - height-7.5, width, height);
            break;
        }
    }
    _backCover.frame = CGRectMake(_infoLab.frame.origin.x-15, _infoLab.frame.origin.y-7.5, _infoLab.frame.size.width + 30, _infoLab.frame.size.height+15);
}



- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(200.0, 100-YZTCheckResultViewImageDefaultHeight/2.0)];
    [path addLineToPoint:CGPointMake(200.0-5.0, 100-YZTCheckResultViewImageDefaultHeight/2.0 - YZTCheckResultViewTriangleDefaultHeight)];
    [path addLineToPoint:CGPointMake(200.0+5.0, 100-YZTCheckResultViewImageDefaultHeight/2.0 - YZTCheckResultViewTriangleDefaultHeight)];
    [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7] setFill];
    [path fill];
}

@end


@implementation NSString(YZTCheckResultView)

- (CGSize)cr_sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
        if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
            NSMutableDictionary *attr = [NSMutableDictionary new];
            attr[NSFontAttributeName] = font;
            if (lineBreakMode != NSLineBreakByWordWrapping) {
                NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
                paragraphStyle.lineBreakMode = lineBreakMode;
                attr[NSParagraphStyleAttributeName] = paragraphStyle;
            }
            CGRect rect = [self boundingRectWithSize:size
                                             options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                          attributes:attr context:nil];
            result = rect.size;
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
        }
    return result;
}

- (CGFloat)cr_widthForFont:(UIFont *)font {
    CGSize size = [self cr_sizeForFont:font size:CGSizeMake(HUGE, HUGE) mode:NSLineBreakByWordWrapping];
    return size.width;
}

- (CGFloat)cr_heightForFont:(UIFont *)font width:(CGFloat)width {
    CGSize size = [self cr_sizeForFont:font size:CGSizeMake(width, HUGE) mode:NSLineBreakByWordWrapping];
    return size.height;
}

@end














