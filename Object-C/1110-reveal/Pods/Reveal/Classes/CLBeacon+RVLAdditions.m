//
//  CLBeacon+RVLAdditions.m
//  IBeaconDemo
//
//  Created by Jay Lyerly on 5/21/14.
//  Copyright (c) 2014 StepLeader Digital. All rights reserved.
//

#import "CLBeacon+RVLAdditions.h"

@implementation CLBeacon (RVLAdditions)

- (NSString *)rvl_uniqString{
    return [NSString stringWithFormat:@"%@-%@-%@", self.major, self.minor, [self.proximityUUID UUIDString]];
}

@end
