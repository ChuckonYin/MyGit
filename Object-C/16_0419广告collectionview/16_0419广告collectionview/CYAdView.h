//
//  CYAdView.h
//  16_0419广告collectionview
//
//  Created by ChuckonYin on 16/4/19.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CYAdModel;
typedef void(^CYAdViewClickAction)(CYAdModel *);

typedef NS_ENUM(NSInteger, CYAdViewPosition){
    CYAdViewPositionVertically,
    CYAdViewPositionHorizontally,
};

@interface CYAdModel : NSObject

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, copy) NSString *imgUrl;

@end

@interface CYAdView : UIView

@property (nonatomic, strong) UIImage *placeholderImage;

- (instancetype)initWithFrame:(CGRect)frame scrollDirection:(CYAdViewPosition)position;

- (void)refreshWithImages:(NSArray <CYAdModel *>*)models clickAction:(CYAdViewClickAction)clickAction;

@end










