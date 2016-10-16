//
//  CalendarLayout.m
//  16_0421日历
//
//  Created by ChuckonYin on 16/4/21.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "CalendarLayout.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define CalendarCellWidth kScreenWidth/4.0
NSString *const SupplementaryViewTopHeader = @"topHeader";

@implementation CalendarOneDayModel

- (void)reset{
    _currentHeight = 0;
}

@end

@interface CalendarLayout()

@property (nonatomic, assign) CGFloat ContentSizeHeight;

@end

@implementation CalendarLayout

- (instancetype)init{
    if (self = [super init]) {
        self.sevenDays = [NSMutableArray new];
        for (int i=0; i<7; i++) {
            CalendarOneDayModel *model = [[CalendarOneDayModel alloc] init];
            model.day = i;
            model.currentHeight = 0;
            [self.sevenDays addObject:model];
        }
    }
    return self;
}

- (CGSize)collectionViewContentSize{
    return CGSizeMake(kScreenWidth*7.0/4.0, self.ContentSizeHeight);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSLog(@"%@", NSStringFromCGRect(rect));
    NSMutableArray *muArray = [[NSMutableArray alloc] init];
    for (int i=0; i<[self.collectionView numberOfItemsInSection:0]; i++) {
        UICollectionViewLayoutAttributes *attr = [self cy_layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [muArray addObject:attr];
    }
    [muArray addObject:[self layoutAttributesForSupplementaryViewOfKind:SupplementaryViewTopHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]]];
    return muArray;
}

- (UICollectionViewLayoutAttributes *)cy_layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    [self.sevenDays makeObjectsPerformSelector:@selector(reset)];
    
    for (int i=0; i < indexPath.row; i++) {
        CalendarOneDayModel *minHeightModel = [self getMinHeightDay];
        minHeightModel.currentHeight += _dataArray[i].height;
    }
    
    CalendarOneDayModel *minHeightModel = [self getMinHeightDay];
    attr.frame = CGRectMake(minHeightModel.day*CalendarCellWidth, 100+minHeightModel.currentHeight, CalendarCellWidth, _dataArray[indexPath.row].height);
    
    [self getMinHeightDay].currentHeight += _dataArray[indexPath.row].height;
    
    self.ContentSizeHeight = [self getMaxHeightDay].currentHeight;
    
    return attr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    if ([elementKind isEqualToString:SupplementaryViewTopHeader]) {
        UICollectionViewLayoutAttributes *supplementaryAttri = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:SupplementaryViewTopHeader withIndexPath:indexPath];
        supplementaryAttri.frame = CGRectMake(0, 0, 10000, 100);
        return supplementaryAttri;
    }
    return nil;
}

- (CalendarOneDayModel *)getMinHeightDay{
    CalendarOneDayModel *minHeightDay = _sevenDays[0];
    for (int i=0; i<_sevenDays.count; i++) {
        if (_sevenDays[i].currentHeight<minHeightDay.currentHeight) {
            minHeightDay = _sevenDays[i];
        }
    }
    return minHeightDay;
}

- (CalendarOneDayModel *)getMaxHeightDay{
    CalendarOneDayModel *maxHeightDay = _sevenDays[0];
    for (int i=0; i<_sevenDays.count; i++) {
        if (_sevenDays[i].currentHeight>maxHeightDay.currentHeight) {
            maxHeightDay = _sevenDays[i];
        }
    }
    return maxHeightDay;
}

@end
