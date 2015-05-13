//
//  JK_CollectionViewCell.m
//  FlickrAPI
//
//  Created by Jeewhan Kim on 5/10/15.
//  Copyright (c) 2015 MichaelKim. All rights reserved.
//

#import "JK_CollectionViewCell.h"
#import "GlobalVars.h"

@implementation JK_CollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {

        if(IS_IPAD) {
            self.flickrImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 375, 385)];
        } else {
            self.flickrImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 155, 160)];
        }
        
        self.flickrImage.backgroundColor = [UIColor grayColor];
        
        CGPoint imageViewCenter = self.flickrImage.center;
        imageViewCenter.x = CGRectGetMidX(self.contentView.frame);
        [self.flickrImage setCenter:imageViewCenter];
        
        [self.viewForBaselineLayout addSubview:self.flickrImage];
    }
    return self;
}

@end
