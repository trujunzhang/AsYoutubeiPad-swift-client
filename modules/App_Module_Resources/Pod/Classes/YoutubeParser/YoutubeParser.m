//
//  YoutubeParser.m
//  IOSTemplate
//
//  Created by djzhang on 11/15/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <Google-API-Client/GTLYouTubeSubscription.h>
#import <YouTubeAPI3-Objective-C-wrapper/MABYT3_Channel.h>
#import "YoutubeParser.h"
//#import "GTLYouTubeChannelContentDetails.h"

#import "MABYT3_Activity.h"
#import "MABYT3_ResourceId.h"
#import "MABYT3_ActivityContentDetails.h"
#import "MABYT3_SearchItem.h"

#import "YoutubeVideoCache.h"
#import "GTLYouTubeSubscriptionSnippet.h"
#import "GTLYouTubeResourceId.h"
#import "GTLYouTubeThumbnailDetails.h"
#import "GTLYouTubeThumbnail.h"
#import "MABYT3_ChannelBrandingSettings.h"
#import "MABYouTube_Sources.h"
#import "GTLYouTube.h"


@implementation YoutubeParser

static NSUInteger UPLOADS_PAGE_LENGTH = 20;

#pragma mark
#pragma mark - MABYT3_Activity_NewestVideoId

+ (NSArray *)sortNewestVideoListInActivityList:(NSArray *)dataArray {
    NSArray *sortedArray = [dataArray sortedArrayUsingComparator:^(MABYT3_Activity_NewestVideoId *a1, MABYT3_Activity_NewestVideoId *a2) {
        return -1 * [a1.publishedAt compare:a2.publishedAt];
    }];

    return sortedArray;
}


+ (NSArray *)getNewestVideoIdsArrayByMABActivityList:(NSMutableArray *)activities {
    NSMutableArray *videoIdsPages = [[NSMutableArray alloc] init];
    NSUInteger count = activities.count;
    NSUInteger pageNumber = UPLOADS_PAGE_LENGTH;
    NSUInteger pages = count / pageNumber;
    NSUInteger lastNumber = count % pageNumber;
    if (lastNumber != 0) {
        pages++;
    }
    for (int j = 0; j < pages; ++j) {
        NSUInteger start = j * pageNumber;
        NSUInteger endMax = start + pageNumber;
        NSUInteger end = MIN(count, endMax);
        NSString *videoIdsString = [self getNewestVideoIdsStringByMABActivityList:activities from:start end:end];
        [videoIdsPages addObject:videoIdsString];
    }

    return videoIdsPages;
}

+ (NSString *)getNewestVideoIdsStringByMABActivityList:(NSMutableArray *)activities from:(NSUInteger)start end:(NSUInteger)end {
    NSMutableArray *videoIds = [[NSMutableArray alloc] init];
    for (int i = start; i < end; ++i) {
        MABYT3_Activity_NewestVideoId *activity = activities[i];
        NSString *videoId = activity.videoId;
        if (videoId) {
            if ([videoId isEqualToString:@""]) {
                videoId = @"";
            }
            [videoIds addObject:videoId];
        }
    }

    return [videoIds componentsJoinedByString:@","];
}

#pragma mark
#pragma mark - GTLYouTubeChannel

+ (NSArray *)getUploadIdsArrayInContentDetailsFromGTLChannelList:(NSMutableArray *)channels {
    NSMutableArray *uploadIds = [[NSMutableArray alloc] init];
    for (GTLYouTubeChannel *channel in channels) {
        NSString *uploadId = [YoutubeParser getUploadIdsInContentDetailsFromGTLChannelList:channel];
        if (uploadId) {
            [uploadIds addObject:uploadId];
        }
    }

    return uploadIds;
}

+ (NSString *)getUploadIdsInContentDetailsFromGTLChannelList:(GTLYouTubeChannel *)channels {
    return channels.contentDetails.relatedPlaylists.uploads;
}


