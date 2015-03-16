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

#pragma mark - for search


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

- (void)resetRequestInfoForSuggestionList:(NSString *)videoId {
    self.itemType = YTSegmentItemVideo;

    self.queryType = [GYoutubeRequestInfo getQueryTypeArray][YTSegmentItemVideo];
    self.itemIdentify = [GYoutubeRequestInfo getIdentifyByItemType:self.itemType];

    [self baseReset];

    self.parameters = [[NSMutableDictionary alloc] initWithDictionary:@{
            @"part" : @"id,snippet",
            @"type" : @"video",
            @"relatedToVideoId" : videoId,
            @"fields" : @"items(id/videoId),nextPageToken",
    }];
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

    self.parameters = [[NSMutableDictionary alloc] initWithDictionary:@{
            @"channelId" : channelId,
            @"part" : @"id,contentDetails",
    }];
}


- (void)resetRequestInfoForVideoListFromChannelWithChannelId:(NSString *)channelId {
    self.queryType = [GYoutubeRequestInfo getQueryTypeArray][YTSegmentItemVideo];

    self.itemType = [self getItemType];
    self.itemIdentify = [GYoutubeRequestInfo getIdentifyByItemType:self.itemType];

    [self baseReset];

    self.parameters = [[NSMutableDictionary alloc] initWithDictionary:@{
            @"channelId" : channelId,
            @"part" : @"id,snippet",
            @"order" : @"date",
            @"fields" : @"items(id/videoId),nextPageToken",
    }];
}


- (void)resetRequestInfoForPlayListFromChannelWithChannelId:(NSString *)channelId {
    self.queryType = [GYoutubeRequestInfo getQueryTypeArray][YTSegmentItemPlaylist];

    self.itemType = [self getItemType];
    self.itemIdentify = [GYoutubeRequestInfo getIdentifyByItemType:self.itemType];

    [self baseReset];

    self.parameters = [[NSMutableDictionary alloc] initWithDictionary:@{
            @"channelId" : channelId,
            @"part" : @"id,snippet",
    }];
}


- (void)resetRequestInfoForSearchWithItemType:(YTSegmentItemType)itemType withQueryTeam:(NSString *)queryTeam {
    [self resetInfo];

    self.queryType = [GYoutubeRequestInfo getQueryTypeArray][itemType];

    self.itemType = [self getItemType];
    self.itemIdentify = [GYoutubeRequestInfo getIdentifyByItemType:self.itemType];

    [self baseReset];

    self.parameters = [[NSMutableDictionary alloc] initWithDictionary:@{
            @"q" : queryTeam,
            @"type" : self.queryType,
            @"part" : @"id,snippet",
            @"fields" : @"items(id/videoId),nextPageToken",
    }];
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
    [self resetVideoList];
    self.hasLoadingMore = YES;
}

- (void)resetVideoList {
    self.videoList = [[NSMutableArray alloc] init];
}


- (BOOL)hasNextPage {
    return self.hasLoadingMore;
}


- (void)appendNextPageData:(NSArray *)array {
//    NSLog(@"append leng = %d", array.count);
    [self.videoList addObjectsFromArray:array];
}


#pragma mark  Constant


+ (NSArray *)getChannelPageSegmentTitlesArray {
    return [NSArray arrayWithObjects:@"Activity", @"Videos", @"Playlists", nil];
}


+ (NSArray *)getSegmentTitlesArray {
    return [NSArray arrayWithObjects:@"Videos", @"Channels", @"Playlists", nil];

}


+ (NSArray *)getQueryTypeArray {
    return [NSArray arrayWithObjects:@"video", @"channel", @"playlist", nil];
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
