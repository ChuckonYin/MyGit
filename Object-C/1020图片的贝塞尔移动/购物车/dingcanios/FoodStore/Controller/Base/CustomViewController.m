//
//  CustomViewController.m
//  FoodStore
//
//  Created by ZhangShouC on 12/12/14.
//  Copyright (c) 2014 viewcreator3d. All rights reserved.
//

#import "CustomViewController.h"

@interface CustomViewController ()
{
    CLLocationManager *locationManager;
}
@end

@implementation CustomViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        self.isOpen = YES;
        [self initManager];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}
- (void)setIsOpen:(BOOL)isOpen
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:isOpen forKey:@"Loc_isOpen"];
    [ud synchronize];
}
- (BOOL)isOpen
{
    
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    return [ud boolForKey:@"Loc_isOpen"];
}
- (void)setIsOn:(BOOL)isOn
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:isOn forKey:@"Loc_isOn"];
    [ud synchronize];
}
- (BOOL)isOn
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    return [ud boolForKey:@"Loc_isOn"];
}
- (void)setDataArr:(NSMutableArray *)dataArr
{
    if (!dataArr) {
        dataArr = [[NSMutableArray alloc] initWithCapacity:0];
    }
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:dataArr forKey:@"Loc_dataArr"];
    [ud synchronize];
}
- (NSMutableArray *)dataArr
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    return [ud objectForKey:@"Loc_dataArr"];
}
- (void)initDataArr
{

    if (![_lastPlace isKindOfClass:[NSString class]]) {
        return;
    }
    for (NSString * path in self.dataArr) {
        if ([path isEqualToString:_lastPlace]) {
            return;
//            [self.dataArr removeObject:path];
        }
    }
    NSMutableArray * arr = [[NSMutableArray alloc] initWithCapacity:0];
    [arr addObject:_lastPlace];
    for (NSString * path in self.dataArr) {
        [arr addObject:path];
    }
    self.dataArr = arr;
}

- (void)initManager
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    if (IOS_VERSION >= 8.0) {
//        [self.locationManager requestAlwaysAuthorization];
    }
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    locationManager.distanceFilter = kCLDistanceFilterNone;
}
+ (CustomViewController *)sharedCustom
{
    static CustomViewController * custom;
    if (!custom) {
        custom = [[CustomViewController alloc] init];
    }
    return custom;
}
- (void)location
{
    if (NotNetworkStatu == [Public sharedPublic].networkState) {
        return;
    }
    if ([CLLocationManager locationServicesEnabled]) {
        [locationManager startUpdatingLocation];
    }
}
- (void)locationHome
{
    if (!self.isOpen) {
        if (self.dataArr.count == 0) {
            return;
        }
        [self addressWithPath:[self.dataArr firstObject]];
        if ([_delegate respondsToSelector:@selector(locationWithData:)]) {
            [_delegate locationWithData:_lastPlace];
        }
        return;
    }
    if ([CLLocationManager locationServicesEnabled]) {
        [locationManager startUpdatingLocation];
    }
}
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    [locationManager stopUpdatingLocation];
    if (newLocation.horizontalAccuracy == -1) {
        return;
    }
    NSLog(@"%@",newLocation.description);
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark *placemark = placemarks[0];
        if (placemark.location == _placemark.location) {
            return;
        }
        _placemark = placemark;
        _coordinate=placemark.location.coordinate;
        NSLog(@"%@",_placemark.addressDictionary[@"FormattedAddressLines"][0]);
        
        _lastPlace = _placemark.addressDictionary[@"FormattedAddressLines"][0];
        [self initDataArr];
        if ([_delegate respondsToSelector:@selector(locationWithData:)]) {
            [_delegate locationWithData:_lastPlace];
        }
        
//        NSString *strCoordinate=[NSString stringWithFormat:@"location 经度:%f \n纬度:%f",_coordinate.latitude,_coordinate.longitude];
//        NSLog(@"%@",strCoordinate);
//        NSLog(@"%@",placemark);
//        NSString * subLocality = placemark.subLocality? placemark.subLocality:@"";
//        NSString * thoroughfare = placemark.thoroughfare ? placemark.thoroughfare : @"";
//        NSString * place = [NSString stringWithFormat:@"%@%@",subLocality,thoroughfare];
//        if (place.length) {
//            _lastPlace = place;
//            [self initDataArr];
//            if ([_delegate respondsToSelector:@selector(locationWithData:)]) {
//                [_delegate locationWithData:_lastPlace];
//            }
//        }
//        NSLog(@"name:%@\n country:%@\n postalCode:%@\n ISOcountryCode:%@\n ocean:%@\n inlandWater:%@\n locality:%@\n subLocality:%@\n administrativeArea:%@\n subAdministrativeArea:%@\n thoroughfare:%@\n subThoroughfare:%@\n",
//              placemark.name,
//              placemark.country,
//              placemark.postalCode,
//              placemark.ISOcountryCode,
//              placemark.ocean,
//              placemark.inlandWater,
//              placemark.administrativeArea,
//              placemark.subAdministrativeArea,
//              placemark.locality,
//              placemark.subLocality,
//              placemark.thoroughfare,
//              placemark.subThoroughfare);
//        
        
    }];
    
    
}
- (void)addressWithPath:(NSString *)path
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:path completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark * placemark = placemarks[0];
        CLLocationCoordinate2D coordinate=placemark.location.coordinate;
        NSString *strCoordinate=[NSString stringWithFormat:@"经度:%3.5f \n纬度:%3.5f",coordinate.latitude,coordinate.longitude];
        NSLog(@"%@",strCoordinate);
        if (coordinate.latitude && coordinate.longitude) {
            _coordinate = coordinate;
            _lastPlace = path;
            [self initDataArr];
        }
        
    }];
}
//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
//{
//    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
//    [geocoder reverseGeocodeLocation:[locations lastObject] completionHandler:^(NSArray *placemarks, NSError *error) {
//        CLPlacemark *placemark = placemarks[0];
//        NSLog(@"%@",placemark);
//        NSString * subLocality = placemark.subLocality? placemark.subLocality:@"";
//        NSString * thoroughfare = placemark.thoroughfare ? placemark.thoroughfare : @"";
//        NSString * place = [NSString stringWithFormat:@"%@%@",subLocality,thoroughfare];
//        if (place.length) {
//            _lastPlace = place;
//            [self initDataArr];
//        }
//        NSLog(@"name:%@\n country:%@\n postalCode:%@\n ISOcountryCode:%@\n ocean:%@\n inlandWater:%@\n locality:%@\n subLocality:%@\n administrativeArea:%@\n subAdministrativeArea:%@\n thoroughfare:%@\n subThoroughfare:%@\n",
//            placemark.name,
//             placemark.country,
//           placemark.postalCode,
//            placemark.ISOcountryCode,
//              placemark.ocean,
//             placemark.inlandWater,
//              placemark.administrativeArea,
//            placemark.subAdministrativeArea,
//              placemark.locality,
//               placemark.subLocality,
//              placemark.thoroughfare,
//                  placemark.subThoroughfare);
//        if ([_delegate respondsToSelector:@selector(locationWithData:)]) {
//            [_delegate locationWithData:_lastPlace];
//        }
//    }];
//    [locationManager stopUpdatingLocation];
//}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [locationManager stopUpdatingLocation];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
