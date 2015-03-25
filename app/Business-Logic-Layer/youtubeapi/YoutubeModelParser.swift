//
//  YoutubeModelParser.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/23/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


class YoutubeModelParser {
    
    // MARK: Parse for GTLYouTubeChannel
    func getAuthChannelSnippetThumbnailUrl(channel :GTLYouTubeChannel) -> NSString {
        return channel.snippet.thumbnails.high.url
    }
    func getAuthChannelTitle(channel :GTLYouTubeChannel) -> NSString {
        return channel.snippet.title
    }
    func getAuthChannelID(channel :GTLYouTubeChannel) -> NSString {
        return channel.identifier
    }
    
    // MARK: Parse for GTLYouTubeSubscription
    class  func getSubscriptionTitle(subscription :GTLYouTubeSubscription) -> NSString {
        return subscription.snippet.title
    }
    class  func getSubscriptionUrl(subscription :GTLYouTubeSubscription) -> NSString {
        return subscription.snippet.thumbnails.high.url
    }
    
    class func convertToMenuRowArrayFromSubscriptions(subscriptions :NSArray) -> [MenuRowItemInfo] {// array of MenuRowItemInfo
        var rows = [MenuRowItemInfo]()
        
        for subscription in subscriptions {
            var title = self.getSubscriptionTitle(subscription as GTLYouTubeSubscription)
            var url = self.getSubscriptionUrl(subscription as GTLYouTubeSubscription)
            var rowItem : MenuRowItemInfo =
            MenuRowItemInfo(title: title,  imageUrl: url,   rowHParas: YTPlayListItemsType.kUploadsTag.rawValue)
            rows.append(rowItem)
        }
        return rows
    }
    
}