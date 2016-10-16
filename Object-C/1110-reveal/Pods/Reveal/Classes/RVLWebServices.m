//
//  RVLWebServices.m
//  RevealSDK
//
//  Created by Sean Doherty on 1/7/15.
//  Copyright (c) 2015 StepLeader Digtial. All rights reserved.
//

#import <AdSupport/AdSupport.h>
#import <UIKit/UIKit.h>
#import "RVLWebServices.h"
#import "CompilerMacros.h"
#import "RVLDebugLog.h"
#import "CLBeacon+RVLAdditions.h"
#import "NSString+trim.h"
#import "CLPlacemark+stateUnAbbreviated.h"
#import "RVLBlueToothManager.h"
#import "RVLUDIDElement.h"

NSString * const kGodzillaDefaultsUrl = @"kGodzillaDefaultsUrl";
NSString * const kGodzillaDefaultsKey = @"kGodzillaDefaultsKey";

@implementation RVLWebServices
// Persist the info to access Godzilla for background operation
+(NSString *) apiKey{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kGodzillaDefaultsKey];
}

+(void) setApiKey:(NSString *)apiKey {
    [[NSUserDefaults standardUserDefaults] setObject:apiKey forKey:kGodzillaDefaultsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString *) apiUrl{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kGodzillaDefaultsUrl];
}

+(void) setApiUrl:(NSString *)apiUrl {
    [[NSUserDefaults standardUserDefaults] setObject:apiUrl forKey:kGodzillaDefaultsUrl];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSMutableDictionary*) getDefaultParameters {
    
    CLLocation *location = [RVLBlueToothManager sharedMgr].userLocation;
    CLLocationCoordinate2D coord = location.coordinate;
    NSTimeInterval coordAge = [[NSDate date] timeIntervalSinceDate:location.timestamp];
    NSUInteger coordAgeMS = (NSUInteger)(coordAge * pow(10,6));  // convert to milliseconds
    
    NSMutableDictionary *fullParameters = [@{
                                             @"os"                : @"ios",
                                             @"bluetooth_enabled" : @([RVLBlueToothManager sharedMgr].hasBluetooth),
                                             @"device_id"         : [RVLUDIDElement getUDID],
                                             @"app_version"       : [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"],
                                             @"location"          : @{
                                                     @"lat"  : @(coord.latitude),
                                                     @"long" : @(coord.longitude),
                                                     @"time" : @(coordAgeMS),
                                                     },
                                             } mutableCopy];
    if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
        //[DO] idfa is not guaranteed to return a valid string when device firsts starts up
        NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        if ([idfa rvl_isNotEmpty]) {
            fullParameters[@"idfa"] = idfa;
        }
    }
    return fullParameters;
}

+(void) registerDeviceWithResult:(void (^)(BOOL success, NSDictionary* result, NSError* error))result {
    NSDictionary *params = @{
                             @"version"           : [[UIDevice currentDevice] systemVersion],
                             @"locale"            : [[NSLocale currentLocale] localeIdentifier],
                             //@"bluetooth_version" : @"4",     // not available on iOS
                             @"bluetooth_enabled" : @([RVLBlueToothManager sharedMgr].hasBluetooth),
                             @"supports_ble"      : @([RVLBlueToothManager sharedMgr].hasBluetooth),
                             };
    NSMutableDictionary* fullParams = [RVLWebServices getDefaultParameters];
    [fullParams addEntriesFromDictionary:params];
    [RVLWebServices sendRequestToEndpoint:@"info" withParams:fullParams forResult:result];
}

+(void) sendNotificationOfBeacon:(RVLBeacon*) beacon
                          result:(void (^)(BOOL success, NSDictionary* result, NSError* error))result{
    NSMutableDictionary *params = [@{
                                     @"beacon_uuid"       : [[beacon proximityUUID] UUIDString],
                                     @"beacon_major"      : beacon.major,
                                     @"beacon_minor"      : beacon.minor,
                                     @"beacon_proximity"  : beacon.proximity,
                                     @"beacon_accuracy"   : beacon.accuracy,
                                     @"beacon_rssi"       : beacon.rssi,
                                     //@"beacon_mac"        : @"",  // not available on iOS
                                     } mutableCopy];
    
    CLPlacemark *addressPlacemark = [RVLBlueToothManager sharedMgr].userPlacemark;
    if (addressPlacemark){
        params[@"address"] = @{
                               @"street"  : addressPlacemark.addressDictionary[@"Street"] ?: @"",
                               @"city"    : addressPlacemark.locality                     ?: @"",
                               @"state"   : addressPlacemark.rvl_stateUnAbbreviated       ?: @"",
                               @"zip"     : addressPlacemark.postalCode                   ?: @"",
                               @"country" : addressPlacemark.country                      ?: @"",
                               };
    }
    NSMutableDictionary* fullParams = [RVLWebServices getDefaultParameters];
    [fullParams addEntriesFromDictionary:params];
    [RVLWebServices sendRequestToEndpoint:@"event/beacon" withParams:fullParams forResult:result];
}

+(void) sendRequestToEndpoint:(NSString*) endpoint withParams:(NSDictionary*) params forResult:(void (^)(BOOL success, NSDictionary* result, NSError* error))result {
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // These gyrations avoid a double slash (http://foo.com//api/info)
        // which gives godzilla the fits.
        NSURL *apiUrl = [NSURL URLWithString:self.apiUrl];
        NSString *methodPath = [NSString stringWithFormat:@"/api/v3/%@", endpoint];
        NSURL *reqUrl = [NSURL URLWithString:methodPath relativeToURL:apiUrl];
        
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:reqUrl];
        [urlRequest setValue:self.apiKey         forHTTPHeaderField:@"X-API-KEY"];
        [urlRequest setValue:@"application/json" forHTTPHeaderField:@"content-type"];
        
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setHTTPBody:[NSJSONSerialization dataWithJSONObject:params options:0 error:nil]];
        
        // TODO: [JL] This is mostly for debugging and can go when this settles down.
        NSString *requestString = [[NSString alloc] initWithData:urlRequest.HTTPBody encoding:NSUTF8StringEncoding];
        RVLLog(@"Request post to URL: %@ with data: %@", reqUrl.absoluteURL, requestString);
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:urlRequest
                                                completionHandler:^(NSData *data,
                                                                    NSURLResponse *response,
                                                                    NSError *error)
                                      {
                                          RVLLog(@"Response from server is %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                                          //if error or no data, return error to result
                                          if ([data length] == 0 || error) {
                                              result(NO,@{@"errors":@"Error requesting Reveal API"},error);
                                              return;
                                          }
                                          
                                          //build JSON for result
                                          NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data
                                                                                                   options:NSJSONReadingMutableContainers
                                                                                                     error:&error];
                                          
                                          //if json error, return error to result
                                          if (error){
                                              result(NO,@{@"errors":@"Error parsing response from Reveal API"},error);
                                              return;
                                          }
                                          
                                          //check json result for error array
                                          NSArray* errorsArray = objc_dynamic_cast(NSArray, [jsonDict objectForKey:@"errors"]);
                                          if (errorsArray && [errorsArray count] > 0){
                                              //if errors returned from server, return error to result
                                              result(NO,jsonDict,error);
                                              return;
                                          }
                                          
                                          //if no errors, return success to result
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              result(YES,jsonDict,error);
                                          });
                                      }];
        [task resume];
    });
}
@end
