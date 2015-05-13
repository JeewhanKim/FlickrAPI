//
//  JK_CollectionViewController.h
//  FlickrAPI
//
//  Created by Jeewhan Kim on 5/10/15.
//  Copyright (c) 2015 MichaelKim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JK_FlickrPhoto.h"
#import "JK_PendingOperations.h"
#import "JK_FlickrImageDownloader.h"
#import "AFNetworking.h"

@interface JK_CollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate, JK_FlickrImageDownloaderDelegate>

@property (nonatomic, strong) NSMutableArray *flickrPhotos;
@property (nonatomic, strong) JK_PendingOperations *pendingOperations;

- (void)searchByKeyword;

@end
