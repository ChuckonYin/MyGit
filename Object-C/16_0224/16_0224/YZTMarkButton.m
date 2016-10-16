//
//  YZTMarkButton.m
//  PANewToapAPP
//
//  Created by ChuckonYin on 16/2/24.
//  Copyright © 2016年 Gavin. All rights reserved.
//

//#import "YZTMarkButton.h"
//
//@interface YZTMarkButton()
//
//@property (nonatomic, strong) UILabel *textLabel;
//
//@property (nonatomic, strong) UIImageView *markImav;
//
//@property (nonatomic, assign) CGRect titleRect; //文本位置
//
//@property (nonatomic, assign) CGRect imageRect; //图片位置
//
//@end
//
//@implementation YZTMarkButton
//
//- (instancetype)initWithButtonFrame:(CGRect)frame textLocation:(MarkButtonTextLocation)textLoca imageLocation:(MarkButtonImageLocation)imageLoca textImageDistance:(CGFloat)distance{
//    if (self = [super initWithFrame:frame]) {
//        _textLocation = textLoca;
//        _imageLocation = imageLoca;
//        _textImageDistance = distance;
//    }
//    return self;
//}
//
//- (void)setNormalTitle:(NSString *)buttunTitle imageName:(NSString *)img{
//    self.buttunTitle = buttunTitle;
//    self.imageName = img;
//    [self creatCustomLabelAndImageView];
//}
//
//- (void)creatCustomLabelAndImageView{
//    _textLabel = [[UILabel alloc] initWithFrame:self.bounds];
//    _textLabel.text = self.buttunTitle;
//    CGFloat textWidth = _textLabel.font.ascender*self.buttunTitle.length;
//    switch (_textLocation) {
//        case MarkButtonTextLocationLeft: {
//            _textLabel.textAlignment = NSTextAlignmentLeft;
//            _titleRect = CGRectMake(0, 0, textWidth, self.bounds.size.height);
//            break;
//        }
//        case MarkButtonTextLocationMiddle: {
//            _textLabel.textAlignment = NSTextAlignmentCenter;
//            _titleRect = CGRectMake((self.bounds.size.width-textWidth)/2, 0, textWidth, self.bounds.size.height);
//            break;
//        }
//        case MarkButtonTextLocationRight: {
//            _textLabel.textAlignment = NSTextAlignmentRight;
//            _titleRect = CGRectMake(self.bounds.size.width-textWidth, 0, textWidth, self.bounds.size.height);
//            break;
//        }
//    }
////    switch (_imageLocation) {
////        case MarkButtonImageLocationLeft: {
////            _imageRect =
////            break;
////        }
////        case MarkButtonImageLocationMiddle: {
////            <#statement#>
////            break;
////        }
////        case MarkButtonImageLocationRight: {
////            <#statement#>
////            break;
////        }
////    }
//}
//
//#pragma mark - 截取父类空间的获取
//
//-(UILabel *)titleLabel{
//    return self.textLabel;
//}
//
//@end




