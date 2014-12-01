//
//  UIButton+Activity.h
//  Scriptive
//
//  Created by Josh Justice on 7/21/14.
//  Copyright (c) 2014 Scriptive. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef IBInspectable
#define IBInspectable
#endif

@interface UIButton (Activity)

@property (readwrite) IBInspectable BOOL useActivityIndicator;
-(void)updateActivityIndicatorVisibility;

@end
