//
//  YoutubeModelParser.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/23/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


class YoutubeModelParser {

    // MARK: Parse for MABYT3_Channel
    class func getMABChannelThumbnalUrl(channel: MABYT3_Channel) -> NSString {
        var thumbnail: MABYT3_Thumbnail = channel.snippet.thumbnails["default"] as! MABYT3_Thumbnail
        return thumbnail.url!
    }

    // MARK: Parse for GTLYouTubeVideo

    class func getVideoSnippetThumbnails(video: YoutubeVideoCache) -> NSString {
        return video.snippet.thumbnails.standard.url;
    }

    class func getWatchVideoId(video: GTLYouTubeVideo) -> NSString {
        return video.identifier;
    }

    class func getChannelIdByVideo(video: GTLYouTubeVideo) -> NSString {
        return video.snippet.channelId;
    }

    class func getVideoSnippetTitle(video: GTLYouTubeVideo) -> NSString {
        return video.snippet.title;
    }


    class func getVideoSnippetChannelTitle(video: GTLYouTubeVideo) -> NSString {
        return video.snippet.channelTitle;
    }


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
    class func getSubscriptionTitle(subscription: GTLYouTubeSubscription) -> String {
        return subscription.snippet.title as String
    }

    class func getSubscriptionChannelId(subscription: GTLYouTubeSubscription) -> String {
        return (subscription.snippet.resourceId.JSON["channelId"] as? String)!
    }

    class func getSubscriptionUrl(subscription: GTLYouTubeSubscription) -> String {
        var thumbnails: GTLYouTubeThumbnailDetails = subscription.snippet.thumbnails
        var dictionary: NSMutableDictionary = thumbnails.JSON["default"] as! NSMutableDictionary
        var defaultValue: String = dictionary["url"] as! String

        return defaultValue
    }

    class func convertToMenuRowArrayFromSubscriptions(subscriptions: NSArray) -> [MenuRowItemInfo] {
        // array of MenuRowItemInfo
        var rows = [MenuRowItemInfo]()

        for subscription in subscriptions {
            var title: String = YoutubeModelParser.getSubscriptionTitle(subscription as! GTLYouTubeSubscription)
            var url: String = YoutubeModelParser.getSubscriptionUrl(subscription as! GTLYouTubeSubscription)
            var channelId: String = YoutubeModelParser.getSubscriptionChannelId(subscription as! GTLYouTubeSubscription)
            var rowItem: MenuRowItemInfo = MenuRowItemInfo(title: title, imageUrl: url, rowHParas: channelId)
            rows.append(rowItem)
        }
        return rows
    }

}