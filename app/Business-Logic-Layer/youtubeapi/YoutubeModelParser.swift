//
//  YoutubeModelParser.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/23/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


class YoutubeModelParser {
    
    func getAuthChannelSnippetThumbnailUrl(channel :GTLYouTubeChannel) -> NSString {
        return channel.snippet.thumbnails.high.url
    }
    func getAuthChannelTitle(channel :GTLYouTubeChannel) -> NSString {
        return channel.snippet.title
    }
    func getAuthChannelID(channel :GTLYouTubeChannel) -> NSString {
        return channel.identifier
    }
    
    
    
}