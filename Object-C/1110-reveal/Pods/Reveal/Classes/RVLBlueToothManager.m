//
//  RVLBlueToothManager.m
//  Reveal
//
//  Created by Jay Lyerly on 5/19/14.
//  Copyright (c) 2014 StepLeader Digital. All rights reserved.
//

#import "RVLBlueToothManager.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>
#import "CompilerMacros.h"
#import <UIKit/UIKit.h>
#import "RVLDebugLog.h"
#import "RVLWebServices.h"
#import "CLBeacon+RVLAdditions.h"
#import "Reveal.h"

@interface RVLBlueToothManager () <CBCentralManagerDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) CBCentralManager  *cbcManager;
@property (nonatomic, copy)   NSString          *status;
@property (nonatomic, strong) NSMutableArray    *statusBlocks;
@property (nonatomic, strong) NSMutableArray    *beaconRegions;
@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, strong) NSMutableArray    *beaconBlocks;
@property (nonatomic, strong) NSMutableArray    *regionBlocks;

@property (nonatomic, strong) NSMutableDictionary       *beaconLog;
@property (nonatomic, strong) NSMutableDictionary       *seenBeacons;
@property (nonatomic, assign) BOOL                      hasBluetooth;
@property (nonatomic, assign) BOOL                      enableGeocoder;
@property (nonatomic, assign) CLLocationCoordinate2D    userCoordinate;
@property (nonatomic, strong) CLLocation                *userLocation;
@property (nonatomic, strong) CLPlacemark               *userPlacemark;

@end

@implementation RVLBlueToothManager
static RVLBlueToothManager *_sharedInstance;

+ (RVLBlueToothManager *) sharedMgr {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[RVLBlueToothManager alloc] init];
    });
    
    return _sharedInstance;
}

- (instancetype) init {
    self = [super init];
    if (self){
        _status = @"....";
        _beaconLog = [ @{} mutableCopy ];
        _seenBeacons = [ @{} mutableCopy ];
        _beaconRegions = [ @[] mutableCopy ];
        _statusBlocks = [ @[] mutableCopy ];
        _regionBlocks = [ @[] mutableCopy ];
        _beaconBlocks = [ @[] mutableCopy ];
        _hasBluetooth = NO;
        _enableGeocoder = YES;
        [self performSelectorOnMainThread:@selector(setupLocationManager) withObject:nil waitUntilDone:YES];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationWillResignActive:)
                                                     name:UIApplicationWillResignActiveNotification
                                                   object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidBecomeActive:)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
    }
    return self;
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// stop doing address lookups in the background
- (void)applicationWillResignActive:(NSNotification *)notification {
    if (self.locationManager != nil) {
        [self.locationManager stopUpdatingLocation];
    }
}

- (void)applicationDidBecomeActive:(NSNotification *)notification {
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]){
        [self.locationManager requestAlwaysAuthorization];
    }
    [self.locationManager startUpdatingLocation];
}


- (void) setupLocationManager {
    // Must set up locationManager on main thread or no callbacks!
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = 100;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    self.locationManager.pausesLocationUpdatesAutomatically = NO;
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]){
        [self.locationManager requestAlwaysAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    self.userLocation = self.locationManager.location;
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    
    self.hasBluetooth = NO;
    switch (central.state) {
        case CBCentralManagerStateUnknown:
            self.status = @"Unknown";
            break;
        case CBCentralManagerStateResetting:
            self.status = @"Resetting";
            break;
        case CBCentralManagerStateUnsupported:
            self.status = @"Unsupported";
            break;
        case CBCentralManagerStateUnauthorized:
            self.status = @"Unauthorized";
            break;
        case CBCentralManagerStatePoweredOff:
            self.status = @"Off";
            break;
        case CBCentralManagerStatePoweredOn:
            self.status = @"On";
            self.hasBluetooth = YES;
            break;
        default:
            self.status = @"State failure!";
            break;
    }
    RVLLog(@"BT Central Manager did update state, new state is %@",self.status);
    for (RVLBlueToothStatusBlock block in self.statusBlocks){
        RVLLog(@"Calling status block %@",block);
        block(central.state);
    }
    if (! self.hasBluetooth){
        RVLLog(@"User doesn't have bluetooth, process empty beacon");
        // report no beacons in monitored regions if the user disables bluetooth
        for (CLBeaconRegion *bRegion in [self.locationManager monitoredRegions]){
            [self processBeacons:@[] forRegion:bRegion];
        }
        self.hasBluetooth = NO;
    }
}

- (void) addStatusBlock:(RVLBlueToothStatusBlock)block{
    [self.statusBlocks addObject:block];
    if (self.cbcManager == nil) {
        NSDictionary *btOptions = @{};
        
        if (CBCentralManagerOptionShowPowerAlertKey != nil){
            // Check that CBCentralManagerOptionShowPowerAlertKey is available b/c it's weakly linked
            // (docs say you have to explicitly compare to nil, can't do !CBCentralManagerOptionShowPowerAlertKey
            btOptions = @{ CBCentralManagerOptionShowPowerAlertKey:@NO };
        }
        
        _cbcManager = [[CBCentralManager alloc] initWithDelegate:self
                                                           queue:nil
                                                         options:btOptions];
    }
}

- (void) addBeaconBlock:(RVLBlueToothBeaconBlock)block{
    [self.beaconBlocks addObject:block];
}

- (void) addRegionBlock:(RVLBlueToothRegionBlock)block{
    [self.regionBlocks addObject:block];
}


- (void)addBeacon:(NSString *)beaconID {
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:beaconID];
    if (uuid){
        CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                          identifier:beaconID];
        beaconRegion.notifyEntryStateOnDisplay = YES;
        
        if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]){
            [self.locationManager requestAlwaysAuthorization];
        }
        [self.locationManager startMonitoringForRegion:beaconRegion];
        [self.beaconRegions addObject:beaconRegion];
        
        [self.locationManager requestStateForRegion:beaconRegion];
    }
}

