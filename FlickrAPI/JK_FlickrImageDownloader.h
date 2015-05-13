//
//  JK_FlickrImageDownloader.h
//  FlickrAPI
//
//  Created by Jeewhan Kim on 5/10/15.
//  Copyright (c) 2015 MichaelKim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JK_FlickrPhoto.h"

@protocol JK_FlickrImageDownloaderDelegate;

@interface JK_FlickrImageDownloader : NSOperation

@property (nonatomic, assign) id<JK_FlickrImageDownloaderDelegate> delegate;
@property (nonatomic, readonly, strong) NSIndexPath *indexPathInTableView;
@property (nonatomic, readonly, strong) JK_FlickrPhoto *flickrPhoto;

- (id)initWithPhoto:(JK_FlickrPhoto *)photo atIndexPath:(NSIndexPath *)indexPath delegate:(id<JK_FlickrImageDownloaderDelegate>) theDelegate;

@end

@protocol JK_FlickrImageDownloaderDelegate <NSObject>

- (void)imageDownloaderDidFinish:(JK_FlickrImageDownloader *)downloader;

@end
