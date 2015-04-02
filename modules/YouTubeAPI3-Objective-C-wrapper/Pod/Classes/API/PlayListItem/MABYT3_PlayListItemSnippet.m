//
//  MABYT3_PlayListItemSnippet.m
//  YTAPI3Demo
//
//  Full Details : https://developers.google.com/youtube/v3/docs/playlistItems#snippet
//
//  Created by Muhammad Bassio on 5/3/14.
//  Copyright (c) 2014 Muhammad Bassio. All rights reserved.
//

#import "MABYT3_PlayListItemSnippet.h"

@implementation MABYT3_PlayListItemSnippet

- (id)init {

    self = [super init];
    if(self) {
        _publishedAt = [[MAB_GDate alloc] init];
        _channelId = @"";
        _title = @"";
        _descriptionString = @"";
        _thumbnails = [[NSMutableDictionary alloc] init];
        _channelTitle = @"";
        _playlistId = @"";
        _position = 0;
        _resourceId = [[MABYT3_ResourceId alloc] init];
    }
    return self;
}

- (id)initFromDictionary:(NSDictionary *)dict {

    self = [super init];
    if(self) {
        _publishedAt = [[MAB_GDate alloc] init];
        _channelId = @"";
        _title = @"";
        _descriptionString = @"";
        _thumbnails = [[NSMutableDictionary alloc] init];
        _channelTitle = @"";
        _playlistId = @"";
        _position = 0;
        _resourceId = [[MABYT3_ResourceId alloc] init];

        if([dict objectForKey:@"publishedAt"]) {
            _publishedAt = [[MAB_GDate alloc] initFromString:[dict objectForKey:@"publishedAt"]];
        }
        if([dict objectForKey:@"channelId"]) {
            _channelId = [dict objectForKey:@"channelId"];
        }
        if([dict objectForKey:@"title"]) {
            _title = [dict objectForKey:@"title"];
        }
        if([dict objectForKey:@"description"]) {
            _descriptionString = [dict objectForKey:@"description"];
        }
        if([dict objectForKey:@"channelTitle"]) {
            _channelTitle = [dict objectForKey:@"channelTitle"];
        }
        if([dict objectForKey:@"playlistId"]) {
            _playlistId = [dict objectForKey:@"playlistId"];
        }
        if([dict objectForKey:@"position"]) {
            _position = [[dict objectForKey:@"position"] unsignedIntegerValue];
        }
        if([dict objectForKey:@"resourceId"]) {
            _resourceId = [[MABYT3_ResourceId alloc] initFromDictionary:[dict objectForKey:@"resourceId"]];
        }

        if([dict objectForKey:@"thumbnails"]) {
            NSDictionary *thmbDict = [dict objectForKey:@"thumbnails"];
            NSArray *keys = [thmbDict allKeys];
            for (int i = 0;i < keys.count;i++) {
                MABYT3_Thumbnail *thmb = [[MABYT3_Thumbnail alloc] initFromDictionary:[thmbDict objectForKey:keys[i]]];
                [_thumbnails setObject:thmb forKey:keys[i]];
            }
        }
    }
    return self;
}

@end
