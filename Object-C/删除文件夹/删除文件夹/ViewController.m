//
//  ViewController.m
//  删除文件夹
//
//  Created by ChuckonYin on 16/2/17.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSFileManager *fm;

@property (nonatomic, strong) NSArray *array;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *rootPath = @"/Users/apple/paone_ios/PAToapAPPNew";
    
    NSString *text = @"'face_check_facetophone.imageset', 'face_check_slowdown.imageset', 'face_check_brightness.imageset', 'billSettingICON.imageset', 'credit_card_left_down.imageset', 'billEmailICON.imageset', 'eco_other_icon.imageset', 'eco_search_icon.imageset', 'eco_P2P_icon.imageset', 'guide_manager.imageset', 'guide_no_choose.imageset', 'guide_choose.imageset', 'assessmentResult(7).imageset', 'assessmentResult(2).imageset', 'assessmentResult(5).imageset', 'assessmentResult(4).imageset', 'assessmentResult(3).imageset', 'assessmentResult(1).imageset', 'assessmentResult(6).imageset', 'investment_result0.imageset', 'AccountlistImage9.imageset', 'alreadyAccountlistImage10.imageset', 'alreadyAccountlistImage1.imageset', 'alreadyAccountlistImage2.imageset', 'AccountlistImage12.imageset', 'alreadyAccountlistImage8.imageset', 'AccountlistImage8.imageset', 'alreadyAccountlistImage6.imageset', 'AccountlistImage6.imageset', 'AccountlistImage5.imageset', 'AccountlistImage4.imageset', 'AccountlistImage3.imageset', 'alreadyAccountlistImage9.imageset', 'alreadyAccountlistImage4.imageset', 'AccountlistImage10.imageset', 'alreadyAccountlistImage11.imageset', 'AccountlistImage11.imageset', 'alreadyAccountlistImage5.imageset', 'alreadyAccountlistImage7.imageset', 'alreadyAccountlistImage12.imageset', 'AccountlistImage2.imageset', 'AccountlistImage7.imageset', 'AccountlistImage1.imageset', 'alreadyAccountlistImage3.imageset', 'wealthScanningImage.imageset', 'addSignImage.imageset', 'newwealthbackgroundimage.imageset', 'myPublicReserveFunds.imageset', 'myCardPocket.imageset', 'houseMoneyImage.imageset', 'fireIcon.imageset', 'orange_invest_ analyze.imageset', 'orderDetailInfo.imageset', 'TreasureScan1.imageset', 'TreasureScan3.imageset', 'TreasureScanBack.imageset', 'TreasureScan0.imageset', 'TreasureScan2.imageset', 'TreasureScan4.imageset', 'TreasureScan5.imageset', 'periodiceBalance.imageset', 'currentBalance.imageset', 'periodicBalance.imageset', 'imported_Layers.imageset', 'white_star.imageset', 'white_empty_star.imageset'";
    NSString *str1 = [text stringByReplacingOccurrencesOfString:@"'" withString:@""];
    NSString *str2 = [str1 stringByReplacingOccurrencesOfString:@" " withString:@""];
//    [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.array = [str2 componentsSeparatedByString:@","];
    _fm  = [NSFileManager defaultManager];
    NSLog(@"%@", self.array);
    [self deleteItem:rootPath];
}

- (void)deleteItem:(NSString*)path{
    NSArray *dirs = [_fm contentsOfDirectoryAtPath:path error:nil];
    for (NSString *child in dirs) {
        NSString *childPath = [path stringByAppendingPathComponent:child];
        BOOL isdir;
        [_fm fileExistsAtPath:childPath isDirectory:&isdir];
        if (isdir) {
            for (NSString *toBeDeletePath in self.array) {
                NSString *lastString = [[childPath componentsSeparatedByString:@"/"] lastObject];
                if ([toBeDeletePath isEqualToString:lastString]) {
                    [_fm removeItemAtPath:childPath error:nil];
                }
            }
        }
        [self deleteItem:childPath];
    }
}

@end
