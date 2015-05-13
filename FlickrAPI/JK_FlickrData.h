//
//  JK_FlickrData.h
//  FlickrAPI
//
//  Created by Jeewhan on 5/12/15.
//  Copyright (c) 2015 MichaelKim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Realm/Realm.h>

@interface JK_FlickrData : RLMObject

@property NSString  *lastSearch;
@property NSDate    *lastSearchDate;

@end
