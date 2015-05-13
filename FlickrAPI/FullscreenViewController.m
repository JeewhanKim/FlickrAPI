//
//  FullscreenViewController.m
//  FlickrAPI
//
//  Created by Jeewhan on 5/11/15.
//  Copyright (c) 2015 MichaelKim. All rights reserved.
//

#import "FullscreenViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "GlobalVars.h"

@interface FullscreenViewController ()
{
    BOOL        _animated;
    UILabel *label_01;
    UILabel *label_02;
    UILabel *label_03;
    UILabel *label_04;
}

@end

@implementation FullscreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Blur Effect
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.fullImageBg = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [self.fullImageBg setFrame:self.view.bounds];
    self.fullImageBg.userInteractionEnabled = true;
    
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(fullscreenMoveToUp)];
    [swipeUp setDirection:UISwipeGestureRecognizerDirectionUp ];
    [self.fullImageBg addGestureRecognizer:swipeUp];
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(fullscreenMoveToDown)];
    [swipeDown setDirection:UISwipeGestureRecognizerDirectionDown ];
    [self.fullImageBg addGestureRecognizer:swipeDown];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(fullscreenMoveToLeft)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft ];
    [self.fullImageBg addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(fullscreenMoveToRight)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight ];
    [self.fullImageBg addGestureRecognizer:swipeRight];

    [self.view addSubview:self.fullImageBg];
    
    // Fullsize Image
    _fullImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_fullImage];
    
    _fullImageBgTouchArea = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
    [self.view addSubview:_fullImageBgTouchArea];
    _fullImageBgTouchArea.userInteractionEnabled = true;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fullscreenTouches)];
    [tapRecognizer setNumberOfTouchesRequired:1];
    [self.fullImageBgTouchArea addGestureRecognizer:tapRecognizer];
    
    UISwipeGestureRecognizer *swipeLeftAbout = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(aboutViewMoveToLeft)];
    [swipeLeftAbout setDirection:UISwipeGestureRecognizerDirectionLeft ];
    [self.fullImageBgTouchArea addGestureRecognizer:swipeLeftAbout];
    
    self.fullImageBgTouchArea.alpha = 0;
    self.view.alpha = 0;
    
    /* ABOUT VIEW */
    label_01 = [[UILabel alloc] init];
    label_02 = [[UILabel alloc] init];
    label_03 = [[UILabel alloc] init];
    label_04 = [[UILabel alloc] init];
    
    label_01.frame = CGRectMake(-50, 90, DEVICE_WIDTH-70, 30);
    label_02.frame = CGRectMake(-50, 150, DEVICE_WIDTH-70, 30);
    label_03.frame = CGRectMake(-50, 210, DEVICE_WIDTH-70, 30);
    label_04.frame = CGRectMake(-50, 270, DEVICE_WIDTH, 30);

    label_01.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:IS_IPAD ? 24 : 14];
    label_02.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:IS_IPAD ? 24 : 14];
    label_03.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:IS_IPAD ? 24 : 14];
    label_04.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:IS_IPAD ? 18 : 12];
    
    label_01.text = @"FlickrAPI for Inbox Messenger";
    label_02.text = @"Enjoy!";
    label_03.text = @"May 12, 2015";
    label_04.text = @"Copyright 2015 Michael Kim. All Rights Reserved.";
    
    label_01.textAlignment = NSTextAlignmentLeft;
    label_02.textAlignment = NSTextAlignmentLeft;
    label_03.textAlignment = NSTextAlignmentLeft;
    label_04.textAlignment = NSTextAlignmentLeft;
    
    label_01.alpha = 0;
    label_02.alpha = 0;
    label_03.alpha = 0;
    label_04.alpha = 0;
    
    [self.view addSubview:label_01];
    [self.view addSubview:label_02];
    [self.view addSubview:label_03];
    [self.view addSubview:label_04];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)aboutViewMoveToLeft
{
    GlobalVars *glb = [GlobalVars getGlobal];
    [glb->rootView aboutInactive];
}

- (void)fullscreenMoveToUp
{
    [self fullscreenClose:0];
}

- (void)fullscreenMoveToDown
{
    [self fullscreenClose:1];
}

-(void)fullscreenMoveToLeft
{
    [self fullscreenClose:2];
}

-(void)fullscreenMoveToRight
{
    [self fullscreenClose:3];
}

-(void)fullscreenClose:(int)direction
{
    if(_animated) return;
    _animated = true;

    CGRect directionRect;
    
    switch(direction) {
        case 0:
            // Up
            directionRect = CGRectMake(0, -self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height);
            break;
        case 1:
            // Down
            directionRect = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height);
            break;
        case 2:
            // Left
            directionRect = CGRectMake(-self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
            break;
        case 3:
            // Right
            directionRect = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
            break;
    default:
        break;
    }
    
    [UIView animateWithDuration:0.40 delay:0 options:UIViewAnimationOptionCurveEaseOut
         animations:^{
             self.fullImageBg.alpha = 0;
             self.fullImage.frame = directionRect;
     } completion:^(BOOL finished)
     {
         self.view.frame = directionRect;
         self.fullImage.image = nil;
         _animated = false;
         
         GlobalVars *glb = [GlobalVars getGlobal];
         glb->pageLevel = PAGE_LEVEL_HOME;
     }];
}

