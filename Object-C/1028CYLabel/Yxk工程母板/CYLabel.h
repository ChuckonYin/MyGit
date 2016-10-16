//
//  CYLabel.h
//  Yxk工程母板
//
//  Created by ChuckonYin on 15/10/22.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CYLabel;
typedef CYLabel*(^Block)(CGFloat f);

@interface CYLabel : UILabel

@property (nonatomic, copy) Block cy_Font;

//@property (nonatomic, copy) CYLabel*(^cy_Font)(CGFloat f);

@property (nonatomic, copy) CYLabel*(^cy_BgColor)(UIColor* b);

@property (nonatomic, copy) CYLabel*(^cy_TextAligment)(NSTextAlignment a);

@property (nonatomic, copy) CYLabel*(^cy_text)(NSString *t);

-(void)act;

-(void)test;

@end
