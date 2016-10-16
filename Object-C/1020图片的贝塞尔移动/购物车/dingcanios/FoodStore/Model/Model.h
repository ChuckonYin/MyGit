//
//  BaseInfo.h
//  FoodStore
//
//  Created by liuguopan on 14-12-9.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

@end


/********************       用户      ********************/

@interface UserInfo : Model     ///     用户信息

/**
 *  账号
 */
@property (nonatomic, strong) NSString *userID;

/**
 *  用户名
 */
@property (nonatomic, strong) NSString *userName;

/**
 *  昵称
 */
@property (nonatomic, strong) NSString *userNickName;

/**
 *  用户密码
 */
@property (nonatomic, strong) NSString *userPassword;

/**
 *  联系电话
 */
@property (nonatomic, strong) NSString *userTel;

/**
 *  邮箱
 */
@property (nonatomic, strong) NSString *userEmail;

/**
 *  性别
 */
@property (nonatomic, strong) NSString *userSex;

/**
 *  账户余额
 */
@property (nonatomic, assign) NSString * userMoney;

@end



@interface AddressInfo : Model

@property (nonatomic, strong) NSString * userID;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * addressID;
@property (nonatomic, strong) NSString * address;
@property (nonatomic, strong) NSString * tel;
@property (nonatomic, assign, getter = isSeclecte) BOOL selected;

@end


/********************       餐厅      ********************/

@interface RestaurInfo : Model

/**
 *  用户账号
 */
@property (nonatomic, strong) NSString *userID;

/**
 *  餐厅ID
 */
@property (nonatomic, strong) NSString *restaurID;

/**
 *  餐厅名称
 */
@property (nonatomic, strong) NSString *restaurName;

/**
 *  餐厅图标
 */
@property (nonatomic, strong) NSString *restaurIcon;

/**
 *  评价星级
 */
@property (nonatomic, assign) int stars;

/**
 *  评论数
 */
@property (nonatomic, strong) NSString *reviews;

/**
 *  月售额
 */
@property (nonatomic, strong) NSString *monthlySales;

/**
 *  人均消费
 */
@property (nonatomic, strong) NSString *percapita;

/**
 *  运费
 */
@property (nonatomic, strong) NSString *freight;

/**
 *  小费
 */
@property (nonatomic, strong) NSString *xiaofei;

/**
 *  起送价
 */
@property (nonatomic, strong) NSString * minPrice;

/**
 *  送餐用时
 */
@property (nonatomic, strong) NSString *freightTime;

/**
 *  菜系
 */
@property (nonatomic, strong) NSString *cuisine;

/**
 *  优惠/提醒
 */
@property (nonatomic, strong) NSString *couponTips;

/**
 *  营业时间
 */
@property (nonatomic, strong) NSString *shopHours;

/**
 *  餐厅坐标纬度
 */
@property (nonatomic, strong) NSString * latitude;

/**
 *  餐厅坐标经度
 */
@property (nonatomic, strong) NSString * longitude;

/**
 *  餐厅地址
 */
@property (nonatomic, strong) NSString *address;

/**
 *  餐厅简介
 */
@property (nonatomic, strong) NSString *brief;

/**
 *  餐厅公告
 */
@property (nonatomic, strong) NSString *gonggao;

/**
 *  餐厅风格
 */
@property (nonatomic, strong) NSString *style;

/**
 *  餐厅活动
 */
@property (nonatomic, strong) NSString *activities;

/**
 *  餐厅电话
 */
@property (nonatomic, strong) NSString *tel;

/**
 *  是否已收藏
 */
@property (nonatomic, assign, getter=isFavorite) BOOL favorite;

@end
typedef NS_OPTIONS(NSUInteger, RestaurOther) {
    RestaurOtherDefault                  = 0,
    RestaurOtherDistance                 = 1 << 0,
    RestaurOtherDistanceFromFarToNear    = 1 << 1,
    RestaurOtherStars                    = 1 << 2,
    RestaurOtherStarsFromLowToHigh       = 1 << 3,
    RestaurOtherPercapita                = 1 << 4,
    RestaurOtherPercapitaFromMoreToLess  = 1 << 5,
};

typedef NS_OPTIONS(NSUInteger, RestaurSort) {
    RestaurSortDefault                  = 0,
    RestaurSortDistance                 = 1 << 0,
    RestaurSortDistanceFromFarToNear    = 1 << 1,
    RestaurSortStars                    = 1 << 2,
    RestaurSortStarsFromLowToHigh       = 1 << 3,
    RestaurSortPercapita                = 1 << 4,
    RestaurSortPercapitaFromMoreToLess  = 1 << 5,
};

@interface RestaurOption : Model        ///     餐厅筛选排序选项

/**
 *  筛选条件 -- 菜系
 */
@property (nonatomic, assign) NSInteger cuisine;
/**
 *  筛选条件 -- 开发票
 */
@property (nonatomic, assign) NSInteger faPiao;

/**
 *  筛选条件 -- 最低评价星级（X星）
 */
@property (nonatomic, assign) NSInteger minStars;

/**
 *  筛选条件 -- 最远距离（< xKm）
 */
