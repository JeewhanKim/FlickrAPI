//
//  GlobalVars.h
//  FlickrAPI
//
//  Created by MichaelKim on 5/6/15.
//  Copyright (c) 2015 MichaelKim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"

#ifndef global
#define global

#define IS_IPAD (( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) ? YES:NO)
#define IS_IPHONE_5 (([UIScreen mainScreen].scale == 2.f && [UIScreen mainScreen].bounds.size.height == 568) ? YES:NO)
#define IS_35INCH ([[UIScreen mainScreen ] bounds].size.height  == 480 ? YES:NO)
#define IS_RETINA_DISPLAY_DEVICE (([UIScreen mainScreen].scale == 2.f) ? YES:NO)
#define DEVICE_WIDTH [UIScreen mainScreen].bounds.size.width
#define DEVICE_HEIGHT [UIScreen mainScreen].bounds.size.height
#define FONT_COLOR_B [UIColor colorWithRed:0.0/255.0 green:135.0/255.0 blue:255.0/255.0 alpha:1]
#define flickrSearch @"https://api.flickr.com/services/rest/?method=flickr.photos.search"
#define flickrAPIKey @"34568abee89cfc176d39e794a69d5ef2"

enum {
    PAGE_LEVEL_HOME = 0,
    PAGE_LEVEL_LIST = 1,
    PAGE_LEVEL_ABOUT = 2,
    PAGE_LEVEL_SEARCH = 3,
    PAGE_LEVEL_FULLSCREEN = 4
};

#endif

@interface GlobalVars : NSObject
{
    @public
    ViewController *rootView;
    int pageLevel;
    NSString *searchKeywords;
}

+ (GlobalVars *)getGlobal;

@end
