//
//  YZTRightPickerView.m
//  PANewToapAPP
//
//  Created by 李玉柱 on 16/1/12.
//  Copyright © 2016年 Gavin. All rights reserved.
//

#import "YZTRightPickerView.h"
#import "MMPopupCategory.h"
#import "MMPopupDefine.h"

@interface YZTRightPickerView()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, strong) YZTRightPickerViewConfig *config;

@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) UIButton *btnCancel;
@property (nonatomic, strong) UIButton *btnConfirm;

@property (nonatomic, assign) NSInteger pickerComponentsNum;

@property (nonatomic, strong) NSMutableArray *titlesArr;
// 记录每个Component选中的行
@property (nonatomic, strong) NSMutableArray *recordSelectedRows;

@end

@implementation YZTRightPickerView

- (instancetype)initWithComponentsNumber:(NSInteger)countNum
{
    self = [super init];
    
    if ( self )
    {
        self.type = MMPopupTypeSheet;
        self.pickerComponentsNum = countNum;
        self.titlesArr = [[NSMutableArray alloc] initWithCapacity:self.pickerComponentsNum];
        self.recordSelectedRows = [[NSMutableArray alloc] initWithCapacity:self.pickerComponentsNum];
        for (int i = 0; i < self.pickerComponentsNum; i++) {
            
            NSMutableArray *rowstitleArr = [NSMutableArray new];
            [self.titlesArr addObject:rowstitleArr];
            
            [self.recordSelectedRows addObject:[NSNumber numberWithInteger:0]];
        }
        
        self.config = [YZTRightPickerViewConfig globalConfig];
        
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
         
//            for (NSInteger j = i+1; j < self.pickerComponentsNum; j++) {
//                [self.pickerView reloadComponent:j];
//            }
         
            for (NSInteger j = self.pickerComponentsNum-i; j >= 0; j--) {
                [self.pickerView reloadComponent:j];
            }
            
        }
        
        /*
        for (NSInteger i = _wantShowRows.count-1; i >= 0; i--) {
            NSInteger wantRow = [_wantShowRows[i] integerValue];
            if (wantRow < 0) {
                wantRow = 0;
            }
            [self.pickerView selectRow:wantRow inComponent:i animated:YES];
            [self.recordSelectedRows replaceObjectAtIndex:i withObject:[NSNumber numberWithInteger:wantRow]];
            
            for (NSInteger j = i-1; j >= 1; j--) {
                [self.pickerView reloadComponent:j];
            }
        }
        */
        
    }
}

- (void)confirmBtnAction:(id)sender
{
    if (self.pickerViewHandler)
    {
        NSMutableArray *selectedTitles = [[NSMutableArray alloc] init];
        /*
        for (int i = 0; i < self.pickerComponentsNum; i++) {
            
            NSString *title = [(NSArray *)self.titlesArr[i] objectAtIndex:[self.recordSelectedRows[i] integerValue]];
            
            [selectedTitles addObject:title];
        }
         */
        
        for (NSInteger i = self.pickerComponentsNum-1; i >= 0; i --) {
            NSString *title = [(NSArray *)self.titlesArr[i] objectAtIndex:[self.recordSelectedRows[i] integerValue]];
            [selectedTitles addObject:title];
        }
        
        NSMutableArray *reverseTitles = [[NSMutableArray alloc] initWithCapacity:selectedTitles.count];
        for (NSInteger i = selectedTitles.count-1; i >= 0; i--) {
            [reverseTitles addObject:selectedTitles[i]];
        }
        
        self.pickerViewHandler(self.recordSelectedRows, reverseTitles);
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
    return self.pickerComponentsNum;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (self.returnRowsBlock) {
        NSInteger number = self.returnRowsBlock(component,self.recordSelectedRows);
        NSMutableArray *rowTitlesArr = self.titlesArr[component];
        [rowTitlesArr removeAllObjects];
        for (int i = 0; i< number; i++) {
            [rowTitlesArr addObject:@""];
        }
        
        return number;
    }
    return 0;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return self.config.pickerRowHeight;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (self.returnRowTitleBlock) {
        
        NSString *title = self.returnRowTitleBlock(component,row,self.recordSelectedRows);
        
        [(NSMutableArray *)self.titlesArr[component] replaceObjectAtIndex:row withObject:title];
        
        return title;
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self.recordSelectedRows replaceObjectAtIndex:component withObject:[NSNumber numberWithInteger:row]];
    /*
    for (NSInteger i = component+1; i < self.pickerComponentsNum; i++) {
        [self.recordSelectedRows replaceObjectAtIndex:i withObject:[NSNumber numberWithInteger:0]];
        [pickerView reloadComponent:i];
        [pickerView selectRow:0 inComponent:i animated:YES];
    }
     */
    
    for (NSInteger i = component-1; i >= 0; i--) {
        [self.recordSelectedRows replaceObjectAtIndex:i withObject:[NSNumber numberWithInteger:0]];
        [pickerView reloadComponent:i];
        [pickerView selectRow:0 inComponent:i animated:YES];
    }
    
}

@end



@interface YZTRightPickerViewConfig()

@end

@implementation YZTRightPickerViewConfig

+ (YZTRightPickerViewConfig *)globalConfig
{
    static YZTRightPickerViewConfig *config;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        config = [YZTRightPickerViewConfig new];
        
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

