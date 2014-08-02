//
//  NBViewController.m
//  demo
//
//  Created by Josh Justice on 8/2/14.
//  Copyright (c) 2014 NeedBee. All rights reserved.
//

#import "NBViewController.h"
#import "UIButton+Activity.h"

@interface NBViewController ()

@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation NBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _button.backgroundColor = [UIColor lightGrayColor];
    _button.layer.cornerRadius = 2.0;
    
    // turns on the activity indicator for disabled state
    [_button useActivityIndicator:YES];
    
    // usually you want to hide the title in the disabled state
    [_button setTitle:@"" forState:UIControlStateDisabled];
}

- (IBAction)load:(id)sender {
    _button.enabled = NO;
    [self performSelector:@selector(finishLoad)
               withObject:nil
               afterDelay:1.0];
}

- (void)finishLoad {
    _button.enabled = YES;
}

@end
