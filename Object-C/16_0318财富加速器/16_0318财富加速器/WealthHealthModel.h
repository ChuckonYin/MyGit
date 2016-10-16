//
//  WealthHealthModel.h
//  16_0318财富加速器
//
//  Created by ChuckonYin on 16/3/22.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WealthHealthType){
    WealthHealthTypeInvest = 0,
    WealthHealthTypeAbilityToRepay,
    WealthHealthTypeMobility,
    WealthHealthTypeInsurance
};


@interface WealthHealthModel : NSObject

@property (nonatomic, assign) WealthHealthType type;
/**
 *  用户情况，不同类型对应情况不同
 */
@property (nonatomic, assign) NSInteger state;
/**
 *  星级
 */
@property (nonatomic, assign) NSInteger level;

@property (nonatomic, copy) NSString *detailIofo;

@property (nonatomic, copy) NSString *buttunTitle;

@property (nonatomic, strong) UIColor *buttonColor;

@property (nonatomic, copy) NSString *targetCtrlName;

- (instancetype)initWithType:(WealthHealthType)type;

@end

@interface WealthHealthTypeInvestModel : WealthHealthModel
@end

@interface WealthHealthTypeAbilityToRepayModel : WealthHealthModel
@end

@interface WealthHealthTypeMobilityModel : WealthHealthModel
@end

@interface WealthHealthTypeInsuranceModel : WealthHealthModel
@end


