//
//  JSON.m
//  FoodStore
//
//  Created by liuguopan on 14-12-9.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import "JSON.h"
#import "Model.h"

@implementation JSON

+ (id)jsonParse:(NSData *)data
{
    if (nil != data
        && ![data isKindOfClass:[NSNull class]]) {
        NSError *jsonParseError;
        id obj = [NSJSONSerialization JSONObjectWithData:data
                                                 options:NSJSONReadingMutableContainers
                                                   error:&jsonParseError];
        
        if (jsonParseError) {
            LOG(jsonParseError);
            return nil;
        }
        return obj;
    }
    return nil;
}
+ (NSMutableArray *)getUser:(NSData *)data
{
    NSMutableArray * arr = [[NSMutableArray alloc] init];
    NSDictionary *dict = (NSDictionary *)[JSON jsonParse:data];
    if ([dict[@"status"] isEqualToNumber:@1]) {
        NSDictionary * dic = dict[@"info"];
        UserInfo * info = [[UserInfo alloc] init];
        info.userID = dic[@"userid"];
        info.userName = dic[@"username"];
        info.userPassword = dic[@"password"];
        info.userSex = dic[@"sex"];
        if ([dic[@"phone"] isKindOfClass:[NSString class]]) {
            info.userTel = dic[@"phone"];
        } else {
            info.userTel = @"";
        }
        if ([dic[@"email"] isKindOfClass:[NSString class]]) {
            info.userEmail = dic[@"email"];
        } else {
            info.userEmail = @"";
        }
        if ([dic[@"nickname"] isKindOfClass:[NSString class]]) {
            info.userNickName = dic[@"nickname"];
        } else {
            info.userNickName = @"";
        }
        if ([dic[@"user_money"] isKindOfClass:[NSString class]]) {
            info.userMoney = dic[@"frozen_money"];
        } else {
            info.userMoney = @"0";
        }
        [arr addObject:info];
    }
    
    return arr;
}
+ (NSMutableArray *)getMainOrder:(NSData *)data
{
    NSMutableArray * Arr = [[NSMutableArray alloc] init];
    NSDictionary *dic = (NSDictionary *)[JSON jsonParse:data];
    NSLog(@"bbbb%@",dic);
    OrderMainInfo * info = [[OrderMainInfo alloc] init];
    info.order_id = dic[@"order_id"];
    info.add_time = dic[@"add_time"];
    info.delivery_time = dic[@"delivery_time"];
    info.order_sn = dic[@"order_sn"];
//    info.restaurName = dic[@"seller_name"];
    info.restaurID = dic[@"store_id"];
    //        info.restaurTel = dic[@"extm"][@"order_id"];
    //        info.driverTel = dic[@"extm"][@"order_id"];
    if ([dic[@"extm"][@"phone_mob"] isKindOfClass:[NSString class]]) {
        info.tel = dic[@"extm"][@"phone_mob"];
    } else if ([dic[@"extm"][@"phone_tel"] isKindOfClass:[NSString class]]) {
        info.tel = dic[@"extm"][@"phone_tel"];
    }
    
    info.address = dic[@"extm"][@"address"];
    //        info.num = dic[@"extm"][@"order_id"];
    if ([dic[@"extension"] isKindOfClass:[NSString class]]) {
         info.addInfor = dic[@"extension"];
    }
   
    info.totalPrice = dic[@"order_amount"];
    
    [Arr addObject:info];
    
    return Arr;
}
+ (NSMutableArray *)getOrder:(NSData *)data
{
    NSMutableArray * Arr = [[NSMutableArray alloc] init];
    NSArray *dataArr = (NSArray *)[JSON jsonParse:data];
    for (NSDictionary * dic in dataArr) {
        CartFoodInfo * info = [[CartFoodInfo alloc] init];
        info.foodID = dic[@"goods_id"];
        info.foodName = dic[@"goods_name"];
        info.price = dic[@"price"];
        info.quantity = dic[@"quantity"];
        [Arr addObject:info];
    }
    return Arr;
}
+ (NSMutableArray *)getRestaurs:(NSData *)data
{
    NSDictionary *dataDict = (NSDictionary *)[JSON jsonParse:data];
    
   
    NSLog(@"%@",dataDict);
    if ([JSON isAvailableInfoDict:dataDict]) {

        NSArray *dataArray = dataDict[@"info"];
        if (dataArray.count) {
            NSMutableArray *resultArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in dataArray) {
                RestaurInfo *restaur = [[RestaurInfo alloc] init];
                restaur.restaurID = dict[@"store_id"];
                restaur.restaurName = dict[@"store_name"];
                restaur.restaurIcon = dict[@"store_logo"];
                restaur.favorite = [dict[@"is_collection"] isEqualToNumber:@1]?YES:NO;
                restaur.address = dict[@"address"];
                restaur.monthlySales = dict[@"sell_count"];
                restaur.tel = dict[@"tel"];
                restaur.stars = [dict[@"rank"] integerValue];
                restaur.reviews = dict[@"comment_count"];
                restaur.latitude = dict[@"latitude"];
                restaur.longitude = dict[@"longitude"];
                NSLog(@"%@",dict[@"rank"]);
//                if ([dict[@"description"] isKindOfClass:[NSString class]]) {
//                    restaur.brief = [self brief:dict[@"description"]];
//                }
                restaur.brief = dict[@"store_id"];
// /*
                if ([[dict[@"attr"] allObjects] count] < 5) {
                    [resultArray addObject:restaur];
                    break;
                }
                restaur.couponTips = dict[@"attr"][@"youhui"][0][@"attr_value"];
                restaur.shopHours = dict[@"attr"][@"yingye"][0][@"attr_value"];
                restaur.style = dict[@"attr"][@"fengge"][0][@"attr_value"];
                restaur.activities = dict[@"attr"][@"huodong"][0][@"attr_value"];
                restaur.freightTime = dict[@"attr"][@"pingjunsongdashijian"][0][@"attr_value"];
                restaur.percapita = dict[@"attr"][@"renjunjiage"][0][@"attr_value"];
                restaur.freight = dict[@"attr"][@"yunfei"][0][@"attr_value"];
                restaur.gonggao = dict[@"attr"][@"gonggao"][0][@"attr_value"];
                restaur.minPrice = dict[@"attr"][@"peisongtiaojian"][0][@"attr_value"];
                restaur.xiaofei = dict[@"attr"][@"xiaofei"][0][@"attr_value"];
                NSLog(@"%@",dict[@"attr"][@"qisong"][0][@"attr_value"]);
                NSMutableArray * Arr = [[NSMutableArray alloc] init];
                NSArray * arr = dict[@"attr"][@"caixi"];
                restaur.cuisine = dict[@"cate_name"];
                for (NSDictionary * d in arr) {
                    [Arr addObject:d[@"attr_value"]];
                }
                if (Arr.count > 1) {
                    for (int i = 1; i < Arr.count; i++) {
                        restaur.cuisine = [NSString stringWithFormat:@"%@ %@",restaur.cuisine,Arr[i]];
                    }
                }
                
                arr = dict[@"attr"][@"huodong"];
                [Arr removeAllObjects];
                for (NSDictionary * d in arr) {
                    [Arr addObject:d[@"attr_value"]];
                }
                if (Arr.count > 1) {
                    for (int i = 1; i < Arr.count; i++) {
                        restaur.activities = [NSString stringWithFormat:@"%@\n%@",restaur.activities,Arr[i]];
                    }
                }
//*/
                
                
                [resultArray addObject:restaur];
            }
            return resultArray;
        }
    }
    
    LOG(@"返回餐厅列表数据为nil！");
    return nil;
}

