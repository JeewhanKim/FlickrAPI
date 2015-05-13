//
//  JK_FlickrPhoto.h
//  FlickrAPI
//
//  Created by Jeewhan Kim on 5/10/15.
//  Copyright (c) 2015 MichaelKim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JK_FlickrPhoto : NSObject

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic) long long photoID;
@property (nonatomic) NSInteger farm;
@property (nonatomic) NSInteger server;
@property(nonatomic, strong) NSString *secret;
@property(nonatomic, strong) NSURL *photoURL;
@property (nonatomic, readonly) BOOL hasImage;
@property (nonatomic, getter = isFailed) BOOL failed;

@end
