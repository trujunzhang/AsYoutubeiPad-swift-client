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


 let myChannelId = "UC0wObT_HayGfWLdRAnFyPwA"
 let baseURLString = "https://www.googleapis.com/youtube/v3"

 let apiKey            = "AIzaSyBd9kf5LB41bYWnxI3pfoxHJ2njRvmAA90"
 let kMyClientID       = "632947002586-hsu569tme6lt8635vvoofi5mnkqfkqus.apps.googleusercontent.com"
 let kMyClientSecret   = "dHWxjaetid5ckoVMzp0LmzJt"
// let scope             = "https://www.googleapis.com/auth/youtube https://www.googleapis.com/auth/youtube.readonly https://www.googleapis.com/auth/youtubepartner https://www.googleapis.com/auth/youtubepartner-channel-audit https://www.googleapis.com/auth/youtube.upload"

 let scope             = "https://www.googleapis.com/auth/youtube https://www.googleapis.com/auth/youtube.readonly"


struct YoutubeApi {
    enum Router: URLRequestConvertible {

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
            
            let URL = NSURL(string: baseURLString)
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


