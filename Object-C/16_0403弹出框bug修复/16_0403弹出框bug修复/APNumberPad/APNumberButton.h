//
//  APNumberButton.h
//
//  Created by Andrew Podkovyrin on 16/05/14.
//  Copyright (c) 2014 Podkovyrin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APNumberButton : UIButton

+ (instancetype)buttonWithBackgroundColor:(UIColor *)backgroundColor highlightedColor:(UIColor *)highlightedColor;

- (instancetype)initWithBackgroundColor:(UIColor *)backgroundColor highlightedColor:(UIColor *)highlightedColor;

+ (instancetype)buttonWithBackgroundImage:(UIImage *)backgroundImage highlightedImage:(UIImage *)highlightedImage;

- (void)np_touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;

@end
