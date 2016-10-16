//
//  CustomViewController.h
//  FoodStore
//
//  Created by ZhangShouC on 12/12/14.
//  Copyright (c) 2014 viewcreator3d. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@protocol CustomVCDelegate <NSObject>

@optional
- (void)locationWithData:(NSString *)place;

@end

@interface CustomViewController : UIViewController
<CLLocationManagerDelegate>

@property (nonatomic,weak) __weak id<CustomVCDelegate> delegate;

@property (nonatomic,strong) CLPlacemark *placemark;
@property (nonatomic,assign) CLLocationCoordinate2D coordinate;
@property (nonatomic,strong) NSString * lastPlace;
@property (nonatomic,strong) NSMutableArray * dataArr;
@property (nonatomic,assign) BOOL isOpen; //开启自动定位
@property (nonatomic,assign) BOOL isOn; // 开启推送
+ (CustomViewController *)sharedCustom;
- (void)initDataArr;
- (void)location;
- (void)locationHome;
- (void)addressWithPath:(NSString *)path;

@end








