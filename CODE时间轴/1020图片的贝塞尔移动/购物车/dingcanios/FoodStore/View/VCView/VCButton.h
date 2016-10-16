//
//  VCButton.h
//  Ailv_UI_0902
//
//  Created by liuguopan on 14-10-23.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCButton : UIButton
/**
 *  Button所处Cell的indexPath
 */
@property (nonatomic, strong) NSIndexPath *indexPath;
/**
 *  当前cell对应的site_id
 */
@property (nonatomic, strong) NSString *site_id;

@end
