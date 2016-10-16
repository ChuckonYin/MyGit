//
//  RVLBeacon.m
//  ShareLib
//
//  Created by Jay Lyerly on 6/9/14.
//  Copyright (c) 2014 StepLeader Digital. All rights reserved.
//

#import "RVLBeacon.h"
#import <CoreLocation/CoreLocation.h>

@implementation RVLBeacon

- (instancetype) initWithUUID:(NSUUID *)uuid major:(NSNumber *)major minor:(NSNumber *)minor proximity:(NSInteger)proximity accuracy:(NSNumber *)accuracy rssi:(NSNumber *)rssi {
    self = [super init];
    if (self){
        _proximityUUID = uuid;
        
        _major = @9999;             // FIXME -- currently logging beacon regions with no major/minor specified.
        _minor = @9998;
        
        if (major) {
            _major = major;
        }
        if (minor) {
            _minor = minor;
        }
        
        _proximity = @[@"unknown", @"immediate", @"near", @"far"][proximity];
        _accuracy = accuracy;
        _rssi = rssi;
    }
    
    return self;
}


- (instancetype) initWithBeacon:(CLBeacon *)beacon {
    return [self initWithUUID:beacon.proximityUUID major:beacon.major minor:beacon.minor proximity:beacon.proximity accuracy:@(beacon.accuracy) rssi:@(beacon.rssi)];
}


- (instancetype) initWithBeaconRegion:(CLBeaconRegion *)beaconRegion{
    return [self initWithUUID:beaconRegion.proximityUUID major:beaconRegion.major minor:beaconRegion.minor proximity:0 accuracy:@(0) rssi:@(0)];
}

- (NSString *)rvlUniqString{
    return [NSString stringWithFormat:@"%@-%@-%@", self.major, self.minor, [self.proximityUUID UUIDString]];
}

@end
