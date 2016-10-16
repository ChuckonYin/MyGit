//
//  CLBeacon+RVLAdditions.h
//  IBeaconDemo
//
//  Created by Jay Lyerly on 5/21/14.
//  Copyright (c) 2014 StepLeader Digital. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface CLBeacon (RVLAdditions)

@property (nonatomic, readonly) NSString *rvl_uniqString;
// Note: this uniq id will only distinquish between beacons with different major/minor/uuids
// Two beacons with the same uuid/major/minor will NOT be recorded separately
// There is no programmatic way in iOS to dinstinguish two such beacons.

@end
