//
//  YoutubeModelParser.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/23/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


class YoutubeModelParser {
    // MARK: Parse for GTLYouTubeVideo

    func getVideoSnippetThumbnails(video: GTLYouTubeVideo) -> NSString {
        return video.snippet.thumbnails.medium.url;
    }

    func getWatchVideoId(video: GTLYouTubeVideo) -> NSString {
        return video.identifier;
    }

    func getChannelIdByVideo(video: GTLYouTubeVideo) -> NSString {
        return video.snippet.channelId;
    }

    func getVideoSnippetTitle(video: GTLYouTubeVideo) -> NSString {
        return video.snippet.title;
    }

//    func getVideoStatisticsViewCount(video: GTLYouTubeVideo) -> NSString {
//        NSNumber *number = video.statistics.viewCount;
//
//        NSNumberFormatter *formatter = [NSNumberFormatter new];
//        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
//        NSString *newString = [formatter stringFromNumber:[NSNumber numberWithInteger:number]];
//
//        return [NSString stringWithFormat:@"%@ views", newString];
//    }

//    func getVideoStatisticsLikeCount(video: GTLYouTubeVideo) -> NSString {
//        NSNumber *likeCount = video.statistics.likeCount;
//        NSNumber *dislikeCount = video.statistics.dislikeCount;
//
//        return [NSString stringWithFormat:@"%d likes, %d dislikes", [likeCount intValue], [dislikeCount intValue]];
//    }

//    func getVideoDescription(video: GTLYouTubeVideo) -> NSString {
//        return video.snippet.descriptionString;
//    }

    func getVideoSnippetChannelTitle(video: GTLYouTubeVideo) -> NSString {
        return video.snippet.channelTitle;
    }

//    func getVideoSnippetChannelPublishedAt(video: GTLYouTubeVideo) -> NSString {
//        return video.snippet.publishedAt.min_string;
//    }

//    func getVideoDurationForVideoInfo(video: GTLYouTubeVideo) -> NSString {
//        NSString *durationString = [YoutubeParser parseISO8601Duration:video.contentDetails.duration];
//        return [NSString stringWithFormat:@" %@ ", durationString];
//    }



    // MARK: Parse for GTLYouTubeChannel
    class func getAuthChannelSnippetThumbnailUrl(channel: GTLYouTubeChannel) -> NSString {
        //        return channel.snippet.thumbnails.high.url
        var stand: GTLYouTubeThumbnail = channel.snippet.thumbnails.standard

        return stand.url
    }

    class func getAuthChannelTitle(channel: GTLYouTubeChannel) -> NSString {
        return channel.snippet.title
    }

    class func getAuthChannelID(channel: GTLYouTubeChannel) -> NSString {
        return channel.identifier
    }


    // MARK: Parse for GTLYouTubeSubscription
    class func getSubscriptionTitle(subscription: GTLYouTubeSubscription) -> NSString {
        return subscription.snippet.title
    }

    class func getSubscriptionUrl(subscription: GTLYouTubeSubscription) -> NSString {
        var thumbnails: GTLYouTubeThumbnailDetails = subscription.snippet.thumbnails
        var dictionary: NSMutableDictionary = thumbnails.JSON["default"] as NSMutableDictionary
        var defaultValue: NSString = dictionary["url"] as NSString

        return defaultValue
    }

    class func convertToMenuRowArrayFromSubscriptions(subscriptions: NSArray) -> [MenuRowItemInfo] {
        // array of MenuRowItemInfo
        var rows = [MenuRowItemInfo]()

        for subscription in subscriptions {
            var title = self.getSubscriptionTitle(subscription as GTLYouTubeSubscription)
            var url = self.getSubscriptionUrl(subscription as GTLYouTubeSubscription)
            var rowItem: MenuRowItemInfo =
            MenuRowItemInfo(title: title, imageUrl: url, rowHParas: YTPlayListItemsType.kUploadsTag.rawValue)
            rows.append(rowItem)
        }
        return rows
    }

}