#pragma mark
#pragma mark - GTLYouTubeActivity

+ (NSString *)getVideoIdByGTLActivityContentDetails:(GTLYouTubeActivity *)activity {
//    NSString *title = activity.snippet.title;
//    NSLog(@"title = %@", title);
    return activity.contentDetails.upload.videoId;
}

+ (NSArray *)getVideoIdsArrayByGTLActivityList:(NSMutableArray *)activities {
    NSMutableArray *videoIdsPages = [[NSMutableArray alloc] init];
    NSUInteger count = activities.count;
    NSUInteger pageNumber = UPLOADS_PAGE_LENGTH;
    NSUInteger pages = count / pageNumber;
    NSUInteger lastNumber = count % pageNumber;
    if (lastNumber != 0) {
        pages++;
    }
    for (int j = 0; j < pages; ++j) {
        NSUInteger start = j * pageNumber;
        NSUInteger endMax = start + pageNumber;
        NSUInteger end = MIN(count, endMax);
        NSString *videoIdsString = [self getVideoIdsStringByGTLActivityList:activities from:start end:end];
        [videoIdsPages addObject:videoIdsString];
    }

    return videoIdsPages;
}

+ (NSString *)getVideoIdsStringByGTLActivityList:(NSMutableArray *)activities from:(NSUInteger)start end:(NSUInteger)end {
    NSMutableArray *videoIds = [[NSMutableArray alloc] init];
    for (int i = start; i < end; ++i) {
        MABYT3_Activity *activity = activities[i];
        NSString *videoId = [YoutubeParser getVideoIdByGTLActivityContentDetails:activity];
        if (videoId) {
            [videoIds addObject:videoId];
        }
    }

    return [videoIds componentsJoinedByString:@","];
}

+ (NSArray *)filterSnippetTypeIsUploadInGTLActivity:(NSMutableArray *)activities {
    NSMutableArray *uploadActivities = [[NSMutableArray alloc] init];
    for (GTLYouTubeActivity *activity in activities) {
        NSString *snippetTypeInActivity = [self getSnippetTypeInActivity:activity];
        if ([snippetTypeInActivity isEqualToString:@"upload"]) {
            [uploadActivities addObject:activity];
        }
    }

    NSArray *dataArray = [NSArray arrayWithArray:uploadActivities];
    NSLog(@"dataArray = %d", dataArray.count);
//    [self printActivitySnippetPublishedAtForArray:dataArray];

    NSArray *sortedArray = [dataArray sortedArrayUsingComparator:^(GTLYouTubeActivity *a1, GTLYouTubeActivity *a2) {
        GTLDateTime *dateTime1 = [self getSnippetPublishedAtInActivity:a1];
        GTLDateTime *dateTime2 = [self getSnippetPublishedAtInActivity:a2];
        NSDate *d1 = dateTime1.date;
        NSDate *d2 = dateTime2.date;

        return -1 * [d1 compare:d2];
    }];

//    [self printActivitySnippetPublishedAtForArray:sortedArray];
//    NSLog(@"sortedArray = %d", sortedArray.count);

    return sortedArray;
}

+ (void)printActivitySnippetPublishedAtForArray:(NSMutableArray *)activities {
    for (GTLYouTubeActivity *activity in activities) {
        GTLDateTime *publishedAt = [self getSnippetPublishedAtInActivity:activity];
        NSDate *date = publishedAt.date;
        NSLog(@"Date output: %@", date);
    }
}


+ (NSString *)getSnippetTypeInActivity:(GTLYouTubeActivity *)activity {
    return activity.snippet.type;
}

+ (GTLDateTime *)getSnippetPublishedAtInActivity:(GTLYouTubeActivity *)activity {
    return activity.snippet.publishedAt;
}


