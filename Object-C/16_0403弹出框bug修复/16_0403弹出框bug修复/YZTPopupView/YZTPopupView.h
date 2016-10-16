//
//  YZTPopupView.h
//  YZTPopupView
//
//  Created by Ralph Li on 9/6/15.
//  Copyright © 2015 LJC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MMPopupType) {
    MMPopupTypeAlert,
    MMPopupTypeSheet,
    MMPopupTypeCustom,
};

@class YZTPopupView;

typedef void(^MMPopupBlock)(YZTPopupView *);

@interface YZTPopupView : UIView

@property (nonatomic, assign, readonly) BOOL           visible;             // default is NO.
@property (nonatomic, assign) BOOL           isAllHide;             // default is NO.

@property (nonatomic, strong          ) UIView         *attachedView;       // default is YZTPopupWindow. You can attach YZTPopupView to any UIView.

@property (nonatomic, assign          ) MMPopupType    type;                // default is MMPopupTypeAlert.
@property (nonatomic, assign          ) NSTimeInterval animationDuration;   // default is 0.3 sec.
@property (nonatomic, assign          ) BOOL           withKeyboard;        // default is NO. When YES, alert view with be shown with a center offset (only effect with MMPopupTypeAlert).

@property (nonatomic, copy            ) MMPopupBlock   showCompletionBlock; // show completion block.
@property (nonatomic, copy            ) MMPopupBlock   hideCompletionBlock; // hide completion block

@property (nonatomic, copy            ) MMPopupBlock   showAnimation;       // custom show animation block.
@property (nonatomic, copy            ) MMPopupBlock   hideAnimation;       // custom hide animation block.
@property (nonatomic, assign) CGFloat keyBoardDuration;
@property (nonatomic, assign) CGFloat keyBoardHeight;
@property (nonatomic, assign) NSNumber * keyBoardCurve;
/**
 *  override this method to show the keyboard if with a keyboard
 */
- (void) showKeyboard;

/**
 *  override this method to hide the keyboard if with a keyboard
 */
- (void) hideKeyboard;


/**
 *  show the popup view
 */
- (void) show;

/**
 *  show the popup view with completiom block
 *
 *  @param block show completion block
 */
- (void) showWithBlock:(MMPopupBlock)block;

/**
 *  展示完成后想做的操作的扩展
 */
- (void) showCompletionHandler;

/**
 *  cancle the popup view by tap the shadow
 */
- (void) cancle;

/**
 *  hide the popup view
 */
- (void) hide;

/**
 *  hide the popup view with completiom block
 *
 *  @param block hide completion block
 */
- (void) hideWithBlock:(MMPopupBlock)block;

@end
