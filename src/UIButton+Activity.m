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

@interface UIButton (ActivityPrivate)

@property (readonly) UIActivityIndicatorView *spinner;

@end

@implementation UIButton (Activity)

+ (void)load {
    static dispatch_once_t once_token;
    dispatch_once(&once_token,  ^{
        SEL setEnabledSelector = @selector(setEnabled:);
        SEL swizzledSetEnabledSelector = @selector(swizzled_setEnabled:);
        Method originalMethod = class_getInstanceMethod(self, setEnabledSelector);
        Method extendedMethod = class_getInstanceMethod(self, swizzledSetEnabledSelector);
        method_exchangeImplementations(originalMethod, extendedMethod);
    });
}

- (void)swizzled_setEnabled:(BOOL)enabled {
    [self swizzled_setEnabled:enabled];
    [self updateActivityIndicatorVisibility];
}

-(BOOL)getUseActivityIndicator {
    BOOL result = NO;
    id useObject = objc_getAssociatedObject(self, USE_SPINNER_KEY);
    if ( [useObject isKindOfClass:[NSNumber class] ] )
    {
        NSNumber *useNumber = useObject;
        result = [useNumber boolValue];
    }
    return result;
}

-(void)useActivityIndicator:(BOOL)use {
    objc_setAssociatedObject(self, USE_SPINNER_KEY, [NSNumber numberWithBool:use], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // if we're already disabled and should be displaying the activity indicator
    [self updateActivityIndicatorVisibility];
}

-(UIActivityIndicatorView *)spinner {
    UIActivityIndicatorView *result;
    
    id spinnerObject = (UIActivityIndicatorView*)objc_getAssociatedObject(self, SPINNER_KEY);
    if ( [spinnerObject isKindOfClass:[UIActivityIndicatorView class] ] )
    {
        result = spinnerObject;
    } else
    {
        // lazy load
        result = [ [UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [result setCenter:CGPointMake(self.bounds.size.width/2,
                                    self.bounds.size.height/2)];
        objc_setAssociatedObject(self, SPINNER_KEY, result, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return result;
}

-(void)updateActivityIndicatorVisibility {
    if(!self.useActivityIndicator) {
        return;
    }
    
    UIActivityIndicatorView *spinner = self.spinner;
    if( !self.enabled ) { // show spinner
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