- (void)locationManager:(CLLocationManager *)manager
monitoringDidFailForRegion:(CLRegion *)region
              withError:(NSError *)error {
    
}

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    [self processBeacons:beacons forRegion:region];
    
    NSMutableSet *oldBeacons = self.seenBeacons[region];
    if (! oldBeacons){
        oldBeacons = [NSMutableSet set];
        self.seenBeacons[region] = oldBeacons;
    }
    
    
    // Remove beacons in this region that have gone away
    BOOL lostBeacon;
    NSMutableArray *beaconsToRemove = [ @[] mutableCopy ];
    for (NSString *uniqId in oldBeacons){
        lostBeacon = YES;
        for (CLBeacon *beacon in beacons){
            if ([uniqId isEqualToString:beacon.rvl_uniqString]){
                lostBeacon = NO;
            }
        }
        if (lostBeacon){
            [beaconsToRemove addObject:uniqId]; // can't mutate oldBeacons while enumerating it
        }
    }
    for (NSString *uniqId in beaconsToRemove){
        [self.seenBeacons[region] removeObject:uniqId];
    }
    
    // log new beacons
    for (CLBeacon *beacon in beacons){
        if ([oldBeacons containsObject:beacon.rvl_uniqString]){
            // nothing to do if we've already seen this beacon
        }else{
            //If we have a new beacon, send it to the server
            [oldBeacons addObject:beacon.rvl_uniqString];
            RVLLog(@"Sending beacon found to Server: %@", beacon.rvl_uniqString);
            [RVLWebServices sendNotificationOfBeacon:[[RVLBeacon alloc] initWithBeacon:beacon] result:^(BOOL success, NSDictionary *result, NSError *error) {
                //If there was a failure, don't add beacon to "old" list, so that it will be sent again if it is found again
                if (success){
                    RVLLog(@"Beacon data sent successfully");
                    [Reveal sharedInstance].personas = objc_dynamic_cast(NSArray, [result objectForKey:@"personas"]);
                } else {
                    RVLLog(@"Beacon notification failed with error %@",error);
                    [oldBeacons removeObject:beacon.rvl_uniqString];
                }
            }];
        }
    }
}

- (void)processBeacons:(NSArray *)beacons forRegion:(CLBeaconRegion *)region{
    self.beaconLog[region] = [beacons copy];
    NSMutableArray *allBeacons = [ @[] mutableCopy ];
    for (NSArray *beaconArray in [self.beaconLog allValues]){
        [allBeacons addObjectsFromArray:beaconArray];
    }
    if (self.hasBluetooth){
        for (RVLBlueToothBeaconBlock block in self.beaconBlocks){
            block(allBeacons);
        }
    }
}


- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region {
    // This fires on app start up where locationManager:didEnterRegion does not
    
    CLBeaconRegion *beaconRegion = objc_dynamic_cast(CLBeaconRegion, region);
    if (state == CLRegionStateInside) {
        [self.locationManager startRangingBeaconsInRegion:beaconRegion];
        //self.beaconLog[region] = [NSMutableSet set];
        self.beaconLog[region] = [@[] mutableCopy];
        for (RVLBlueToothRegionBlock block in self.regionBlocks){
            block(region, YES);
        }
    }
    if (state == CLRegionStateOutside) {
        [self.locationManager stopRangingBeaconsInRegion:beaconRegion];
        [self processBeacons:@[] forRegion:beaconRegion];   // report 0 beacons for this region
        for (RVLBlueToothRegionBlock block in self.regionBlocks){
            block(region, NO);
        }

    }
}

- (void) shutdownMonitor {
    for (CLBeaconRegion *bRegion in self.locationManager.rangedRegions){
        [self.locationManager stopRangingBeaconsInRegion:bRegion];
    }
    for (CLRegion *region in self.locationManager.monitoredRegions){
        [self.locationManager stopMonitoringForRegion:region];
    }
    // FIXME: [JL] may need to clear self.beaconRegions, etc
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *newLocation = [locations lastObject];  // docs say most recent update is at the end
    
    self.userLocation = newLocation;
}

- (void)setUserLocation:(CLLocation *)userLocation {
    if (userLocation != nil) {
        _userLocation = userLocation;
        self.userCoordinate = userLocation.coordinate;
    }
}

- (void) setUserCoordinate:(CLLocationCoordinate2D)coordinate {
    _userCoordinate = coordinate;
    if (self.enableGeocoder){
        CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
        CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
        [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
            if(error){
                RVLLog(@"%@", [error localizedDescription]);
                return;
            }
            self.userPlacemark = objc_dynamic_cast(CLPlacemark, [placemarks firstObject]);
        }];
    }
}

@end