-(void)setFullscreenImage:(UIImage *)tempImage url:(NSURL *)url
{
    if(_animated) return;
    _animated = true;
    
    GlobalVars *glb = [GlobalVars getGlobal];
    glb->pageLevel = PAGE_LEVEL_FULLSCREEN;
    
    self.view.frame = CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT);
    self.view.alpha = 1;
    self.fullImageBg.alpha = 0;
    _fullImage.alpha = 1;
    
    [glb->rootView showProgress];
    
    [UIView
     animateWithDuration:0.25
     delay:0
     options:UIViewAnimationOptionCurveEaseOut
     animations:^{
         self.fullImageBg.alpha = 1;
     } completion:^(BOOL finished)
     {
         // Fullscreen Image Cache
         SDWebImageManager *manager = [SDWebImageManager sharedManager];
         [manager downloadImageWithURL:url
               options:0
              progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                  // NSLog(@"progress..");
              }
             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                 if (image) {
                     NSLog(@"done..");
                     [glb->rootView hideProgress];
                     
                    CGFloat imgHeight = image.size.height * (self.view.bounds.size.width/image.size.width);
                     _fullImage.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, imgHeight);
                     _fullImage.image = image;
                     
                     [UIView
                      animateWithDuration:0.55
                      delay:0
                      options:UIViewAnimationOptionCurveEaseOut
                      animations:^{
                          _fullImage.frame = CGRectMake(0, (self.view.bounds.size.height - (imgHeight))/2, self.view.bounds.size.width, imgHeight);
                      } completion:^(BOOL finished)
                      {
                          
                          _animated = false;
                      }];
                 }
             }];
     }];

}

-(void)showBlurBg
{
    if(_animated) return;
    _animated = true;
    
    self.view.alpha = 1;
    self.view.frame = CGRectMake(0, 60, DEVICE_WIDTH, DEVICE_HEIGHT-60);
    self.fullImage.alpha = 0;
    self.fullImageBg.alpha = 0;
    
    [UIView
     animateWithDuration:0.50
     delay:0
     options:UIViewAnimationOptionCurveEaseOut
     animations:^{
         self.fullImageBg.alpha = 1;
     } completion:^(BOOL finished)
     {
         self.fullImageBgTouchArea.alpha = 1;
         _animated = false;
     }];
}

-(void)hideBlurBg
{
    if(_animated) return;
    _animated = true;

    [UIView
     animateWithDuration:0.50
     delay:0
     options:UIViewAnimationOptionCurveEaseOut
     animations:^{
         self.fullImageBg.alpha = 0;
     } completion:^(BOOL finished)
     {
         self.fullImageBgTouchArea.alpha = 0;
         _animated = false;
         
         self.view.alpha = 0;
         self.view.frame = CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT);
         
         GlobalVars *glb = [GlobalVars getGlobal];
         glb->pageLevel = PAGE_LEVEL_HOME;
     }];
}

-(void)fullscreenTouches
{
    if(_animated) return;
    
    GlobalVars *glb = [GlobalVars getGlobal];
    
    if(glb->pageLevel == PAGE_LEVEL_SEARCH) {
        [glb->rootView searchInactive];
        
    }
}

- (void)showAboutText
{
    [UIView
     animateWithDuration:0.50
     delay:0
     options:UIViewAnimationOptionCurveEaseOut
     animations:^{
         label_01.frame = CGRectMake(20, 90, DEVICE_WIDTH-70, 30);
         label_02.frame = CGRectMake(20, 150, DEVICE_WIDTH-70, 30);
         label_03.frame = CGRectMake(20, 210, DEVICE_WIDTH-70, 30);
         label_04.frame = CGRectMake(20, 270, DEVICE_WIDTH, 30);
         label_01.alpha = 1;
         label_02.alpha = 1;
         label_03.alpha = 1;
         label_04.alpha = 1;
     } completion:^(BOOL finished)
     {
     }];
}

- (void)hideAboutText
{
    [UIView
     animateWithDuration:0.50
     delay:0
     options:UIViewAnimationOptionCurveEaseOut
     animations:^{
         label_01.frame = CGRectMake(-50, 90, DEVICE_WIDTH-70, 30);
         label_02.frame = CGRectMake(-50, 150, DEVICE_WIDTH-70, 30);
         label_03.frame = CGRectMake(-50, 210, DEVICE_WIDTH-70, 30);
         label_04.frame = CGRectMake(-50, 270, DEVICE_WIDTH, 30);
         label_01.alpha = 0;
         label_02.alpha = 0;
         label_03.alpha = 0;
         label_04.alpha = 0;
     } completion:^(BOOL finished)
     {
     }];
}

@end
