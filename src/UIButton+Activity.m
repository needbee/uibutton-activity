//
//  UIButton+Activity.m
//  Scriptive
//
//  Created by Josh Justice on 7/21/14.
//  Copyright (c) 2014 Scriptive. All rights reserved.
//

#import "UIButton+Activity.h"
#import <objc/runtime.h>

#define USE_SPINNER_KEY @"useSpinner"
#define SPINNER_KEY @"spinner"

@implementation UIButton (Activity)

-(void)useActivityIndicator:(bool)use
{
    objc_setAssociatedObject(self, USE_SPINNER_KEY, [NSNumber numberWithBool:use], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    [self updateActivityIndicatorVisibility];
}

-(void)updateActivityIndicatorVisibility {
    NSNumber *useSpinner = (NSNumber*)objc_getAssociatedObject(self, USE_SPINNER_KEY);
    if( nil == useSpinner || NO == useSpinner.boolValue ) {
        return;
    }
    
    UIActivityIndicatorView *spinner = (UIActivityIndicatorView*)objc_getAssociatedObject(self, SPINNER_KEY);
    if( !self.enabled ) { // show spinner
        if( !spinner ) {
            spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            [spinner setCenter:CGPointMake(self.bounds.size.width/2,
                                           self.bounds.size.height/2)];
            objc_setAssociatedObject(self, SPINNER_KEY, spinner, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        [spinner startAnimating];
        [self addSubview:spinner];
    } else { // self.enabled == true; hide spinner
        if( spinner ) {
            [spinner removeFromSuperview];
            [spinner stopAnimating];
        }
    }
}

@end
