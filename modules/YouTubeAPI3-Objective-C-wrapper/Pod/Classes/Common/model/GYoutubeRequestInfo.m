//
//  Search.m
//  IOSTemplate
//
//  Created by djzhang on 9/25/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "GYoutubeRequestInfo.h"

@interface GYoutubeRequestInfo () {

}
@property (nonatomic, copy) NSString *queryType;

@end

@implementation GYoutubeRequestInfo

- (instancetype)init {
    self = [super init];
    if(self) {
        self.hasLoadingMore = NO;
        self.hasFirstFetch = NO;
    }

    return self;
}


#pragma mark - 
#pragma mark 

- (void)baseReset {
    self.nextPageToken = @"";
    self.hasLoadingMore = YES;
    self.isLoading = NO;
    self.hasFirstFetch = YES;
}

#pragma mark - search

- (void)makeRequestForSearchWithQueryTeam:(NSString *)queryTeam {
    [self baseReset];

    NSArray *queryTypeArray = [GYoutubeRequestInfo getQueryTypeArray];
    self.queryType = queryTypeArray[0];
    NSDictionary *parameters = @{
            @"q" : queryTeam,
            @"type" : self.queryType,
            @"part" : @"id,snippet",
            @"fields" : @"items(id/videoId),nextPageToken",
    };
    self.parameters = [[NSMutableDictionary alloc] initWithDictionary:parameters];
}

// "AV2OkzIGykA"
- (void)resetRequestInfoForSuggestionList:(NSString *)videoId {
    self.itemType = YTSegmentItemVideo;

    self.queryType = [GYoutubeRequestInfo getQueryTypeArray][YTSegmentItemVideo];
    self.itemIdentify = [GYoutubeRequestInfo getIdentifyByItemType:self.itemType];

    [self baseReset];

    NSDictionary *parameters = @{
            @"part" : @"id,snippet",
            @"type" : @"video",
            @"relatedToVideoId" : videoId,
            @"fields" : @"items(id/videoId),nextPageToken",
    };
    self.parameters = [[NSMutableDictionary alloc] initWithDictionary:parameters];
}


- (void)resetRequestInfoForPlayList:(YTPlaylistItemsType)playlistItemsType {
    self.itemType = YTSegmentItemVideo;
    self.queryType = [GYoutubeRequestInfo getQueryTypeArray][YTSegmentItemVideo];
    self.itemIdentify = [GYoutubeRequestInfo getIdentifyByItemType:self.itemType];

    [self baseReset];

    self.playlistItemsType = playlistItemsType;
}


- (void)resetRequestInfoForActivityListFromChannelWithChannelId:(NSString *)channelId {
    self.queryType = [GYoutubeRequestInfo getQueryTypeArray][YTSegmentItemVideo];

    self.itemType = [self getItemType];
    self.itemIdentify = [GYoutubeRequestInfo getIdentifyByItemType:self.itemType];

    [self baseReset];

    NSDictionary *parameters = @{
            @"channelId" : channelId,
            @"part" : @"id,contentDetails",
    };
    self.parameters = [[NSMutableDictionary alloc] initWithDictionary:parameters];
}


- (void)resetRequestInfoForVideoListFromChannelWithChannelId:(NSString *)channelId {
    self.queryType = [GYoutubeRequestInfo getQueryTypeArray][YTSegmentItemVideo];

    self.itemType = [self getItemType];
    self.itemIdentify = [GYoutubeRequestInfo getIdentifyByItemType:self.itemType];

    [self baseReset];

    NSDictionary *parameters = @{
            @"channelId" : channelId,
            @"part" : @"id,snippet",
            @"order" : @"date",
            @"fields" : @"items(id/videoId),nextPageToken",
    };
    self.parameters = [[NSMutableDictionary alloc] initWithDictionary:parameters];
}


- (void)resetRequestInfoForPlayListFromChannelWithChannelId:(NSString *)channelId {
    self.queryType = [GYoutubeRequestInfo getQueryTypeArray][YTSegmentItemPlaylist];

    self.itemType = [self getItemType];
    self.itemIdentify = [GYoutubeRequestInfo getIdentifyByItemType:self.itemType];

    [self baseReset];

    NSDictionary *parameters = @{
            @"channelId" : channelId,
            @"part" : @"id,snippet",
    };
    self.parameters = [[NSMutableDictionary alloc] initWithDictionary:parameters];
}


#pragma mark -
#pragma mark 


- (void)putNextPageToken:(NSString *)pageToken {
    if(pageToken == nil || [pageToken isEqualToString:@""]) {
        self.hasLoadingMore = NO;
        return;
    }
    if([self.nextPageToken isEqualToString:@""] == NO && [pageToken isEqualToString:self.nextPageToken]) {
        self.hasLoadingMore = NO;
    }
    if([self.nextPageToken isEqualToString:@""]) { // First request
        self.nextPageToken = pageToken;
    }

    [self.parameters setObject:pageToken forKey:@"pageToken"];
}

-(NSString *)getPageToken {
    return [self.parameters objectForKey:@"pageToken"];
}


#pragma mark -
#pragma mark


- (YTSegmentItemType)getItemType {
    int index = 0;
    NSArray *array = [GYoutubeRequestInfo getSegmentTitlesArray];
    for (int i = 0;i < array.count;++i) {
        if([self.queryType isEqualToString:array[i]]) {
            index = i;
            break;
        }
    }
    return [GYoutubeRequestInfo getItemTypeByIndex:index];
}


#pragma mark -
#pragma mark - next page


- (void)resetInfo {
    self.videoList = [[NSMutableArray alloc] init];
    self.hasLoadingMore = YES;
}


- (BOOL)hasNextPage {
    return self.hasLoadingMore;
}


- (void)appendNextPageData:(NSArray *)array {
    NSLog(@"leng = %d", array.count);
    [self.videoList addObjectsFromArray:array];
}


#pragma mark  Constant


+ (NSArray *)getChannelPageSegmentTitlesArray {
    NSArray *array = [NSArray arrayWithObjects:
            @"Activity",
            @"Videos",
            @"Playlists",
                    nil];
    return array;
}


+ (NSArray *)getSegmentTitlesArray {
    NSArray *array = [NSArray arrayWithObjects:
            @"Videos",
            @"Channels",
            @"Playlists",
                    nil];
    return array;
}


+ (NSArray *)getQueryTypeArray {
    return @[@"video",
            @"channel",
            @"playlist"];
}


+ (NSString *)getIdentifyByItemType:(YTSegmentItemType)itemType {
    switch (itemType) {
        case YTSegmentItemVideo:
            return @"VideoIdentifier";
        case YTSegmentItemChannel:
            return @"ChannelIdentifier";
        case YTSegmentItemPlaylist:
            return @"PlaylistIdentifier";
    }
    return nil;
}


+ (YTSegmentItemType)getItemTypeByIndex:(int)index {
    switch (index) {
        case 0:
            return YTSegmentItemVideo;
        case 1:
            return YTSegmentItemChannel;
        case 2:
            return YTSegmentItemPlaylist;
    }
    return YTSegmentItemVideo;
}


@end