+ (NSString *)getVideoIdsByActivityList:(NSMutableArray *)searchResultList {
    NSMutableArray *videoIds = [[NSMutableArray alloc] init];
    for (MABYT3_Activity *searchResult in searchResultList) {
        NSString *videoId = [YoutubeParser getVideoIdByActivity:searchResult.contentDetails];
        if (videoId)
            [videoIds addObject:videoId];
    }
    return [videoIds componentsJoinedByString:@","];
}


+ (NSString *)getVideoIdByActivity:(MABYT3_ActivityContentDetails *)contentDetails {

    NSArray *resourceArray = [NSArray arrayWithObjects:
            contentDetails.upload,
            contentDetails.like,
            contentDetails.favorite,
                    nil];


    for (MABYT3_ResourceId *resourceId in resourceArray) {
        if (![resourceId.videoId isEqualToString:@""])
            return resourceId.videoId;
    }

    return nil;
}


+ (NSString *)getVideoIdsBySearchResult:(NSMutableArray *)searchResultList {
    NSMutableArray *videoIds = [[NSMutableArray alloc] init];
    for (MABYT3_SearchItem *searchResult in searchResultList) {
        [videoIds addObject:searchResult.identifier.videoId];// used
    }
    return [videoIds componentsJoinedByString:@","];
}


//#pragma mark -
//#pragma mark Subscription

+ (NSArray *)getChannelIdsArrayFromSubscriptionList:(NSMutableArray *)subscriptions {
    NSMutableArray *videoIdsPages = [[NSMutableArray alloc] init];
    NSUInteger pangeNumber = 50;
    NSUInteger count = subscriptions.count;
    NSUInteger pages = count / pangeNumber;
    NSUInteger lastNumber = count % pangeNumber;
    if (lastNumber != 0) {
        pages++;
    }
    for (int j = 0; j < pages; ++j) {
        NSUInteger start = j * pangeNumber;
        NSUInteger endMax = start + pangeNumber;
        NSUInteger end = MIN(count, endMax);
        NSString *videoIdsString = [self getChannelIdsFromSubscriptionList:subscriptions from:start end:end];
        [videoIdsPages addObject:videoIdsString];
    }

    return videoIdsPages;
}

+ (NSString *)getChannelIdsFromSubscriptionList:(NSMutableArray *)subscriptions from:(NSUInteger)start end:(NSUInteger)end {
    NSMutableArray *channelIds = [[NSMutableArray alloc] init];
    for (int i = start; i < end; ++i) {
        GTLYouTubeSubscription *subscription = subscriptions[i];
        NSString *channelId = [YoutubeParser getChannelIdBySubscription:subscription];
        if (channelId) {
            [channelIds addObject:channelId];
        }
    }
    return [channelIds componentsJoinedByString:@","];
}


+ (NSString *)getChannelIdBySubscription:(GTLYouTubeSubscription *)subscription {
    return subscription.snippet.resourceId.JSON[@"channelId"];
}


+ (NSString *)getSubscriptionSnippetThumbnailUrl:(GTLYouTubeSubscription *)subscription {
    return subscription.snippet.thumbnails.high.url;
}


+ (NSString *)getSubscriptionSnippetTitle:(GTLYouTubeSubscription *)subscription {
    return subscription.snippet.title;
}


#pragma mark -
#pragma mark  Video cache


//+ (NSString *)getVideoSnippetThumbnails:(YoutubeVideoCache *)video {
//    
//    MABYT3_ThumbnailDetails *thumbnailDetails =  video.snippet.thumbnails;
//    MABYT3_Thumbnail *standard = thumbnailDetails.standard;
//    
//    return @"";
////    return thumbnailDetails.standard.url;
//    //    return video.snippet.thumbnails[@"medium"].medium.url;
//}


+ (NSString *)getWatchVideoId:(YoutubeVideoCache *)video {
    return video.identifier;
}


+ (NSString *)getChannelIdByVideo:(YoutubeVideoCache *)video {
    return video.snippet.channelId;
}


