//
//  MABYT3_ThumbnailDetails.m
//  YTAPI3Demo
//
//  Full Details : https://developers.google.com/youtube/v3/docs/videos#properties
//
//  Created by Muhammad Bassio on 5/3/14.
//  Copyright (c) 2014 Muhammad Bassio. All rights reserved.
//

#import "MABYT3_ThumbnailDetails.h"
#import "MABYT3_Thumbnail.h"


@implementation MABYT3_ThumbnailDetails


- (id)initFromDictionary:(NSDictionary *)dict {
    self = [super init];
    if(self) {

        NSArray *keys = [dict allKeys];
        for (NSString *key in keys) {
            MABYT3_Thumbnail *thumbnail = [[MABYT3_Thumbnail alloc] initFromDictionary:[dict objectForKey:key]];
            if([key isEqualToString:@"standard"]) {
                self.standard = thumbnail;
            } else if([key isEqualToString:@"medium"]) {
                self.medium = thumbnail;
            } else if([key isEqualToString:@"high"]) {
                self.high = thumbnail;
            } else if([key isEqualToString:@"default"]) {
                self.standard = thumbnail;
            }
        }
    }
    return self;
}


@end
