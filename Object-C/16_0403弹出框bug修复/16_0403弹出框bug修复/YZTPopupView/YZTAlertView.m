//
//  YZTAlertView.m
//  YZTPopupView
//
//  Created by Ralph Li on 9/6/15.
//  Copyright © 2015 LJC. All rights reserved.
//

#import "YZTAlertView.h"
#import "YZTPopupItem.h"
#import "MMPopupCategory.h"
#import "MMPopupDefine.h"
#import "UIColor+Hex.h"
//#import <Masonry/Masonry.h>

@interface YZTAlertView()

@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UILabel     *detailLabel;
@property (nonatomic, strong) UITextField *inputView;
@property (nonatomic, strong) UIView      *buttonView;

@property (nonatomic, strong) NSArray     *actionItems;

@property (nonatomic, copy) MMPopupInputHandler inputHandler;

@property (nonatomic, weak) UIView         *customView;


@end

@implementation YZTAlertView


- (instancetype) initWithCustomViewTitle:(NSString*)title
                              customView:(UIView *)customView
                                  detail:(NSString*)detail
                                   items:(NSArray*)items
                                 handler:(MMPopupInputHandler)inputHandler
{
    return [self initWithTitle:title customView:customView detail:detail items:items inputPlaceholder:nil inputHandler:inputHandler];
}

- (instancetype) initWithInputTitle:(NSString *)title
                             detail:(NSString *)detail
                        placeholder:(NSString *)inputPlaceholder
                            handler:(MMPopupInputHandler)inputHandler
{
    return [self initWithTitle:title customView:nil detail:detail items:@[] inputPlaceholder:inputPlaceholder inputHandler:inputHandler];
}

- (instancetype) initWithConfirmTitle:(NSString*)title
                               detail:(NSString*)detail
{
    MMAlertViewConfig *config = [MMAlertViewConfig globalConfig];
    
    NSArray *items =@[
                      MMItemMake(config.defaultTextOK, MMItemTypeHighlight, nil)
                      ];
    
    return [self initWithTitle:title detail:detail items:items];
}

- (instancetype) initWithTitle:(NSString*)title
                        detail:(NSString*)detail
                         items:(NSArray*)items
{
    return [self initWithTitle:title customView:nil detail:detail items:items inputPlaceholder:nil inputHandler:nil];
}