+ (NSString *)getVideoSnippetTitle:(YoutubeVideoCache *)video {
    return video.snippet.title;
}


+ (NSString *)getVideoStatisticsViewCount:(YoutubeVideoCache *)video {
    NSNumber *number = video.statistics.viewCount;

    NSNumberFormatter *formatter = [NSNumberFormatter new];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *newString = [formatter stringFromNumber:[NSNumber numberWithInteger:number]];

    return [NSString stringWithFormat:@"%@ views", newString];
}


+ (NSString *)getVideoStatisticsLikeCount:(YoutubeVideoCache *)video {
    NSNumber *likeCount = video.statistics.likeCount;
    NSNumber *dislikeCount = video.statistics.dislikeCount;

    return [NSString stringWithFormat:@"%d likes, %d dislikes", [likeCount intValue], [dislikeCount intValue]];
}


+ (NSString *)getVideoDescription:(YoutubeVideoCache *)video {
    return video.snippet.descriptionString;
}


+ (NSString *)getVideoSnippetChannelTitle:(YoutubeVideoCache *)video {
    return video.snippet.channelTitle;
}


+ (NSString *)getVideoSnippetChannelPublishedAt:(YoutubeVideoCache *)video {
    return video.snippet.publishedAt.min_string;
}


+ (NSString *)getVideoDurationForVideoInfo:(YoutubeVideoCache *)video {
    NSString *durationString = [YoutubeParser parseISO8601Duration:video.contentDetails.duration];
//   NSLog(@"durationString = %@", durationString);
    return [NSString stringWithFormat:@" %@ ", durationString];
}


//+ (void)parseDescriptionStringWithRegExp:(YoutubeVideoCache *)videoCache {
//    NSString *videoDescription = [YoutubeParser getVideoDescription:videoCache];
//
//    NSMutableString *address = [[NSMutableString alloc] initWithString:videoDescription];
//
//    address = [address stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
//    address = [address stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
//
//    NSUInteger i = [@"\n" length];
//    NSUInteger length = [@" " length];
//
//    NSString *pattern = @"[a-zA-z]+://[^\\s]*";
//    NSArray *matches = [address rx_matchesWithPattern:pattern];
//
//    int step = 0;
//    NSMutableArray *descriptionStringAttributeArray = [[NSMutableArray alloc] init];
//    for (RXMatch *match in matches) {
//        YoutubeVideoDescriptionStringAttribute *youtubeVideoDescriptionStringAttribute = [[YoutubeVideoDescriptionStringAttribute alloc] init];
//
//        NSString *httpString = [match text];
//        NSRange httpRang = [match range];
//        NSLog(@"Text: %@, Range: [location: %d, length: %d]", httpString,
//                httpRang.location, httpRang.length);
//
//        // 1
//        NSString *kLinkAttributeName = [NSString stringWithFormat:@"VideoDetailNodeLinkAttributeName_%02d", step++];
//        youtubeVideoDescriptionStringAttribute.kLinkAttributeName = kLinkAttributeName;
//        youtubeVideoDescriptionStringAttribute.httpString = httpString;
//        youtubeVideoDescriptionStringAttribute.httpRang = httpRang;
//
//        [descriptionStringAttributeArray addObject:youtubeVideoDescriptionStringAttribute];
//    }
//
//    videoCache.descriptionStringAttributeArray = descriptionStringAttributeArray;
//}


//#pragma mark -
//#pragma mark Channel for other request


+ (NSString *)getChannelBannerImageUrl:(MABYT3_Channel *)channel {
    NSString *imageUrl = channel.brandingSettings.image.bannerMobileMediumHdImageUrl;

    NSLog(@"imageUrl = %@", imageUrl);

    return imageUrl;
}


