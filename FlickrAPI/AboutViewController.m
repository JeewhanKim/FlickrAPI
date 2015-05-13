//
//  AboutViewController.m
//  FlickrAPI
//
//  Created by Jeewhan on 5/12/15.
//  Copyright (c) 2015 MichaelKim. All rights reserved.
//

#import "AboutViewController.h"
#import "GlobalVars.h"

@interface AboutViewController ()
@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.frame = CGRectMake(-DEVICE_WIDTH, 0, DEVICE_WIDTH, DEVICE_HEIGHT);
    self.view.userInteractionEnabled = YES;
}

- (void)aboutInactive
{
    GlobalVars *glb = [GlobalVars getGlobal];
    
    [UIView
     animateWithDuration:0.35
     delay:0
     options:UIViewAnimationOptionCurveEaseOut
     animations:^{
         self.view.frame = CGRectMake(-DEVICE_WIDTH, 0, DEVICE_WIDTH, DEVICE_HEIGHT);
     } completion:^(BOOL finished)
     {
         glb->pageLevel = PAGE_LEVEL_HOME;
     }];
}

- (void)aboutActive
{
    [UIView
     animateWithDuration:0.35
     delay:0
     options:UIViewAnimationOptionCurveEaseOut
     animations:^{
         self.view.frame = CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT);
     } completion:^(BOOL finished)
     {
         
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
