//
//  MMActionItem.h
//  YZTPopupView
//
//  Created by Ralph Li on 9/6/15.
//  Copyright © 2015 LJC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^MMPopupItemHandler)(NSInteger index);

@interface YZTPopupItem : NSObject

@property (nonatomic, assign) BOOL     highlight;
@property (nonatomic, assign) BOOL     disabled;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIColor  *color;

@property (nonatomic, copy)   MMPopupItemHandler handler;

@end

typedef NS_ENUM(NSUInteger, MMItemType) {
    MMItemTypeNormal,
    MMItemTypeHighlight,
    MMItemTypeDisabled
};

NS_INLINE YZTPopupItem* MMItemMake(NSString* title, MMItemType type, MMPopupItemHandler handler)
{
    YZTPopupItem *item = [YZTPopupItem new];
    
    item.title = title;
    item.handler = handler;
    
    switch (type)
    {
        case MMItemTypeNormal:
        {
            break;
        }
        case MMItemTypeHighlight:
        {
            item.highlight = YES;
            break;
        }
        case MMItemTypeDisabled:
        {
            item.disabled = YES;
            break;
        }
        default:
            break;
    }
    
    return item;
}