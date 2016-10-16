//
//  YZTDateView.m
//  PANewToapAPP
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 Gavin. All rights reserved.
//

#import "YZTDateView.h"
#import "MMPopupDefine.h"
#import "MMPopupCategory.h"

@interface YZTDateView()

@property (nonatomic, strong) YZTDateViewConfig *config;

@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, strong) UIButton *btnCancel;
@property (nonatomic, strong) UIButton *btnConfirm;

@end

@implementation YZTDateView

- (instancetype)initWithDateMode:(UIDatePickerMode)mode showDate:(NSDate *)showDate minDate:(NSDate *)minDate maxDate:(NSDate *)maxDate
{
    self = [super init];
    
    if ( self )
    {
        self.type = MMPopupTypeSheet;
        
        self.config = [YZTDateViewConfig globalConfig];
        
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
        
        self.datePicker = [UIDatePicker new];
        [self.datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];

        [self addSubview:self.datePicker];
        [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(self.config.toolViewHeight+self.config.splitHeight, 0, 0, 0));
        }];
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.datePicker);
        }];
        
        self.datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        if (mode) {
            self.datePicker.datePickerMode = mode;
        }
        if (minDate) {
            self.datePicker.minimumDate = minDate;
        }
        if (maxDate) {
            self.datePicker.maximumDate = maxDate;
        }
        if (showDate) {
            [self.datePicker setDate:showDate];
        }
    }
    
    return self;
}

- (void)confirmBtnAction:(id)sender
{
    if (self.confirmHandler)
    {
        self.confirmHandler(self.datePicker.date);
    }
    [self hide];
}

- (void)cancleBtnAction:(id)sender
{
    [self hide];
}

- (void)datePickerValueChanged:(UIDatePicker *)datePicker {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"BaseDatePickerValueChanged" object:self.datePicker userInfo:@{@"selectedDate":self.datePicker.date}];
}

- (NSDate *)localDateConversion:(NSDate *)originalDate
{
    NSTimeZone *zone = nil;
    if (_isUTC0) {
        zone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    }
    else{
        zone = [NSTimeZone systemTimeZone];
    }
    
    NSInteger interval = [zone secondsFromGMTForDate: originalDate];
    NSDate *localeDate = [originalDate  dateByAddingTimeInterval: interval];
    return localeDate;
}

@end

@implementation YZTDateViewConfig

+ (YZTDateViewConfig *)globalConfig
{
    static YZTDateViewConfig *config;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        config = [YZTDateViewConfig new];
        
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
