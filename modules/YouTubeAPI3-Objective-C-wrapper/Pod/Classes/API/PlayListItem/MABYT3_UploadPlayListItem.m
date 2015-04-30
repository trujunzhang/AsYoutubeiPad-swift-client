//
//  MABYT3_PlayListItem.m
//  YTAPI3Demo
//
//  Full Details : https://developers.google.com/youtube/v3/docs/playlistItems#properties
//
//  Created by Muhammad Bassio on 5/3/14.
//  Copyright (c) 2014 Muhammad Bassio. All rights reserved.
//

#import "MABYT3_UploadPlayListItem.h"

@implementation MABYT3_UploadPlayListItem

- (id)init {

    self = [super init];
    if (self) {
        _kind = @"youtube#playlistItem";
        _etag = @"";
        _identifier = @"";

        _publishedAt = @"";
        _title = @"";
        _videoId = @"";
    }
    return self;
}

- (id)initFromDictionary:(NSDictionary *)dict {

    self = [super init];
    if (self) {
        _kind = @"youtube#playlistItem";
        _etag = @"";
        _identifier = @"";

        _publishedAt = @"";
        _title = @"";
        _videoId = @"";

        if ([dict objectForKey:@"kind"]) {
            _kind = [dict objectForKey:@"kind"];
        }
        if ([dict objectForKey:@"etag"]) {
            _etag = [dict objectForKey:@"etag"];
        }
        if ([dict objectForKey:@"id"]) {
            _identifier = [dict objectForKey:@"id"];
        }
        NSDictionary *snippetDict = [dict objectForKey:@"snippet"];
        if (snippetDict) {
            if ([snippetDict objectForKey:@"publishedAt"]) {
                _publishedAt = [snippetDict objectForKey:@"publishedAt"];
            }
            if ([snippetDict objectForKey:@"title"]) {
                _title = [snippetDict objectForKey:@"title"];
            }
        }
        NSDictionary *contentDetailsDict = [dict objectForKey:@"contentDetails"];
        if (contentDetailsDict) {
            if ([contentDetailsDict objectForKey:@"videoId"]) {
                _videoId = [contentDetailsDict objectForKey:@"videoId"];
            }
        }

    }
    return self;
}


@end
