//
//  ViewController.m
//  FlickrAPI
//
//  Created by MichaelKim on 5/6/15.
//  Copyright (c) 2015 MichaelKim. All rights reserved.
//

#import "ViewController.h"
#import "GlobalVars.h"
#import "SVProgressHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    GlobalVars *glb = [GlobalVars getGlobal];
    glb->rootView = self;
    
    // 1. Init root view
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 2. Custom UICollectionView
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    _jkCollectionView = [[JK_CollectionViewController alloc] initWithCollectionViewLayout:layout];
    _jkCollectionView.view.frame = CGRectMake(0, 60, DEVICE_WIDTH, DEVICE_HEIGHT-60);
    
    // 3. Hud View
    _hudView = [[HudViewController alloc] init];
    
    // 4. Fullscreen View
    _fullscreenView = [[FullscreenViewController alloc] init];
    
    // 5. About View
    _aboutView = [[AboutViewController alloc] init];
    
    [self.view addSubview:_aboutView.view];
    [self.view addSubview:_jkCollectionView.view];
    [self.view addSubview:_hudView.view];
    [self.view addSubview:_fullscreenView.view];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    GlobalVars *glb = [GlobalVars getGlobal];
    [glb->rootView showProgress];
}

- (void)showFullscreenImage:(UIImage *)tempImage url:(NSURL *)url
{
    [_fullscreenView setFullscreenImage:tempImage url:url];
}

- (void)searchActive
{
    [_fullscreenView showBlurBg];
}

- (void)searchInactive
{
    [_fullscreenView hideBlurBg];
    [_hudView searchInactive];
}

- (void)showProgress
{
    [SVProgressHUD showWithStatus:@"Loading..."];
}

- (void)hideProgress
{
    [SVProgressHUD dismiss];
}

- (void)searchByKeyword
{
    [_jkCollectionView searchByKeyword];
}

- (void)aboutActive
{
    [_aboutView aboutActive];
    [_fullscreenView showBlurBg];
    
    [UIView
     animateWithDuration:0.35
     delay:0
     options:UIViewAnimationOptionCurveEaseOut
     animations:^{
         _jkCollectionView.view.frame = CGRectMake(DEVICE_WIDTH*0.7, 60, DEVICE_WIDTH, DEVICE_HEIGHT-60);
         _hudView.view.alpha = 0;
     } completion:^(BOOL finished)
     {
         [_fullscreenView showAboutText];
     }];
}

- (void)aboutInactive
{
    [_aboutView aboutInactive];
    [_fullscreenView hideBlurBg];
    [_fullscreenView hideAboutText];
    
    [UIView
     animateWithDuration:0.35
     delay:0
     options:UIViewAnimationOptionCurveEaseOut
     animations:^{
         _jkCollectionView.view.frame = CGRectMake(0, 60, DEVICE_WIDTH, DEVICE_HEIGHT-60);
         _hudView.view.alpha = 1;
     } completion:^(BOOL finished)
     {
         
     }];
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