- (instancetype)initWithTitle:(NSString *)title
                    InputView:(UIView *)inputView
                       detail:(NSString *)detail
                        items:(NSArray *)items {
    self = [super init];
    if (self) {
        MMAlertViewConfig *config = [MMAlertViewConfig globalConfig];
        config.width = kScreenWidth;
        self.withKeyboard = YES;
        self.type = MMPopupTypeSheet;
        self.customView = inputView;
        self.actionItems = items;
        self.backgroundColor = config.backgroundColor;
        self.layer.borderWidth = MM_SPLIT_WIDTH;
        self.layer.borderColor = config.splitColor.CGColor;
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(config.width);
        }];
        [self setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisVertical];
        
        MASViewAttribute *lastAttribute = self.mas_top;
        if (title && title.length > 0 )
        {
            self.titleLabel = [UILabel new];
            [self addSubview:self.titleLabel];
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastAttribute).offset(config.innerMargin+10);
                make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, config.innerMargin, 0, config.innerMargin));
            }];
            self.titleLabel.textColor = config.titleColor;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            self.titleLabel.font = [UIFont systemFontOfSize:config.titleFontSize];
            self.titleLabel.numberOfLines = 0;
            self.titleLabel.backgroundColor = self.backgroundColor;
            self.titleLabel.text = title;
            
            lastAttribute = self.titleLabel.mas_bottom;
        }
        
        if (self.customView) {
            //            if (!title) {
            self.layer.borderWidth = 0.0;
            //            }
            [self addSubview:self.customView];
            CGSize customViewSize = self.customView.frame.size;
            
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(customViewSize.width);
            }];
            
            [self.customView mas_updateConstraints:^(MASConstraintMaker *make) {
                if (title) {
                    make.top.equalTo(lastAttribute).offset(config.innerMargin+5);
                }else{
                    make.top.equalTo(lastAttribute);
                }
                make.centerX.equalTo(self.mas_centerX);
                make.size.mas_equalTo(customViewSize);
            }];
            
            lastAttribute = self.customView.mas_bottom;
        }
        
        if (detail && detail.length > 0 )
        {
            self.detailLabel = [UILabel new];
            [self addSubview:self.detailLabel];
            [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastAttribute).offset(config.innerMargin);
                make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, config.innerMargin, 0, config.innerMargin));
            }];
            self.detailLabel.textColor = config.detailColor;
            self.detailLabel.lineBreakMode = NSLineBreakByCharWrapping;
            self.detailLabel.numberOfLines = 0;
            self.detailLabel.font = [UIFont systemFontOfSize:config.detailFontSize];
            self.detailLabel.backgroundColor = self.backgroundColor;
            self.detailLabel.text = detail;
            
            // 多于一行居左显示
            NSDictionary *attribute = @{NSFontAttributeName:self.detailLabel.font};
            
            CGSize retSize = [self.detailLabel.text boundingRectWithSize:CGSizeMake(config.width, MAXFLOAT)
                                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                                              attributes:attribute
                                                                 context:nil].size;
            
            if (retSize.height > self.detailLabel.font.lineHeight){
                self.detailLabel.textAlignment = NSTextAlignmentLeft;
            }else{
                self.detailLabel.textAlignment = NSTextAlignmentCenter;
            }
            
            lastAttribute = self.detailLabel.mas_bottom;
        }
        if (self.actionItems && self.actionItems.count > 0) {

            for ( NSInteger i = 0 ; i < self.actionItems.count; ++i )
            {
                YZTPopupItem *item = self.actionItems[i];
                
                UIButton *btn = [UIButton mm_buttonWithTarget:self action:@selector(actionButton:)];
                [self addSubview:btn];
                btn.tag = i;
                [btn setTitle:item.title forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:14];
                if ([item.title isEqualToString:@"取消"]) {
                    [btn setTitleColor:[UIColor colorWithHex:0x9b9b9b] forState:UIControlStateNormal];
                }
                else{
                    [btn setTitleColor:[UIColor colorWithHex:0x4a90e2] forState:UIControlStateNormal];
                }
                if (i == 0) {
                    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.mas_equalTo(self.mas_top);
                        make.left.mas_equalTo(self.mas_left).offset(14);
                        make.centerY.mas_equalTo(self.titleLabel.mas_centerY);
                        make.width.mas_equalTo(80);
                    }];
                }
                else{
                    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
                    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.mas_equalTo(self.mas_top);
                        make.right.mas_equalTo(self.mas_right).offset(-14);
                        make.centerY.mas_equalTo(self.titleLabel.mas_centerY);
                        make.width.mas_equalTo(80);
                    }];
                }
             }
        }
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(lastAttribute).offset(config.innerMargin+16);
        }];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyTextChange:) name:UITextFieldTextDidChangeNotification object:nil];
    return self;
    
}


