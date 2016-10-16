//
//  Presenter.h
//

#import <Foundation/Foundation.h>

@interface Presenter : UIView

@property (nonatomic, strong) id model;

/**
 *  This is an abstract method and should be overridden
 */
- (void)reloadData;

@end
