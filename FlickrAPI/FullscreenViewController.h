//
//  FullscreenViewController.h
//  FlickrAPI
//
//  Created by Jeewhan on 5/11/15.
//  Copyright (c) 2015 MichaelKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FullscreenViewController : UIViewController

@property (strong, nonatomic) UIVisualEffectView    *fullImageBg;
@property (strong, nonatomic) UIImageView           *fullImageBgTouchArea;
@property (strong, nonatomic) UIImageView           *fullImage;

- (void)setFullscreenImage:(UIImage *)tempImage url:(NSURL *)url;
- (void)showBlurBg;
- (void)hideBlurBg;
- (void)showAboutText;
- (void)hideAboutText;

@end
