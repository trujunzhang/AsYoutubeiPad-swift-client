//
//  YoutubeParser.h
//  IOSTemplate
//
//  Created by djzhang on 11/15/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//


@interface YoutubeParser : NSObject

+ (NSString *)getVideoIdsByActivityList:(NSMutableArray *)searchResultList;

+ (NSString *)getVideoIdsBySearchResult:(NSMutableArray *)searchResultList;

+ (NSString *)checkAndAppendThumbnailWithChannelId:(NSString *)channelId;

+ (void)AppendThumbnailWithChannelId:(NSString *)channelId withThumbnailUrl:(NSString *)thumbnailUrl;

+ (NSString *)timeFormatConvertToSecondsWithInteger:(NSUInteger)timeSecs;

+ (NSString *)timeFormatConvertToSeconds:(NSString *)timeSecs;

+ (id)getAuthChannelRelatedPlaylists:(id)channel;

+ (NSString *)getChannelBrandingSettingsTitle:(id)channel;

+ (NSString *)getChannelStatisticsSubscriberCount:(id)channel;

// Channel for author
+ (NSString *)getAuthChannelSnippetThumbnailUrl:(id)channel;

+ (NSString *)getAuthChannelTitle:(id)channel;

+ (NSString *)getAuthChannelID:(id)channel;


// Channel for other request
+ (NSString *)getChannelBannerImageUrl:(id)channel;

+ (NSArray *)getChannelBannerImageUrlArray:(id)channel;

+ (NSString *)getChannelSnippetThumbnail:(id)channel;

// Subscription
+ (NSString *)getChannelIdBySubscription:(id)subscription;

+ (NSString *)getSubscriptionSnippetThumbnailUrl:(id)subscription;

+ (NSString *)getSubscriptionSnippetTitle:(id)subscription;

// Video cache
+ (NSString *)getVideoSnippetThumbnails:(id)video;

+ (NSString *)getWatchVideoId:(id)video;

+ (NSString *)getChannelIdByVideo:(id)video;

+ (NSString *)getVideoSnippetTitle:(id)video;

+ (NSString *)getVideoStatisticsViewCount:(id)video;

+ (NSString *)getVideoStatisticsLikeCount:(id)video;

+ (NSString *)getVideoDescription:(id)video;

+ (NSString *)getVideoSnippetChannelTitle:(id)video;

+ (NSString *)getVideoSnippetChannelPublishedAt:(id)video;

+ (NSString *)getVideoDurationForVideoInfo:(id)video;

+ (void)parseDescriptionStringWithRegExp:(id)videoCache;

+ (void)cacheWithKey:(NSString *)key withValue:(NSString *)value;

@end
