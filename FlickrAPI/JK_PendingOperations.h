//
//  JK_PendingOperations.h
//  FlickrAPI
//
//  Created by Jeewhan Kim on 5/10/15.
//  Copyright (c) 2015 MichaelKim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JK_PendingOperations : NSObject

@property (nonatomic, strong) NSMutableDictionary *downloadInProgress;
@property (nonatomic, strong) NSOperationQueue *downloadQueue;

@end
