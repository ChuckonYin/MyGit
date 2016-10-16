//
//  YZTPopButtun.m
//  PANewToapAPP
//
//  Created by ChuckonYin on 16/5/5.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "YZTPopMenu.h"
#import "NSString+YZT.h"
#import "UITableView+ReloadData.h"

const CGFloat cellHeight = 35;

@interface YZTPopMenu()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) CGFloat offX;
@property (nonatomic, strong) NSArray <NSString *>* titles;
@property (nonatomic, assign) CGPoint topLocation;
@property (nonatomic, assign) CGPoint fullCenter;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <NSString*>* imageNames;
@property (nonatomic, copy) void(^selectAction)(NSInteger);

@end

@implementation YZTPopMenu

+ (YZTPopMenu *)yzt_showOnView:(UIView *)superView
           topLocation:(CGPoint)topLocation
                titles:(NSArray<NSString*>*)titles
                images:(NSArray<NSString*>*)images
         horizontalOff:(CGFloat)off
          selectAction:(void(^)(NSInteger))selectAction{
    CGFloat maxWidth = 0;
    for (NSString *string in titles) {
        CGFloat width = [string yzt_textSize:[UIFont systemFontOfSize:15]].width;
        if (width>maxWidth) {
            maxWidth = width;
        }
    }
    CGRect frame = CGRectMake(topLocation.x-maxWidth/2.0, topLocation.y, maxWidth+28, cellHeight*titles.count+10.0);
    YZTPopMenu *popBtn = [[YZTPopMenu alloc] initWithFrame:frame
                      titles:titles
               horizontalOff:off];
    [superView addSubview:popBtn];
    popBtn.imageNames = images;
    popBtn.selectAction = selectAction;
    popBtn.topLocation = topLocation;
    popBtn.fullCenter = CGPointMake(CGRectGetMidX(frame) + off, CGRectGetMidY(frame));
    [popBtn show];
    return popBtn;
}

- (void)show{
    self.transform = CGAffineTransformMakeScale(0, 0);
    self.center = CGPointMake(self.topLocation.x-self.offX, self.topLocation.y);
    self.alpha = 0.0;
    WS(weakSelf)
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.transform = CGAffineTransformMakeScale(0.95, 0.95);
        weakSelf.center = weakSelf.fullCenter;
        weakSelf.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            weakSelf.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {
            
        }];
    }];
}

- (void)yzt_dismiss{
    self.transform = CGAffineTransformMakeScale(1.0, 1.0);
    self.center = self.fullCenter;
    self.alpha = 1.0;
    WS(weakSelf);
    [UIView animateWithDuration:0.4 animations:^{
//        weakSelf.transform = CGAffineTransformMakeScale(0, 0);
//        weakSelf.center = CGPointMake(weakSelf.topLocation.x-weakSelf.offX, weakSelf.topLocation.y);
        weakSelf.alpha = 0.0;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

- (void)dealloc{
    NSLog(@"dealloc");
}

- (id)initWithFrame:(CGRect)frame titles:(NSArray<NSString*>*)titles horizontalOff:(CGFloat)off{
    if (self = [super initWithFrame:frame]) {
        self.titles = titles;
        self.offX = off;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.tableView];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(CGRectGetMidX(self.bounds)-self.offX, 0)];
    [path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds)-self.offX-10.0/1.372, 12)];
    [path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds)-self.offX+10.0/1.372,12)];
    [path closePath];
    [[UIColor whiteColor] setFill];
    [path fill];
}

#pragma mark - set & get

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-10) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.layer.cornerRadius = 5.0f;
        _tableView.clipsToBounds = YES;
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.textLabel.font = ChineseFont(14);
        [cell setSeparatorOffLeft:0 andRight:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row<self.titles.count) {
        cell.textLabel.text = self.titles[indexPath.row];
    }
    if (indexPath.row<self.imageNames.count) {
        cell.imageView.image = [UIImage imageNamed:self.imageNames[indexPath.row]];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"________________%li", indexPath.row);
    if (_selectAction) {
        _selectAction(indexPath.row);
    }
}

@end
