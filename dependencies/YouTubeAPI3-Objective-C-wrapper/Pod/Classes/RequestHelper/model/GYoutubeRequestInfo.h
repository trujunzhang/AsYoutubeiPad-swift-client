//
//  Search.h
//  IOSTemplate
//
//  Created by djzhang on 9/25/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//


#include "YoutubeConstants.h"


typedef NS_ENUM (NSUInteger, YTSegmentItemType) {
    YTSegmentItemVideo,
    YTSegmentItemChannel,
    YTSegmentItemPlaylist
};


typedef NS_ENUM (NSUInteger, YTPlaylistItemsType) {
    // Playlist pop-up menu item tags.
            kUploadsTag = 0,
    kLikesTag = 1,
    kFavoritesTag = 2,
    kWatchHistoryTag = 3,
    kWatchLaterTag = 4
};


@interface GYoutubeRequestInfo : NSObject

@property (nonatomic, strong) NSMutableArray *videoList;

- (void)appendNextPageData:(NSArray *)array;

@property (nonatomic) BOOL hasLoadingMore;
@property (nonatomic) BOOL hasFirstFetch;

@property (nonatomic, strong) NSMutableDictionary *parameters;

@property (nonatomic) YTSegmentItemType itemType;
@property (nonatomic, copy) NSString *itemIdentify;

@property (nonatomic, assign) YTPlaylistItemsType playlistItemsType;

@property (nonatomic, copy) NSString *nextPageToken;

@property (nonatomic) BOOL isLoading;

- (void)resetInfo;

- (void)resetVideoList;

- (void)resetRequestInfoForSuggestionList:(NSString *)id1;

- (void)resetRequestInfoForPlayList:(YTPlaylistItemsType)playlistItemsType;

- (void)resetRequestInfoForActivityListFromChannelWithChannelId:(NSString *)channelId;

- (void)resetRequestInfoForVideoListFromChannelWithChannelId:(NSString *)channelId;

- (void)resetRequestInfoForPlayListFromChannelWithChannelId:(NSString *)channelId;

- (void)resetRequestInfoForSearchWithItemType:(YTSegmentItemType)itemType withQueryTeam:(NSString *)queryTeam;

- (void)putNextPageToken:(NSString *)token;

- (BOOL)hasNextPage;

+ (NSArray *)getChannelPageSegmentTitlesArray;

+ (NSString *)getIdentifyByItemType:(YTSegmentItemType)itemType;

+ (YTSegmentItemType)getItemTypeByIndex:(int)index;

+ (NSArray *)getSegmentTitlesArray;

@end
