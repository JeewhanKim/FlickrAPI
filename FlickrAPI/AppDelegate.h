//
//  AppDelegate.h
//  FlickrAPI
//
//  Created by MichaelKim on 5/6/15.
//  Copyright (c) 2015 MichaelKim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JK_CollectionViewController.h"
#import "ViewController.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) JK_CollectionViewController *cvController;
@property (strong, nonatomic) ViewController    *vController;

@end

