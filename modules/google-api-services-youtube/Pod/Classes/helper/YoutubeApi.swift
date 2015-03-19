//
//  YoutubeApi.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/19/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import Alamofire


enum YTPlayListItemsType: Int {
    // Playlist pop-up menu item tags.
    case    kUploadsTag = 0
    case    kLikesTag = 1
    case    kFavoritesTag = 2
    case    kWatchHistoryTag = 3
    case    kWatchLaterTag = 4
}


struct YoutubeApi {
    enum Router: URLRequestConvertible {
        
        static let myChannelId = "UC0wObT_HayGfWLdRAnFyPwA"
        static let baseURLString = "https://www.googleapis.com/youtube/v3"
        static let consumerKey = "AIzaSyD3P0pZd-yJY67sjcL9dQ_mp2Yagrihf9E"
        
        case channels(Int)
        case subscriptions(String,String,String)
        
        var URLRequest: NSURLRequest {
            let (path: String, parameters: [String: AnyObject]) = {
                switch self {
                case .channels (let page):
                    let params = [
                        "rpp": "50",
                        "include_states": "votes"
                    ]
                    return ("/channels", params)
                case .subscriptions (let part, let channelId, let pageToken):
                    var params = [
                        "part": part,
                        "channelId": channelId,
                        "order": "alphabetical",
                        "pageToken": pageToken
                    ]
                    return ("/subscriptions", params)
                }
                }()
            
            let URL = NSURL(string: Router.baseURLString)
            let URLRequest = NSURLRequest(URL: URL!.URLByAppendingPathComponent(path))
            let encoding = Alamofire.ParameterEncoding.URL
            
            return encoding.encode(URLRequest, parameters: parameters).0
        }
    }
    
    enum ImageSize: Int {
        case Tiny = 1
        case Small = 2
        case Medium = 3
        case Large = 4
        case XLarge = 5
    }
}


