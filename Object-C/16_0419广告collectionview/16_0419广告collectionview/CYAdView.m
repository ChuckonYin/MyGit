//
//  CYAdView.m
//  16_0419广告collectionview
//
//  Created by ChuckonYin on 16/4/19.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "CYAdView.h"

@implementation CYAdModel

@end

@interface CYAdView()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray <CYAdModel *>*dataArray;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@property (nonatomic, assign) CYAdViewPosition position;

@property (nonatomic, copy) CYAdViewClickAction clickAction;

@end

@implementation CYAdView

- (instancetype)initWithFrame:(CGRect)frame scrollDirection:(CYAdViewPosition)position{
    if (self = [super initWithFrame:frame]) {
        _position = position;
        [self addSubview:self.collectionView];
        self.backgroundColor = [UIColor colorWithRed:((CGFloat)(arc4random()%10))/10.0 green:((CGFloat)(arc4random()%10))/10.0 blue:((CGFloat)(arc4random()%10))/10.0 alpha:1];
    }
    return self;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.layout];
        _collectionView.backgroundColor = [UIColor lightGrayColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
        _collectionView.pagingEnabled = YES;
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.itemSize = self.bounds.size;
        _layout.scrollDirection = (UICollectionViewScrollDirection)_position;
        _layout.minimumInteritemSpacing = 0.0;
        _layout.minimumLineSpacing = 0.0;
    }
    return _layout;
}

#pragma mark - UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"cellid";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];
    cell.contentMode = UIViewContentModeScaleToFill;
    cell.layer.contents = (id)_dataArray[indexPath.row].image.CGImage;
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}

#pragma mark - UIScrollDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!_dataArray || _dataArray.count<=1) return;
    if (_position == CYAdViewPositionHorizontally) {
        if (scrollView.contentOffset.x > self.bounds.size.width*(_dataArray.count-1)) {
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        }
        
        else if (scrollView.contentOffset.x<self.bounds.size.width){
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_dataArray.count-1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        }
    }
    else{
        if (scrollView.contentOffset.y > self.bounds.size.height*(_dataArray.count-1)) {
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
        }
        
        else if (scrollView.contentOffset.y<self.bounds.size.height){
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_dataArray.count-1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
        }
    }
}

- (void)refreshWithImages:(NSArray<CYAdModel *> *)models clickAction:(CYAdViewClickAction)clickAction{
    _clickAction = clickAction;
    [self reConfigDataArray:models];
    [self resetSetBaseOnData];
    [self.collectionView reloadData];
}

- (void)reConfigDataArray:(NSArray<CYAdModel *>*)models{
    if (!models) return;
    if (models.count==1) {
        _dataArray = (NSMutableArray *)models;
    }
    else if(models.count>1){
        _dataArray = models.mutableCopy;
        [_dataArray insertObject:_dataArray[_dataArray.count-1] atIndex:0];
        [_dataArray insertObject:_dataArray[1] atIndex:_dataArray.count];
    }
    NSLog(@"%@", _dataArray);
}

- (void)resetSetBaseOnData{
    self.collectionView.scrollEnabled = _dataArray.count==1 ? NO : YES;
    
    
}

- (void)nextItem{
    
}

- (void)dealloc{
    _clickAction = nil;
}

@end
