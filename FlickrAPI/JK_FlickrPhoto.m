//
//  JK_FlickrPhoto.m
//  FlickrAPI
//
//  Created by Jeewhan Kim on 5/10/15.
//  Copyright (c) 2015 MichaelKim. All rights reserved.
//

#import "JK_FlickrPhoto.h"

@implementation JK_FlickrPhoto

-(BOOL) hasImage {
    return _imageView != nil;
}

- (BOOL)isFailed {
    return _failed;
}

@end
