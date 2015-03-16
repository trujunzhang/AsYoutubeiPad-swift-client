//
//  Search.m
//  IOSTemplate
//
//  Created by djzhang on 9/25/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "GYoutubeAuthUser.h"

#import "YoutubeConstants.h"
#import "YoutubeParser.h"


@implementation GYoutubeAuthUser

- (instancetype)init {
    self = [super init];
    if(self) {
        self.channel = [[YTYouTubeAuthorChannel alloc] init];
    }

    return self;
}


- (NSArray *)getTableRows:(NSArray *)subscriptionsList {
    NSMutableArray *rows = [[NSMutableArray alloc] init];
    for (YTYouTubeSubscription *subscription in subscriptionsList) {
        NSString *title = [YoutubeParser getSubscriptionSnippetTitle:subscription];
        NSString *thumbnailsUrl = [YoutubeParser getSubscriptionSnippetThumbnailUrl:subscription];
        NSString *channelId = [YoutubeParser getChannelIdBySubscription:subscription];
        NSArray *row = @[title, thumbnailsUrl, channelId];

        [rows addObject:row];
    }

    return [rows copy];
}


@end
