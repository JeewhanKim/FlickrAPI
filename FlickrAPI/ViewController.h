//
//  ViewController.h
//  FlickrAPI
//
//  Created by Jeewhan on 5/6/15.
//  Copyright (c) 2015 MichaelKim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JK_CollectionViewController.h"
#import "HudViewController.h"
#import "FullscreenViewcontroller.h"
#import "AboutViewController.h"

@interface ViewController : UIViewController
{
    JK_CollectionViewController *_jkCollectionView;
    HudViewController           *_hudView;
    FullscreenViewController    *_fullscreenView;
    AboutViewController         *_aboutView;
}

- (void)showFullscreenImage:(UIImage *)tempImage url:(NSURL *)url;
- (void)searchActive;
- (void)searchInactive;
- (void)showProgress;
- (void)hideProgress;
- (void)searchByKeyword;
- (void)aboutActive;
- (void)aboutInactive;

@end

