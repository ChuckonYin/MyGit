//
//  YZTCheckSheetView.m
//  PANewToapAPP
//
//  Created by 李玉柱 on 16/1/6.
//  Copyright © 2016年 Gavin. All rights reserved.
//

#import "YZTCheckSheetView.h"
#import "YZTPopupItem.h"
#import "MMPopupCategory.h"
#import "MMPopupDefine.h"
#import "YZTPopupWindow.h"

@interface YZTCheckSheetView()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL    _hasNoIcon;
}

@property (nonatomic, assign) NSInteger               selectedIndex;
@property (nonatomic, strong) UITableView            *tableView;
@property (nonatomic, strong) NSMutableArray         *itemsInfo;
@property (nonatomic, strong) MMCheckSheetViewConfig *config;
@property (nonatomic, strong) UIView                 *backGroundView;
@property (nonatomic, strong) NSArray                *actionItems;

@end


NSString *const YZTPopCheckSheetTitle = @"YZTPopCheckSheetTitle";       // 标题
NSString *const YZTPopCheckSheetSubTitle = @"YZTPopCheckSheetSubTitle";    // 灰色标题
NSString *const YZTPopCheckSheetIconName = @"YZTPopCheckSheetIconName";    // icon图片名

@implementation YZTCheckSheetView

- (instancetype) initWithItemsInfo:(NSArray *)itemsInfo
                     selectedIndex:(NSInteger)selectedIndex
{
    self = [super init];
    
    if ( self )
    {
        self.config = [MMCheckSheetViewConfig globalConfig];
        self.actionItems = itemsInfo;
        self.type = MMPopupTypeSheet;
        
        YZTPopupWindow *popWindow = [YZTPopupWindow sharedWindow];
        popWindow.touchWildToHide = YES;
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
        }];
        [self setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisVertical];
        
        if (itemsInfo) {
            self.itemsInfo = [NSMutableArray arrayWithArray:itemsInfo];
            
        }
        if (selectedIndex) {
            self.selectedIndex = selectedIndex;
        }
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableView.rowHeight = self.config.tableRowHeight;
        self.tableView.showsVerticalScrollIndicator = NO;
        [self addSubview:self.tableView];
        
        if (itemsInfo.count <= 5) {
            [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
                make.height.mas_equalTo(self.config.tableRowHeight * itemsInfo.count);
            }];
            
        }
        else{
            [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
                make.height.mas_equalTo(self.config.tableRowHeight * 5);
            }];
            
        }
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.tableView.mas_bottom);
        }];
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        
    }
    
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemsInfo.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.itemsInfo) {
        id item = self.itemsInfo[indexPath.row];
        if (item) {
            
            static NSString *identifier = @"itemCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
                cell.textLabel.font = [UIFont systemFontOfSize:self.config.titleFontSize];
                cell.textLabel.textColor = self.config.titleColor;
                cell.detailTextLabel.font = [UIFont systemFontOfSize:self.config.subTitleFontSize];
                cell.detailTextLabel.textColor = self.config.subTitleColor;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                if ([item isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *itemDic = item;
                     NSString *iconName = itemDic[YZTPopCheckSheetIconName];
                    if (!iconName) {
                        _hasNoIcon = YES;
                    }
                }
                
                if ([item isKindOfClass:[NSString class]] || _hasNoIcon == YES) {
                    //让cell的分割线顶头
                    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
                        [cell setSeparatorInset:UIEdgeInsetsZero];
                    }
                    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
                        [cell setLayoutMargins:UIEdgeInsetsZero];
                    }
                    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
                        [cell setPreservesSuperviewLayoutMargins:NO];
                    }
                }
            }
            
            if ([item isKindOfClass:[NSDictionary class]]) {
                NSDictionary *itemDic = item;
                NSString *sheetTitle = itemDic[YZTPopCheckSheetTitle];
                NSString *subTitle = itemDic[YZTPopCheckSheetSubTitle];
                NSString *iconName = itemDic[YZTPopCheckSheetIconName];
                
                if (sheetTitle) {
                    cell.textLabel.text = sheetTitle;
                }
                if (subTitle) {
                    cell.detailTextLabel.text = subTitle;
                }
                if (iconName) {
                    cell.imageView.image = [UIImage imageNamed:iconName];
                }
            }
            
            if ([item isKindOfClass:[NSString class]]) {
                cell.textLabel.text = self.itemsInfo[indexPath.row];
            }
            
            if (indexPath.row == self.selectedIndex) {
                UIImageView *markView = [self getMarkImageView];
                cell.accessoryView = markView;
            }
            else{
                cell.accessoryView = UITableViewCellAccessoryNone;
            }
            
            return cell;
            
        }
    }
    return nil;
}

- (UIImageView *)getMarkImageView
{
    UIImage *image = [UIImage imageNamed:@"orangeCheckMark"];
    UIImageView *markView = [[UIImageView alloc] init];
    CGRect markFrame = CGRectMake(0.0, 0.0, image.size.width/2.0, image.size.height/2.0);
    markView.frame = markFrame;
    markView.image = image;
    markView.backgroundColor = [UIColor clearColor];
    
    return markView;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedIndex = indexPath.row;
    [self.tableView reloadData];
    self.checkSheetHander(indexPath.row);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hide];
    });
}



@end


@interface MMCheckSheetViewConfig()

@end

@implementation MMCheckSheetViewConfig

+ (MMCheckSheetViewConfig *)globalConfig
{
    static MMCheckSheetViewConfig *config;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        config = [MMCheckSheetViewConfig new];
        
    });
    
    return config;
}

- (instancetype)init
{
    self = [super init];
    
    if ( self )
    {
        self.tableRowHeight             = 59.0;
        
        self.titleFontSize              = 16.0;
        self.subTitleFontSize           = 14.0;
        
        self.backgroundColor            = [UIColor whiteColor];
        self.titleColor                 = RGB(74, 74, 74);
        self.subTitleColor              = RGB(155, 155, 155);
        self.tableColor                 = RGB(204, 204, 204);
    }
    
    return self;
}


@end