@property (nonatomic, assign) NSInteger maxDistanceLevel;

/**
 *  筛选条件 -- 最高人均消费（< $X）
 */
@property (nonatomic, assign) NSInteger maxPercapitaLevel;

/**
 *  排序方式
 */
@property (nonatomic, assign) RestaurSort sortOption;

@property (nonatomic, assign) RestaurOther otherOption;
@end



/********************       美食      ********************/

@interface FoodInfo : Model             ///     美食

/**
 *  用户账号
 */
@property (nonatomic, strong) NSString *userID;

/**
 *  所属餐厅的ID
 */
@property (nonatomic, strong) NSString *restaurID;

/**
 *  所属餐厅名称
 */
@property (nonatomic, strong) NSString *restaurName;

/**
 *  美食ID
 */
@property (nonatomic, strong) NSString *foodID;

/**
 *  美食名称
 */
@property (nonatomic, strong) NSString *foodName;

/**
 *  美食图标
 */
@property (nonatomic, strong) NSString *foodIcon;

/**
 *  单价
 */
@property (nonatomic, strong) NSString * price;

/**
 *  星级
 */
@property (nonatomic, assign) int stars;

/**
 *  销售额（X人点多）
 */
@property (nonatomic, strong) NSString * sales;

/**
 *  份数
 */
@property (nonatomic, assign) int  copies;

/**
 *  简介
 */
@property (nonatomic, strong) NSString * brief;

/**
 * 税收
 */
@property (nonatomic, strong) NSString * shuishou;

@property (nonatomic, strong) NSString * carID;

/**
 *  是否已收藏
 */
@property (nonatomic, assign, getter=isFavorite) BOOL favorite;

@end



/********************       购物车     ********************/

@interface CartInfo : Model

@property (nonatomic, strong) NSString * userID;
@property (nonatomic, strong) NSString * restaurID;
@property (nonatomic, assign) int totalCopies;
@property (nonatomic, assign) float totalPrice;
@property (nonatomic, strong) NSMutableArray *foodsArray;

@end

@interface CartFoodInfo : Model

@property (nonatomic, strong) NSString * userID;
@property (nonatomic, strong) NSString * restaurID;
@property (nonatomic, strong) NSString * carID;

@property (nonatomic, strong) NSString * foodID;
@property (nonatomic, strong) NSString * foodName;
@property (nonatomic, strong) NSString * price;
@property (nonatomic, strong) NSString * quantity;

@end

/********************       订单      ********************/

@interface OrderInfo : Model

@property (nonatomic, strong) NSString *foodName;

/**
 *  订单状态 0 - 已失效， 1 - 未付款， 2 - 已完成
 */
@property (nonatomic, assign) int state;

/**
 *  份数
 */
@property (nonatomic, assign) int copies;

/**
 *  单价
 */
@property (nonatomic, assign) float price;

/**
 *  订单id
 */
@property (nonatomic, strong) NSString *order_id;

/**
 *  订餐时间 add_time
 */
@property (nonatomic, strong) NSString *add_time;

@property (nonatomic,strong) NSString * order_sn;//订单号



@end

@interface OrderMainInfo : Model

@property (nonatomic,strong) NSString * order_id;
@property (nonatomic,strong) NSString * add_time;
@property (nonatomic,strong) NSString * delivery_time;
@property (nonatomic,strong) NSString * order_sn;//订单号
@property (nonatomic,strong) NSString * restaurName;
@property (nonatomic,strong) NSString * restaurTel;
@property (nonatomic,strong) NSString * driverTel;
@property (nonatomic,strong) NSString * tel;//买家
@property (nonatomic,strong) NSString * address;
@property (nonatomic,strong) NSString * num;//用餐人数
@property (nonatomic,strong) NSString * addInfor;
@property (nonatomic,strong) NSString * totalPrice;
@property (nonatomic,strong) NSString * restaurID;


@end

@interface PayInfo : Model

@property (nonatomic,strong) NSString * config;
@property (nonatomic,strong) NSString * enabled;
@property (nonatomic,strong) NSString * is_online;
@property (nonatomic,strong) NSString * payment_code;
@property (nonatomic,strong) NSString * payment_desc;
@property (nonatomic,strong) NSString * payment_id;
@property (nonatomic,strong) NSString * payment_name;
@property (nonatomic,strong) NSString * sort_order;
@property (nonatomic,strong) NSString * store_id;

@end

@interface PeisongInfo : Model

@property (nonatomic,strong) NSString * cod_regions;
@property (nonatomic,strong) NSString * enabled;
@property (nonatomic,strong) NSString * first_price;
@property (nonatomic,strong) NSString * shipping_desc;
@property (nonatomic,strong) NSString * shipping_id;
@property (nonatomic,strong) NSString * shipping_name;
@property (nonatomic,strong) NSString * step_price;
@property (nonatomic,strong) NSString * sort_order;
@property (nonatomic,strong) NSString * store_id;

@end



@interface SearchInfo : Model

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;

@end


@interface NetInfo : Model

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *idertifer;
@property (nonatomic, strong) NSData *data;

@end

@interface ModelPhoto : Model

@end
