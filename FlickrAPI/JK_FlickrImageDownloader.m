//
//  JK_FlickrImageDownloader.m
//  FlickrAPI
//
//  Created by Jeewhan Kim on 5/10/15.
//  Copyright (c) 2015 MichaelKim. All rights reserved.
//

#import "JK_FlickrImageDownloader.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "GlobalVars.h"

@interface JK_FlickrImageDownloader()

@property (nonatomic, readwrite, strong) NSIndexPath *indexPathInTableView;
@property (nonatomic, readwrite, strong) JK_FlickrPhoto *flickrPhoto;

@end

@implementation JK_FlickrImageDownloader

- (id)initWithPhoto:(JK_FlickrPhoto *)photo atIndexPath:(NSIndexPath *)indexPath delegate:(id<JK_FlickrImageDownloaderDelegate>)theDelegate
{
    if(self = [super init]) {
        self.delegate = theDelegate;
        self.indexPathInTableView = indexPath;
        self.flickrPhoto = photo;
    }
    return self;
}

- (void)main {
    @autoreleasepool {
        
        if(self.isCancelled) {
            return;
        }
        
        if(self.flickrPhoto.photoURL) {
            
            // Image Cache - SDWebImage
            SDWebImageManager *manager = [SDWebImageManager sharedManager];
            [manager downloadImageWithURL:self.flickrPhoto.photoURL
                                  options:0
                 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                     // NSLog(@"loading...");
                 }
                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    if (image) {
                        self.flickrPhoto.imageView = [[UIImageView alloc] init];
                        self.flickrPhoto.imageView.image = image;
                        GlobalVars *glb = [GlobalVars getGlobal];
                        [glb->rootView hideProgress];
                    }
                }];
        }
        else {
            self.flickrPhoto.failed = YES;
        }
        
        if(self.isCancelled) {
            return;
        }
        
        [(NSObject *)self.delegate performSelectorOnMainThread:@selector(imageDownloaderDidFinish:) withObject:self waitUntilDone:NO];
    }
}

@end