- (instancetype)initWithTitle:(NSString *)title
                   customView:(UIView *)customView
                       detail:(NSString *)detail
                        items:(NSArray *)items
             inputPlaceholder:(NSString *)inputPlaceholder
                 inputHandler:(MMPopupInputHandler)inputHandler
{
    self = [super init];
    
    if ( self )
    {
        //NSAssert((inputHandler ? YES : (items && items.count>0)), @"Could not find any items.");
        
        MMAlertViewConfig *config = [MMAlertViewConfig globalConfig];
        config.width = kScreenWidth;
//        config.buttonHeight = 40;
        self.type = MMPopupTypeSheet;
        self.withKeyboard = (inputHandler!=nil);
        
        self.customView = customView;

        self.inputHandler = inputHandler;
        self.actionItems = items;
        
//        self.layer.cornerRadius = config.cornerRadius;
//        self.clipsToBounds = YES;
        self.backgroundColor = config.backgroundColor;
        self.layer.borderWidth = MM_SPLIT_WIDTH;
        self.layer.borderColor = config.splitColor.CGColor;
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(config.width);
        }];
        [self setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisVertical];
        
        MASViewAttribute *lastAttribute = self.mas_top;
        if (title && title.length > 0 )
        {
            self.titleLabel = [UILabel new];
            [self addSubview:self.titleLabel];
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastAttribute).offset(config.innerMargin+10);
                make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, config.innerMargin, 0, config.innerMargin));
            }];
            self.titleLabel.textColor = config.titleColor;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            self.titleLabel.font = [UIFont systemFontOfSize:config.titleFontSize];
            self.titleLabel.numberOfLines = 0;
            self.titleLabel.backgroundColor = self.backgroundColor;
            self.titleLabel.text = title;
            
            lastAttribute = self.titleLabel.mas_bottom;
        }
        
        if (self.customView) {
//            if (!title) {
                self.layer.borderWidth = 0.0;
//            }
            [self addSubview:self.customView];
            CGSize customViewSize = self.customView.frame.size;
            
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.width.mas_equalTo(customViewSize.width);
                make.width.mas_equalTo(kScreenWidth);
            }];
            
            [self.customView mas_updateConstraints:^(MASConstraintMaker *make) {
                if (title) {
                    make.top.equalTo(lastAttribute).offset(config.innerMargin+5);
                }else{
                    make.top.equalTo(lastAttribute);
                }
                make.centerX.equalTo(self.mas_centerX);
                make.size.mas_equalTo(customViewSize);
            }];
            
            for (UIView * view in self.customView.subviews) {
                if ([view isKindOfClass:[UITextField class]]||[view isKindOfClass:[UITextView class]]) {
                    self.withKeyboard = YES;
                    self.inputView = (UITextField *)view;
                    [view becomeFirstResponder];
                }
            }
            lastAttribute = self.customView.mas_bottom;
        }
        
        if (detail && detail.length > 0 )
        {
            self.detailLabel = [UILabel new];
            [self addSubview:self.detailLabel];
            [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastAttribute).offset(config.innerMargin);
                make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, config.innerMargin, 0, config.innerMargin));
            }];
            self.detailLabel.textColor = config.detailColor;
            self.detailLabel.lineBreakMode = NSLineBreakByCharWrapping;
            self.detailLabel.numberOfLines = 0;
            self.detailLabel.font = [UIFont systemFontOfSize:config.detailFontSize];
            self.detailLabel.backgroundColor = self.backgroundColor;
            self.detailLabel.text = detail;

            // 多于一行居左显示
            NSDictionary *attribute = @{NSFontAttributeName:self.detailLabel.font};
            
            CGSize retSize = [self.detailLabel.text boundingRectWithSize:CGSizeMake(config.width, MAXFLOAT)
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:attribute
                                                   context:nil].size;
            
            if (retSize.height > self.detailLabel.font.lineHeight){
                self.detailLabel.textAlignment = NSTextAlignmentLeft;
            }else{
                self.detailLabel.textAlignment = NSTextAlignmentCenter;
            }
            
            lastAttribute = self.detailLabel.mas_bottom;
            
            
            
            
        }
        
        if ( self.inputHandler )
        {
            if (!self.actionItems || self.actionItems.count == 0) {
                NSArray *inputItems =@[
                                       MMItemMake(config.defaultTextConfirm, MMItemTypeNormal, nil),
                                       MMItemMake(config.defaultTextCancel, MMItemTypeNormal, nil)
                                       ];
                self.actionItems = inputItems;
            }

            self.inputView = [UITextField new];
            [self.inputView becomeFirstResponder];
            [self addSubview:self.inputView];
            [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
                if (detail.length > 0) {
                    make.top.equalTo(lastAttribute).offset(10);
                }else{
                    make.top.equalTo(lastAttribute).offset(config.innerMargin+5);
                }
                make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
                make.height.mas_equalTo(40);
            }];
            self.inputView.backgroundColor = self.backgroundColor;
            self.inputView.layer.borderWidth = MM_SPLIT_WIDTH;
            self.inputView.layer.borderColor = config.splitColor.CGColor;
            self.inputView.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
            self.inputView.leftViewMode = UITextFieldViewModeAlways;
            self.inputView.clearButtonMode = UITextFieldViewModeWhileEditing;
            self.inputView.placeholder = inputPlaceholder;
            self.inputView.font = [UIFont systemFontOfSize:14];
            lastAttribute = self.inputView.mas_bottom;
            
        }
        if (self.actionItems && self.actionItems.count > 0) {
            if (self.withKeyboard) {
                
                for ( NSInteger i = 0 ; i < self.actionItems.count; ++i )
                {
                    YZTPopupItem *item = self.actionItems[i];
                    
                    UIButton *btn = [UIButton mm_buttonWithTarget:self action:@selector(actionButton:)];
                    [self addSubview:btn];
                    btn.tag = i;
                    [btn setTitle:item.title forState:UIControlStateNormal];
                    btn.titleLabel.font = [UIFont systemFontOfSize:14];
                    if ([item.title isEqualToString:@"取消"]) {
                        [btn setTitleColor:[UIColor colorWithHex:0x9b9b9b] forState:UIControlStateNormal];
                    }
                    else{
                        [btn setTitleColor:[UIColor colorWithHex:0x4a90e2] forState:UIControlStateNormal];
                    }
                    if (i == 0) {
                        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.top.mas_equalTo(self.mas_top);
                            make.left.mas_equalTo(self.mas_left).offset(14);
                            make.centerY.mas_equalTo(self.titleLabel.mas_centerY);
                            make.width.mas_equalTo(80);
                        }];
                    }
                    else{
                        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
                        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.top.mas_equalTo(self.mas_top);
                            make.right.mas_equalTo(self.mas_right).offset(-14);
                            make.centerY.mas_equalTo(self.titleLabel.mas_centerY);
                            make.width.mas_equalTo(80);
                        }];
                    }
                }
                [self mas_updateConstraints:^(MASConstraintMaker *make) {
                    
                    make.bottom.equalTo(lastAttribute).offset(config.innerMargin+16);
                }];

            }
            else{
                self.buttonView = [UIView new];
                [self addSubview:self.buttonView];
                [self.buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(lastAttribute).offset(config.innerMargin+5);
                    make.left.right.equalTo(self);
                }];
                
                __block UIButton *firstButton = nil;
                __block UIButton *lastButton = nil;
                for ( NSInteger i = self.actionItems.count-1; i >=0 ; i-- )
                {
                    YZTPopupItem *item = self.actionItems[i];
                    
                    UIButton *btn = [UIButton mm_buttonWithTarget:self action:@selector(actionButton:)];
                    [self.buttonView addSubview:btn];
                    btn.tag = i;
                    
                    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                        
                        if ( self.actionItems.count <= 2 )
                        {
                            /*
                             make.top.bottom.equalTo(self.buttonView);
                             make.height.mas_equalTo(config.buttonHeight);
                             */
                            //                        make.top.bottom.equalTo(self.buttonView);
                            make.height.mas_equalTo(config.buttonHeight);
                            make.left.equalTo(self.buttonView.mas_left).offset(config.innerMargin);
                            make.right.equalTo(self.buttonView.mas_right).offset(-config.innerMargin);
                            //                        make.width.mas_equalTo(kScreenWidth - 20);
                            if ( !firstButton )
                            {
                                firstButton = btn;
                                make.top.equalTo(self.buttonView);
                                //make.left.equalTo(self.buttonView.mas_left).offset(-MM_SPLIT_WIDTH);
                                //                            make.left.equalTo(self.buttonView.mas_left).offset(config.innerMargin);
                                
                            }
                            else
                            {
                                make.top.equalTo(firstButton.mas_bottom).offset(10);
                                make.bottom.equalTo(self.buttonView.mas_bottom).offset(MM_SPLIT_WIDTH);
                                //make.left.equalTo(lastButton.mas_right).offset(-MM_SPLIT_WIDTH);
                                //                            make.left.equalTo(lastButton.mas_right).offset(11);
                                //                            make.width.equalTo(firstButton);
                            }
                        }
                        else
                        {
                            make.left.right.equalTo(self.buttonView);
                            make.height.mas_equalTo(config.buttonHeight);
                            
                            if ( !firstButton )
                            {
                                firstButton = btn;
                                make.top.equalTo(self.buttonView.mas_top).offset(-MM_SPLIT_WIDTH);
                            }
                            else
                            {
                                make.top.equalTo(lastButton.mas_bottom).offset(-MM_SPLIT_WIDTH);
                                make.width.equalTo(firstButton);
                            }
                        }
                        
                        lastButton = btn;
                    }];
                    //                [btn setBackgroundImage:[UIImage mm_imageWithColor:self.backgroundColor] forState:UIControlStateNormal];
                    //                [btn setBackgroundImage:[UIImage mm_imageWithColor:config.itemPressedColor] forState:UIControlStateHighlighted];
                    //                [btn setTitleColor:item.highlight?config.itemHighlightColor:config.itemNormalColor forState:UIControlStateNormal];
                    //                btn.layer.borderWidth = MM_SPLIT_WIDTH;
                    //                btn.layer.borderColor = config.splitColor.CGColor;
                    btn.titleLabel.font = (btn==self.actionItems.lastObject)?[UIFont boldSystemFontOfSize:config.buttonFontSize]:[UIFont systemFontOfSize:config.buttonFontSize];
                    
                    // for YZTPopView
                    //                if (self.actionItems.count <= 2) {
                    //                    btn.autoresizingMask = UIViewAutoresizingFlexibleWidth;
                    //                    btn.titleLabel.font = [UIFont systemFontOfSize:16.0];
                    //                    btn.layer.borderWidth = 1.0;
                    //                    btn.layer.cornerRadius = 4.0;
                    //                    btn.layer.borderColor = config.itemPressedColor.CGColor;
                    //                    btn.clipsToBounds = YES;
                    //                    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
                    //                }
                    //
                    btn.clipsToBounds = YES;
                    btn.layer.cornerRadius = config.buttonHeight/2;
                    [btn setTitle:item.title forState:UIControlStateNormal];
                    if (![item.title isEqualToString:@"取消"]) {
                        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        [btn setBackgroundColor:[UIColor colorWithHex:0x2d4486]];
                        
                    }
                    else {
                        [btn setTitleColor:[UIColor colorWithHex:0x2d4486] forState:UIControlStateNormal];
                        [btn setBackgroundColor:[UIColor whiteColor]];
                        
                        btn.layer.borderColor = [UIColor colorWithHex:0x2d4486].CGColor;
                        btn.layer.borderWidth = 1;
                    }
                }
                [lastButton mas_updateConstraints:^(MASConstraintMaker *make) {
                    
                    make.bottom.equalTo(self.buttonView.mas_bottom).offset(MM_SPLIT_WIDTH);
                    //                if ( self.actionItems.count <= 2 )
                    //                {
                    //                    //make.right.equalTo(self.buttonView.mas_right).offset(MM_SPLIT_WIDTH);
                    ////                    make.right.equalTo(self.buttonView.mas_right).offset(-config.innerMargin);
                    //                }
                    //                else
                    //                {
                    //                    make.bottom.equalTo(self.buttonView.mas_bottom).offset(MM_SPLIT_WIDTH);
                    //                }
                    
                }];
                
                [self mas_updateConstraints:^(MASConstraintMaker *make) {
                    
                    //make.bottom.equalTo(self.buttonView.mas_bottom);
                    
                    if (self.actionItems.count <= 2) {
                        make.bottom.equalTo(self.buttonView.mas_bottom).offset(config.innerMargin);
                    }
                    else
                    {
                        make.bottom.equalTo(self.buttonView.mas_bottom);
                    }
                    
                }];
            }
            
        }
        else{
            // 无按钮的土司情况
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.width.mas_equalTo(config.toastWidth);
                make.bottom.equalTo(lastAttribute).offset(config.innerMargin);
            }];
        }

    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyTextChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)externalButtonAtion
{
    UIButton *fakeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    fakeBtn.tag = -1;
    [self actionButton:fakeBtn];
}

