//
//  CLPlacemark+stateUnAbbreviated.m
//  ShareLib
//
//  Created by Jay Lyerly on 7/7/14.
//  Copyright (c) 2014 StepLeader Digital. All rights reserved.
//

#import "CLPlacemark+stateUnAbbreviated.h"



@implementation CLPlacemark (stateUnAbbreviated)

- (NSString *) rvl_stateUnAbbreviated {
    NSString *state = [self rvl_statemap][self.administrativeArea];
    // return the expanded text, unless it's nil, then fall back.
    return state ?: self.administrativeArea;
}

- (NSDictionary *) rvl_statemap{
    static NSDictionary *map;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        map = @{
           @"AL":@"Alabama",
           @"AK":@"Alaska",
           @"AZ":@"Arizona",
           @"AR":@"Arkansas",
           @"CA":@"California",
           @"CO":@"Colorado",
           @"CT":@"Connecticut",
           @"DE":@"Delaware",
           @"DC":@"District of Columbia",
           @"FL":@"Florida",
           @"GA":@"Georgia",
           @"HI":@"Hawaii",
           @"ID":@"Idaho",
           @"IL":@"Illinois",
           @"IN":@"Indiana",
           @"IA":@"Iowa",
           @"KS":@"Kansas",
           @"KY":@"Kentucky",
           @"LA":@"Louisiana",
           @"ME":@"Maine",
           @"MD":@"Maryland",
           @"MA":@"Massachusetts",
           @"MI":@"Michigan",
           @"MN":@"Minnesota",
           @"MS":@"Mississippi",
           @"MO":@"Missouri",
           @"MT":@"Montana",
           @"NE":@"Nebraska",
           @"NV":@"Nevada",
           @"NH":@"New Hampshire",
           @"NJ":@"New Jersey",
           @"NM":@"New Mexico",
           @"NY":@"New York",
           @"NC":@"North Carolina",
           @"ND":@"North Dakota",
           @"OH":@"Ohio",
           @"OK":@"Oklahoma",
           @"OR":@"Oregon",
           @"PA":@"Pennsylvania",
           @"RI":@"Rhode Island",
           @"SC":@"South Carolina",
           @"SD":@"South Dakota",
           @"TN":@"Tennessee",
           @"TX":@"Texas",
           @"UT":@"Utah",
           @"VT":@"Vermont",
           @"VA":@"Virginia",
           @"WA":@"Washington",
           @"WV":@"West Virginia",
           @"WI":@"Wisconsin",
           @"WY":@"Wyoming"
        };
    });

    return map;
}

@end
