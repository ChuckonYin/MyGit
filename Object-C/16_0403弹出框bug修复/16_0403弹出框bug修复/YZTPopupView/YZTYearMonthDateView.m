//
//  YZTYearMonthDateView.m
//  PANewToapAPP
//
//  Created by 李玉柱 on 16/1/13.
//  Copyright © 2016年 Gavin. All rights reserved.
//

#import "YZTYearMonthDateView.h"
#import "MMPopupCategory.h"
#import "MMPopupDefine.h"

@interface YZTYearMonthDateView()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSInteger _minYear;
    NSInteger _maxYear;
}

@property (nonatomic, strong) YZTYearMonthDateViewConfig *config;

@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) UIButton *btnCancel;
@property (nonatomic, strong) UIButton *btnConfirm;

// 记录每个Component选中的行
@property (nonatomic, strong) NSMutableArray *recordSelectedRows;

@property (nonatomic, strong) NSMutableArray *yearArray;
@property (nonatomic, strong) NSMutableArray *monthArray;

@end

@implementation YZTYearMonthDateView

- (instancetype)initWithMinYear:(NSInteger)minYear MaxYear:(NSInteger)maxYear
{
    self = [super init];
    
    if ( self )
    {
        self.type = MMPopupTypeSheet;
        self.recordSelectedRows = [[NSMutableArray alloc] initWithCapacity:2];
        _minYear = minYear;
        _maxYear = maxYear;
        
        self.yearArray = [NSMutableArray new];
        for (NSInteger i = _minYear; i <= _maxYear; i++) {
            [self.yearArray addObject:[NSNumber numberWithInteger:i]];
        }
        
        self.monthArray = [NSMutableArray new];
        for (NSInteger i = 1; i < 13; i++) {
            [self.monthArray addObject:[NSNumber numberWithInteger:i]];
        }
        
        
        for (int i = 0; i < 2; i++) {
            [self.recordSelectedRows addObject:[NSNumber numberWithInteger:0]];
        }
        
        self.config = [YZTYearMonthDateViewConfig globalConfig];
        
        self.backgroundColor = self.config.backgroundColor;
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
        }];
        
        [self setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisVertical];
        
        UIView *toolView = [UIView new];
        [self addSubview:toolView];
        [toolView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.mas_equalTo(self.config.toolViewHeight);
        }];
        toolView.backgroundColor = self.config.backgroundColor;
        
        self.btnCancel = [UIButton mm_buttonWithTarget:self action:@selector(cancleBtnAction:)];
        [self addSubview:self.btnCancel];
        [self.btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 50));
            make.centerY.equalTo(toolView);
            make.left.equalTo(toolView);
        }];
        self.btnCancel.titleLabel.font = [UIFont systemFontOfSize:self.config.buttonFontSize];
        [self.btnCancel setTitle:@"取消" forState:UIControlStateNormal];
        [self.btnCancel setTitleColor:self.config.buttonCancelTitleColor forState:UIControlStateNormal];
        
        self.btnConfirm = [UIButton mm_buttonWithTarget:self action:@selector(confirmBtnAction:)];
        [self addSubview:self.btnConfirm];
        [self.btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 50));
            make.centerY.equalTo(toolView);
            make.right.equalTo(toolView);
        }];
        self.btnConfirm.titleLabel.font = [UIFont systemFontOfSize:self.config.buttonFontSize];
        [self.btnConfirm setTitle:@"确定" forState:UIControlStateNormal];
        [self.btnConfirm setTitleColor:self.config.buttonConfirmTitleColor forState:UIControlStateNormal];
        
        UIView *splitView = [UIView new];
        [self addSubview:splitView];
        [splitView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(toolView.mas_bottom);
            make.left.right.equalTo(self);
            make.height.mas_equalTo(self.config.splitHeight);
        }];
        splitView.backgroundColor = self.config.splitColor;
        
        self.pickerView = [UIPickerView new];
        [self addSubview:self.pickerView];
        [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(self.config.toolViewHeight+self.config.splitHeight, 0, 0, 0));
        }];
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.pickerView);
        }];
    }
    
    return self;
}

- (void)showCompletionHandler
{
    if (_wantShowRows && _wantShowRows.count>0) {
        
        for (int i = 0; i < _wantShowRows.count; i++) {
            
            NSInteger wantRow = [_wantShowRows[i] integerValue];
            if (wantRow < 0) {
                wantRow = 0;
            }
            [self.pickerView selectRow:wantRow inComponent:i animated:YES];
            [self.recordSelectedRows replaceObjectAtIndex:i withObject:[NSNumber numberWithInteger:wantRow]];
        }
    }
}

- (void)confirmBtnAction:(id)sender
{
    if (self.dateConfirmHandler)
    {
        self.dateConfirmHandler(self.recordSelectedRows);
        [self hide];
    }
}

- (void)cancleBtnAction:(id)sender
{
    [self hide];
}

#pragma mark - UIPickerViewDelegate,UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.yearArray.count;
    }
    return self.monthArray.count;
}

/*
 - (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
 {
 return self.frame.size.width/self.pickerComponentsNum;
 }*/

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return self.config.pickerRowHeight;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return [NSString stringWithFormat:@"%lu年",[[self.yearArray objectAtIndex:row] integerValue]];
    }
    return [NSString stringWithFormat:@"%lu月",[[self.monthArray objectAtIndex:row] integerValue]];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self.recordSelectedRows replaceObjectAtIndex:component withObject:[NSNumber numberWithInteger:row]];
    
    if(_maxMonth) {
        NSInteger selectYear = [pickerView selectedRowInComponent:0] + _minYear;
        NSInteger selectMonth = [pickerView selectedRowInComponent:1] + 1;
        if(selectYear==_maxYear && selectMonth>[_maxMonth integerValue]) {
            [pickerView selectRow:[_maxMonth integerValue]-1 inComponent:1 animated:YES];
        }
    }
    
}




@end



@interface YZTYearMonthDateViewConfig()

@end

@implementation YZTYearMonthDateViewConfig

+ (YZTYearMonthDateViewConfig *)globalConfig
{
    static YZTYearMonthDateViewConfig *config;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        config = [YZTYearMonthDateViewConfig new];
        
    });
    
    return config;
}

- (instancetype)init
{
    self = [super init];
    
    if ( self )
    {
        self.toolViewHeight             = 59.0;
        self.pickerViewHeight           = 259.0;
        self.splitHeight                = 8.0;
        self.pickerRowHeight            = 49.0;
        
        self.titleFontSize              = 14.0;
        self.buttonFontSize             = 16.0;
        
        self.backgroundColor            = [UIColor whiteColor];
        self.titleColor                 = [UIColor lightGrayColor];
        self.splitColor                 = RGB(204, 204, 204);
        self.buttonCancelTitleColor     = RGB(155, 155, 155);
        self.buttonConfirmTitleColor    = RGB(74, 144, 226);
    }
    
    return self;
}
@end