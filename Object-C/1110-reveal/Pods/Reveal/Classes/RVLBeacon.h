//
//  RVLBeacon.h
//  ShareLib
//
//  Created by Jay Lyerly on 6/9/14.
//  Copyright (c) 2014 StepLeader Digital. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLBeacon;
@class CLBeaconRegion;

@interface RVLBeacon : NSObject

@property (nonatomic, strong)   NSUUID   *proximityUUID;
@property (nonatomic, strong)   NSNumber *major;
@property (nonatomic, strong)   NSNumber *minor;

@property (nonatomic, copy)     NSString *proximity;
@property (nonatomic, strong)   NSNumber *accuracy;
@property (nonatomic, strong)   NSNumber *rssi;

@property (nonatomic, readonly) NSString *rvlUniqString;

- (instancetype) initWithBeacon:(CLBeacon *)beacon;
- (instancetype) initWithBeaconRegion:(CLBeaconRegion *)beaconRegion;

@end
