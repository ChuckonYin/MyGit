//
//  WealthHealthModel.m
//  16_0318财富加速器
//
//  Created by ChuckonYin on 16/3/22.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "WealthHealthModel.h"

@implementation WealthHealthModel

- (instancetype)initWithType:(WealthHealthType)type{
    WealthHealthModel *model = nil;
    switch (type) {
        case WealthHealthTypeInvest: {
            model = [[WealthHealthTypeInvestModel alloc] init];
            break;
        }
        case WealthHealthTypeAbilityToRepay: {
            model = [[WealthHealthTypeAbilityToRepayModel alloc] init];
            break;
        }
        case WealthHealthTypeMobility: {
            model = [[WealthHealthTypeMobilityModel alloc] init];
            break;
        }
        case WealthHealthTypeInsurance: {
            model = [[WealthHealthTypeInsuranceModel alloc] init];
            break;
        }
    }
    model.type = type;
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%@", key);
}

@end

@implementation WealthHealthTypeInvestModel

- (void)setState:(NSInteger)state{
    [super setState:state];
    self.detailIofo = @[@"您还没提供任何投资信息",
                @"帮您分析投资分布是否合理",
                @"您的风险偏好为成长型，当前投资可以优化",
                @"您有较多闲散资金，可适当增加投资获取收益"][state];
    self.buttunTitle = @[@"立即提供",
                     @"立即前往",
                     @"前往优化",
                     @"投资建议"][state];
    self.targetCtrlName = @[@"",@"",@"",@""][state];
}

@end

@implementation WealthHealthTypeAbilityToRepayModel

- (void)setState:(NSInteger)state{
    [super setState:state];
    self.detailIofo = @[@"您还没提供任何负债信息",
                @"您的负债率高于117%",
                @"您还没提供任何银行卡信息，无法计算负债率",
                @""][state];
    self.buttunTitle = @[@"立即提供",
                     @"查看详情",
                     @"立即提供",
                     @""][state];
    self.targetCtrlName = @[@"",
                        @"",
                        @"",
                        @""][state];
}

@end
@implementation WealthHealthTypeMobilityModel

- (void)setState:(NSInteger)state{
    self.detailIofo = @[@"您还没提供任何银行卡信息",
                @"您当前的月收入小于月支出",
                @"",
                @""][state];
    self.buttunTitle = @[@"立即提供",
                     @"查看详情",
                     @"",
                     @""][state];
    self.targetCtrlName = @[@"",
                        @"",
                        @"",
                        @""][state];
}

@end
@implementation WealthHealthTypeInsuranceModel

- (void)setState:(NSInteger)state{
    [super setState:state];
    self.detailIofo = @[@"您还没投保任何保险",
                @"您共投保x类保险，总保额xxx万元",
                @"",
                @""][state];
    self.buttunTitle = @[@"立即添加",
                     @"查看详情",
                     @"",
                     @""][state];
    self.targetCtrlName = @[@"",
                        @"",
                        @"",
                        @""][state];
}

@end