+ (NSString *)brief:(NSString *)string
{
    NSString * path = @"";
    NSArray * arr = [string componentsSeparatedByString:@"<"];
    for (int i = 0;i< arr.count;i++) {
        NSArray * a = [arr[i] componentsSeparatedByString:@">"];
        if (a.count>1) {
            path = [path stringByAppendingString:a[1]];
        }
    }
    path = [path stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    path = [path stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    path = [path stringByReplacingOccurrencesOfString:@"\t" withString:@""];

    return path;
}
+ (NSString *)getResturaAttr:(NSDictionary *)dict key:(NSString *)key
{
    NSArray *arr = [dict objectForKey:key];
    NSDictionary *attr = [arr objectAtIndex:0];
    return attr[@"attr_value"];
}

+ (NSMutableArray *)getFoods:(NSData *)data
{
    NSDictionary *datatDict = (NSDictionary *)[JSON jsonParse:data];
    NSLog(@"%@",datatDict);
    if ([JSON isAvailableInfoDict:datatDict]) {
        NSArray *dataArray = datatDict[@"info"];
        
        if (dataArray.count) {
            //LOG_FORMAT(@"Store dataDict %@", dataArray[0]);
            NSMutableArray *resultArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in dataArray) {
                FoodInfo *food = [[FoodInfo alloc] init];
                food.restaurID = dict[@"store_id"];
                food.foodID = dict[@"goods_id"];
                food.foodName = dict[@"goods_name"];
                food.favorite = [dict[@"is_collection"] isEqualToNumber:@1]?YES:NO;
                food.price = dict[@"price"];
                food.stars = [dict[@"rank"] integerValue];
                food.foodIcon = dict[@"default_image"];
                food.sales = [dict[@"good_count"] isKindOfClass:[NSString class]]?dict[@"good_count"]:@"0";
                food.shuishou = dict[@"shuishou"];
                food.brief = dict[@"description"];
                                
                [resultArray addObject:food];
            }
            return resultArray;
        }
    }
    LOG(@"返回美食列表数据为nil！");
    return nil;
}

+ (NSMutableArray *)getFoodsInShoppingCart:(NSData *)data
{
    NSDictionary *dataDict = (NSDictionary *)[JSON jsonParse:data];
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    if ([JSON isAvailableInfoDict:dataDict]) {
        NSArray *dataArray = dataDict[@"info"];
        if (dataArray.count) {
            for (NSDictionary *dict in dataArray) {
                CartFoodInfo *info = [[CartFoodInfo alloc] init];
                
                info.carID = dict[@"rec_id"];
                info.userID = dict[@"user_id"];
                info.restaurID = dict[@"store_id"];
                info.price = dict[@"price"];
                info.quantity = dict[@"quantity"];
                info.foodID = dict[@"goods_id"];
                info.foodName = dict[@"goods_name"];
                
                [resultArray addObject:info];
            }
//            return resultArray;
        }
    }
    return resultArray;
}

+ (NSMutableArray *)getSearchInfo:(NSData *)data
{
    NSDictionary *dataDict = (NSDictionary *)[JSON jsonParse:data];
    if (0 == [[dataDict objectForKey:@"status"] intValue]
        && [dataDict[@"message"] isEqualToString:@"ok"]) {
        NSArray *dataArray = dataDict[@"results"];
        if (dataArray.count) {
            NSMutableArray *resultArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in dataArray) {
                SearchInfo *searchInfo = [[SearchInfo alloc] init];
                searchInfo.name = dict[@"name"];
                searchInfo.address = dict[@"address"];
                [resultArray addObject:searchInfo];
            }
            return resultArray;
        }
    }
    return nil;
}
+ (NSMutableArray *)getPays:(NSData *)data
{
    NSArray *arr = (NSArray *)[JSON jsonParse:data];
    NSMutableArray * Arr = [[NSMutableArray alloc] init];
    if (arr && arr.count) {
        for (NSDictionary * dic in arr) {
            PayInfo * info = [[PayInfo alloc] init];
            info.config = dic[@"config"];
            info.enabled = dic[@"enabled"];
            info.is_online = dic[@"is_online"];
            info.payment_code = dic[@"payment_code"];
            info.payment_desc = dic[@"payment_desc"];
            info.payment_id = dic[@"payment_id"];
            info.payment_name = dic[@"payment_name"];
            info.sort_order = dic[@"sort_order"];
            info.store_id = dic[@"store_id"];

            [Arr addObject:info];
        }
    }
    
    return Arr;
}
+ (NSMutableArray *)getPeisong:(NSData *)data
{
    NSArray *arr = (NSArray *)[JSON jsonParse:data];
    NSMutableArray * Arr = [[NSMutableArray alloc] init];
    if (arr && arr.count) {
        for (NSDictionary * dic in arr) {
            PeisongInfo * info = [[PeisongInfo alloc] init];
            info.cod_regions = dic[@"cod_regions"];
            info.enabled = dic[@"enabled"];
            info.first_price = dic[@"first_price"];
            info.shipping_desc = dic[@"shipping_desc"];
            info.shipping_id = dic[@"shipping_id"];
            info.shipping_name = dic[@"shipping_name"];
            info.step_price = dic[@"step_price"];
            info.sort_order = dic[@"sort_order"];
            info.store_id = dic[@"store_id"];
            
            [Arr addObject:info];
        }
    }
    
    return Arr;

}
+ (BOOL)isAvailableInfoDict:(NSDictionary *)info
{
    if (info
        && info[@"info"]
        && ![info[@"info"] isKindOfClass:[NSNull class]]) {
        return YES;
    }
    return NO;
}

@end