- (void)actionButton:(UIButton*)btn
{
    YZTPopupItem *item = self.actionItems[btn.tag];
    
    if ( item.disabled )
    {
        return;
    }
    
    if (self.returnHandler){
        if (self.returnHandler(btn.tag))
        {
            [self hide];
        }
        return;
    }
    /*
    if ( self.withKeyboard && (btn.tag==1) )
    {
        if ( self.inputView.text.length > 0 )
        {
            [self hide];
        }
    }
    else
    {
        [self hide];
    }*/
    
    if ( self.inputHandler )
    {
        if (self.inputHandler(btn.tag, self.inputView.text))
        {
            [self hide];
        }
        return;
    }
    else
    {
        if ( item.handler )
        {
            item.handler(btn.tag);
        }
        [self hide];
    }
}

- (void)notifyTextChange:(NSNotification *)n
{
    if ( self.maxInputLength == 0 )
    {
        return;
    }
    
    if ( n.object != self.inputView )
    {
        return;
    }
    
    UITextField *textField = self.inputView;
    
    NSString *toBeString = textField.text;

    UITextRange *selectedRange = [textField markedTextRange];
    //获取高亮部分
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position) {
        if (toBeString.length > self.maxInputLength) {
            textField.text = [toBeString mm_truncateByCharLength:self.maxInputLength];
        }
    }
}

