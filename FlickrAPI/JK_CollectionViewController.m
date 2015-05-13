//
//  JK_CollectionViewController.m
//  FlickrAPI
//
//  Created by Jeewhan Kim on 5/10/15.
//  Copyright (c) 2015 MichaelKim. All rights reserved.
//

#import "JK_CollectionViewController.h"
#import "JK_CollectionViewCell.h"
#import "JK_FlickrPhoto.h"
#import "JK_FlickrData.h"
#import "AFNetworking.h"
#import <Realm/Realm.h>
#import "GlobalVars.h"

@interface JK_CollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSString *_search;
}
@end

@implementation JK_CollectionViewController 

@synthesize flickrPhotos = _flickrPhotos;
static NSString * const reuseIdentifier = @"cellIdentifier";


- (JK_PendingOperations *)pendingOperations {
    if(!_pendingOperations) {
        _pendingOperations = [[JK_PendingOperations alloc] init];
    }
    
    return _pendingOperations;
}

- (void)searchByKeyword {
    GlobalVars *glb = [GlobalVars getGlobal];
    [glb->rootView showProgress];
    _search = glb->searchKeywords;
    _flickrPhotos = nil;
    [self.collectionView reloadData];
}
- (NSArray *)flickrPhotos {
    
    if(!_flickrPhotos) {
        
        NSString *URLString = [NSString stringWithFormat:@"%@&api_key=%@&text=%@&per_page=20&page=1&format=json&nojsoncallback=1", flickrSearch, flickrAPIKey, _search];
        NSURL *dataURL = [NSURL URLWithString:URLString];
        NSURLRequest *request = [NSURLRequest requestWithURL:dataURL];

        AFHTTPRequestOperation *data_download = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        [data_download start];
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [data_download setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
            
            NSDictionary *photosData = [dataDictionary objectForKey:@"photos"];
            photosData = [photosData objectForKey:@"photo"];

            NSMutableArray *dataArray = [NSMutableArray array];
            
            for(NSDictionary *photoData in photosData) {
                NSString *photoId = [photoData objectForKey:@"id"];
                NSString *farm = [photoData objectForKey:@"farm"];
                NSString *server = [photoData objectForKey:@"server"];
                NSString *secret = [photoData objectForKey:@"secret"];

                JK_FlickrPhoto *tempData = [[JK_FlickrPhoto alloc] init];

                tempData.photoID = [photoId longLongValue];
                tempData.farm = [farm intValue];
                tempData.server = [server intValue];
                tempData.secret = secret;
                NSString *photoURLString = [NSString stringWithFormat:@"https://farm%ld.staticflickr.com/%ld/%lld_%@_%@.jpg",
                                            (long)tempData.farm, (long)tempData.server, tempData.photoID, tempData.secret, @"q"];
                tempData.photoURL = [NSURL URLWithString:photoURLString];
                
                [dataArray addObject:tempData];
                tempData = nil;
                
                
            }

            self.flickrPhotos = dataArray;
            
            // Store the latest search keyword using Realm
            RLMRealm *defaultRealm = [RLMRealm defaultRealm];
            JK_FlickrData *flickrData = [[JK_FlickrData alloc] init];
            
            [defaultRealm beginWriteTransaction];
            
            flickrData.lastSearch = _search;
            flickrData.lastSearchDate = [NSDate date];
            [defaultRealm addObject:flickrData];
            
            [defaultRealm commitWriteTransaction];

            [self.collectionView reloadData];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:error.localizedDescription
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            alert = nil;
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        }];
    }
    
    return _flickrPhotos;
}

- (void)viewDidLoad {
    
    GlobalVars *glb = [GlobalVars getGlobal];
    _search = glb->searchKeywords;

    // Retrive the latest search keyword
    for(JK_FlickrData *data in [JK_FlickrData allObjects]) {
        JK_FlickrData *flickrData = [[JK_FlickrData alloc] init];
        flickrData = data;
        glb->searchKeywords = flickrData.lastSearch;
        _search = flickrData.lastSearch;
    }

    [super viewDidLoad];
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    [self.collectionView registerClass:[JK_CollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger count = self.flickrPhotos.count;
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JK_CollectionViewCell *jkCell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if(!jkCell) {
        jkCell = [[JK_CollectionViewCell alloc] init];
    }
    
    JK_FlickrPhoto *flickrPhoto = [self.flickrPhotos objectAtIndex:indexPath.row];
    
    if(flickrPhoto.hasImage) {
        jkCell.flickrImage.image = flickrPhoto.imageView.image;
    } else if(flickrPhoto.isFailed) {
        jkCell.flickrImage.image = [UIImage imageNamed:@"Failed.png"];
    } else {
        jkCell.flickrImage.image = [UIImage animatedImageNamed:@"Placeholder" duration:0.5f];
        [self startOperationsForPhotoRecord:flickrPhoto atIndexPath:indexPath];
    }
    return jkCell;
}

- (CGSize)collectionView:(JK_CollectionViewController *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(155, 160);
    
    if(IS_IPAD) {
        size = CGSizeMake(375, 385);
    }
    return size;
}

#pragma mark <PendingOperationsDelegate>
- (void)startOperationsForPhotoRecord:(JK_FlickrPhoto *)data atIndexPath:(NSIndexPath *)indexPath {
    if(!data.hasImage) {
        JK_FlickrImageDownloader *downloader = [[JK_FlickrImageDownloader alloc] initWithPhoto:data atIndexPath:indexPath delegate:self];
        [self.pendingOperations.downloadInProgress setObject:downloader forKey:indexPath];
        [self.pendingOperations.downloadQueue addOperation:downloader];
    }
}

- (void)imageDownloaderDidFinish:(JK_FlickrImageDownloader *)downloader {
    NSIndexPath *indexPath = downloader.indexPathInTableView;
    
    [self.collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil]];
    [self.pendingOperations.downloadInProgress removeObjectForKey:indexPath];
}

#pragma mark <UICollectionViewDelegate>
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

#pragma mark - UIScrollView delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.pendingOperations.downloadQueue setSuspended:YES];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self.pendingOperations.downloadQueue setSuspended:NO];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self.pendingOperations.downloadQueue setSuspended:NO];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GlobalVars *glb = [GlobalVars getGlobal];
    if(glb->pageLevel == PAGE_LEVEL_HOME) {
        JK_FlickrPhoto *flickrPhoto = [self.flickrPhotos objectAtIndex:indexPath.row];
        
        NSString *photoURLString = [NSString stringWithFormat:@"https://farm%ld.staticflickr.com/%ld/%lld_%@_%@.jpg",
                                    (long)flickrPhoto.farm, (long)flickrPhoto.server, flickrPhoto.photoID, flickrPhoto.secret, @"b"];

        if(flickrPhoto.hasImage) {
            [glb->rootView showFullscreenImage:flickrPhoto.imageView.image url:[NSURL URLWithString:photoURLString]];
        }
    }
}


@end
