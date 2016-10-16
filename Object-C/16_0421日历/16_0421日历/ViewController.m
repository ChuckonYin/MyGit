//
//  ViewController.m
//  16_0421日历
//
//  Created by ChuckonYin on 16/4/21.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "ViewController.h"
#import "CalendarLayout.h"
#import "CalendarCell.h"
#import "CalendarModel.h"
#import "CalendarHeader.h"

#define kCount 100

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) CalendarLayout *layout;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadData];
    
    [self.view addSubview:self.collectionView];
}

- (void)loadData{
    _dataArray = [[NSMutableArray alloc] init];
    for (int i=0; i<kCount; i++) {
        CalendarModel *model = [[CalendarModel alloc] init];
        [_dataArray addObject:model];
        model.height = (CGFloat)(arc4random()%200);
        model.color = [UIColor colorWithRed:((CGFloat)(arc4random()%10))/10.0 green:((CGFloat)(arc4random()%10))/10.0 blue:((CGFloat)(arc4random()%10))/10.0 alpha:1];
    }
    self.layout.dataArray = _dataArray;
    NSLog(@"%@", _dataArray);
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.layout];
        [_collectionView registerClass:[CalendarCell class] forCellWithReuseIdentifier:@"cellid"];
        [_collectionView registerClass:[CalendarHeader class] forSupplementaryViewOfKind:@"topHeader" withReuseIdentifier:@"CalendarHeader"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

- (CalendarLayout *)layout{
    if (!_layout) {
        _layout = [[CalendarLayout alloc] init];
    }
    return _layout;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 && indexPath.section == 0) {
         UICollectionReusableView *v = [collectionView dequeueReusableSupplementaryViewOfKind:@"topHeader" withReuseIdentifier:@"CalendarHeader" forIndexPath:indexPath];
        return v;
    }
    return nil;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionLeft];
    NSLog(@"selected");
}

- (BOOL)collectionView:(UICollectionView *)collectionView canFocusItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


@end