/**
* bannerMobileImageUrl
*/
+ (NSString *)getChannelBannerImageUrlArray:(MABYT3_Channel *)channel {
    MABYT3_ChannelBrandingSettings *brandingSettings = channel.brandingSettings;
    MABYT3_ChannelBrandingSettingsImage *brandingSettingsImage = brandingSettings.image;
    NSString *bannerMobileImageUrl = brandingSettingsImage.bannerMobileImageUrl;

//    NSString *lowUrl = channel.brandingSettings.image.bannerMobileLowImageUrl;
//    NSString *mediumUrl = channel.brandingSettings.image.bannerMobileMediumHdImageUrl;
//    NSString *hdUrl = channel.brandingSettings.image.bannerMobileHdImageUrl;

    return bannerMobileImageUrl;
//    return channel.brandingSettings.image.bannerImageUrl;
}


+ (NSString *)getChannelSnippetThumbnail:(MABYT3_Channel *)channel {
    MABYT3_Thumbnail *thumbnail = channel.snippet.thumbnails[@"default"];
    return thumbnail.url;
}

+ (NSString *)getChannelUploadsAsPlaylistId:(MABYT3_Channel *)channel {
    NSMutableDictionary *dictionary = channel.contentDetails.relatedPlaylists;
    return dictionary[@"uploads"];
}

+ (NSString *)getUploadsIdsAsPlaylistIds:(NSArray *)channels {
    NSMutableArray *playlistIds = [[NSMutableArray alloc] init];
    for (MABYT3_Channel *channel in channels) {
        [playlistIds addObject:[self getChannelUploadsAsPlaylistId:channel]];// used
    }
    return [playlistIds componentsJoinedByString:@","];
}


+ (NSString *)getChannelBrandingSettingsTitle:(MABYT3_Channel *)channel {
    return channel.brandingSettings.channel.title;
}


+ (NSString *)getChannelStatisticsSubscriberCount:(MABYT3_Channel *)channel {
    unsigned long subscriberCount = channel.statistics.subscriberCount;
    return [NSString stringWithFormat:@"%d subscribers", subscriberCount];
}


//#pragma mark -
//#pragma mark Channel for author
//
//
//+ (NSString *)getAuthChannelSnippetThumbnailUrl:(YTYouTubeAuthorChannel *)channel {
//    return channel.snippet.thumbnails.high.url;
//}
//
//
//+ (NSString *)getAuthChannelTitle:(YTYouTubeAuthorChannel *)channel {
//    return channel.snippet.title;
//}
//
//
//+ (NSString *)getAuthChannelID:(YTYouTubeAuthorChannel *)channel {
//    return channel.identifier;
//}
//
//
//+ (GTLYouTubeChannelContentDetailsRelatedPlaylists *)getAuthChannelRelatedPlaylists:(YTYouTubeAuthorChannel *)channel {
//    return channel.contentDetails.relatedPlaylists;
//}
//

+ (NSString *)parseISO8601Duration:(NSString *)duration {
//   NSString * duration = @"P1DT10H15M49S";

    int i = 0, days = 0, hours = 0, minutes = 0, seconds = 0;

    while (i < duration.length) {
        NSString *str = [duration substringWithRange:NSMakeRange(i, duration.length - i)];

        i++;

        if ([str hasPrefix:@"P"] || [str hasPrefix:@"T"])
            continue;

        NSScanner *sc = [NSScanner scannerWithString:str];
        int value = 0;

        if ([sc scanInt:&value]) {
            i += [sc scanLocation] - 1;

            str = [duration substringWithRange:NSMakeRange(i, duration.length - i)];

            i++;

            if ([str hasPrefix:@"D"])
                days = value;
            else if ([str hasPrefix:@"H"])
                hours = value;
            else if ([str hasPrefix:@"M"])
                minutes = value;
            else if ([str hasPrefix:@"S"])
                seconds = value;
        }
    }

    if (hours == 0) {
        return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
    }
    return [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
}


@end
