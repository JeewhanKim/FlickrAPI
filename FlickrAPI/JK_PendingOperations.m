//
//  JK_PendingOperations.m
//  FlickrAPI
//
//  Created by Jeewhan Kim on 5/10/15.
//  Copyright (c) 2015 MichaelKim. All rights reserved.
//

#import "JK_PendingOperations.h"

@implementation JK_PendingOperations

- (NSMutableDictionary *)downloadInProgress {
    if(!_downloadInProgress) {
        _downloadInProgress = [[NSMutableDictionary alloc] init];
    }
    return _downloadInProgress;
}

- (NSOperationQueue *)downloadQueue {
    if(!_downloadQueue) {
        _downloadQueue = [[NSOperationQueue alloc] init];
        _downloadQueue.name = @"Download Queue";
        _downloadQueue.maxConcurrentOperationCount = 1;
    }
    return _downloadQueue;
}
@end
