//
//  GlobalVars.m
//  FlickrAPI
//
//  Created by MichaelKim on 5/6/15.
//  Copyright (c) 2015 MichaelKim. All rights reserved.
//

#import "GlobalVars.h"

static GlobalVars *globalVars = nil;

@implementation GlobalVars

- (void) initGlobal
{
    searchKeywords = @"inbox";
    pageLevel = 0;
}

+ (GlobalVars *)getGlobal
{
    if (globalVars == nil)
    {
        globalVars = [[super allocWithZone:NULL] init];
        [globalVars initGlobal];
    }
    
    return globalVars;
}

@end
