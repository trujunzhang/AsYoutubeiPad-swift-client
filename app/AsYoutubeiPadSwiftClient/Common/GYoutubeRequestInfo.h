//
//  Search.h
//  IOSTemplate
//
//  Created by djzhang on 9/25/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger, YTSegmentItemType) {
    YTSegmentItemVideo,
    YTSegmentItemChannel,
    YTSegmentItemPlaylist
};

// Playlist pop-up menu item tags.
typedef NS_ENUM (NSUInteger, YTPlaylistItemsType) {
    kUploadsTag = 0,
    kLikesTag = 1,
    kFavoritesTag = 2,
    kWatchHistoryTag = 3,
    kWatchLaterTag = 4
};


@interface GYoutubeRequestInfo : NSObject

#pragma mark - request
@property (nonatomic, strong) NSMutableDictionary *parameters;


-(NSMutableArray*) getVideoList;
-(NSUInteger)getVideoListCount;
- (void)appendNextPageData:(NSArray *)array;


#pragma mark -

@property (nonatomic) BOOL hasFirstFetch;
@property (nonatomic) BOOL hasLoadingMore;

@property (nonatomic) BOOL isLoading;

#pragma mark -
@property (nonatomic) enum YTSegmentItemType itemType;
@property (nonatomic, copy) NSString *itemIdentify;
@property (nonatomic) YTPlaylistItemsType playlistItemsType;

#pragma mark -

- (void)makeRequestForSearch:(YTSegmentItemType)itemType withQueryTeam:(NSString *)queryTeam;
- (void)makeRequestForSearchWithQueryTeam:(NSString *)queryTeam;

#pragma mark -

- (void)resetInfo;

- (void)resetRequestInfoForSuggestionList:(NSString *)id1;

- (void)resetRequestInfoForPlayList:(YTPlaylistItemsType)playlistItemsType;

- (void)resetRequestInfoForActivityListFromChannelWithChannelId:(NSString *)channelId;

- (void)resetRequestInfoForVideoListFromChannelWithChannelId:(NSString *)channelId;

- (void)resetRequestInfoForPlayListFromChannelWithChannelId:(NSString *)channelId;


-(NSString *)getPageToken ;
- (void)putNextPageToken:(NSString *)token;

- (BOOL)hasNextPage;

+ (NSArray *)getChannelPageSegmentTitlesArray;

+ (NSString *)getIdentifyByItemType:(YTSegmentItemType)itemType;

+ (YTSegmentItemType)getItemTypeByIndex:(int)index;

+ (NSArray *)getSegmentTitlesArray;

@end