- (void)showKeyboard
{
    [self.inputView becomeFirstResponder];
}

- (void)hideKeyboard
{
    [self.inputView resignFirstResponder];
}

@end


@interface MMAlertViewConfig()

@end

@implementation MMAlertViewConfig

+ (MMAlertViewConfig *)globalConfig
{
    static MMAlertViewConfig *config;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        config = [MMAlertViewConfig new];
        
    });
    
    return config;
}

- (instancetype)init
{
    self = [super init];
    
    if ( self )
    {
        self.width          = 275.0f;
        self.toastWidth      = 150.0f;
        self.buttonHeight   = 40.0f;
        self.innerMargin    = 20.0f;
        self.cornerRadius   = 5.0f;

        self.titleFontSize  = 16.0f;
        self.detailFontSize = 14.0f;
        self.buttonFontSize = 16.0f;
        
        self.backgroundColor    = RGB(255, 255, 255);
        self.titleColor         = RGB(74, 74, 74);
        self.detailColor        = RGB(155, 155, 155);
        self.splitColor         = RGB(204, 204, 204);

        self.itemNormalColor    = kGlobalColor;
        self.itemHighlightColor = RGB(231, 97, 83);
        self.itemPressedColor   = kGlobalColor;
        
        self.defaultTextOK      = @"好";
        self.defaultTextCancel  = @"取消";
        self.defaultTextConfirm = @"确定";
    }
    
    return self;
}

@end
