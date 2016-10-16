//
//  kInterfaceURL.h
//  FoodStore
//
//  Created by ZhangShouC on 1/12/15.
//  Copyright (c) 2015 viewcreator3d. All rights reserved.
//

#ifndef FoodStore_kInterfaceURL_h
#define FoodStore_kInterfaceURL_h

#define DIANCAN_URL        @"http://dingcan.viewcreator3d.cn"
#define DIANCAN_VIEW       DIANCAN_URL@"/index.php/Dy/View"
#define DIANCAN_VIEW1      DIANCAN_URL@"/index.php/Dy/View1"
#define DIANCAN_VIEW2      DIANCAN_URL@"/index.php/Dy/View2"
//登陆
#define DIANCAN_LOGIN      DIANCAN_VIEW@"/login"
//找回密码
#define DIANCAN_SEEK       DIANCAN_VIEW@"/seek"
//修改密码
#define DIANCAN_CHANGGE    DIANCAN_VIEW@"/changgepassword"
//注册
#define DIANCAN_REGISTER   DIANCAN_VIEW@"/register"
//获取用户信息
#define DIANCAN_USERDATA   DIANCAN_VIEW@"/userdata"
//修改用户信息
#define DIANCAN_USERSAVE   DIANCAN_VIEW@"/usersavedata"
//商品搜索
#define DIANCAN_SEARCH     DIANCAN_VIEW@"/goodssearch"
//商品信息
#define DIANCAN_GOODSDATA  DIANCAN_VIEW@"/goodsdata"
//店铺信息
#define DIANCAN_STOREDATA  DIANCAN_VIEW@"/storedata"
//根据地理位置获取店铺信息
#define DIANCAN_ADDR       DIANCAN_VIEW@"/addr_storedata"
//订单列表
#define DIANCAN_ORDER      DIANCAN_VIEW1@"/order"
//获取订单商品
#define DIANCAN_GOODS      DIANCAN_VIEW1@"/order_goods"
//修改订单状态
#define DIANCAN_EDIT_ORD   DIANCAN_VIEW1@"/edit_order"
/*
//申请会员卡
#define DIANCAN_ADD_CARD   DIANCAN_VIEW1@"/add_member_card"
//获取积分消费记录
#define DIANCAN_INTEGRAL   DIANCAN_VIEW1@"/integral"
 */
//获取购物车商品
#define DIANCAN_CAR        DIANCAN_VIEW1@"/car"
//更新购物车/删除购物车
#define DIANCAN_EDITCAR    DIANCAN_VIEW1@"/editcar"
//收货地址
#define DIANCAN_ADDRESS    DIANCAN_VIEW1@"/delivery_address"
//更新收货地址
#define DIANCAN_EDIT_ADDR  DIANCAN_VIEW1@"/edit_delivery_address"
//删除收货地址
#define DIANCAN_DEL_ADDR   DIANCAN_VIEW1@"/del_delivery_address"
//获取支付方式
#define DIANCAN_PARMENT    DIANCAN_VIEW1@"/payment"
//获取配送方式
#define DIANCAN_SHIPPING   DIANCAN_VIEW1@"/shipping"

#endif
