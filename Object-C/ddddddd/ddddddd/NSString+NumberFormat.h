//
//  NSString+NumberFormat.h
//  PANewToapAPP
//
//  Created by ChuckonYin on 16/1/18.
//  Copyright © 2016年 Gavin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NumberFormat)

////十万，保留四位
//@property (nonatomic, copy, readonly) NSString *formatHundredThousand;
////百万
//@property (nonatomic, copy, readonly) NSString *formatMillion;
////千万
//@property (nonatomic, copy, readonly) NSString *formatTenMillion;
////亿
//@property (nonatomic, copy, readonly) NSString *formatBillion;
//
////- (void)
//@property (nonatomic, copy, readonly) lowest

- (NSString*)formatHundredThousandDecimalLength:(NSInteger)length;

- (NSString*)formatMillionDecimalLength:(NSInteger)length;

@end
