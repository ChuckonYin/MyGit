//
//  CarBaseViewCell.h
//  cells
//
//  Created by James Tang on 1/6/14.
//  Copyright (c) 2014 James Tang. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class Presenter;
#import "CarPresenter.h"
@interface PresenterTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet CarPresenter *presenter;

@end
