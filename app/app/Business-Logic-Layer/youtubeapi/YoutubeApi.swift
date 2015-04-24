//
//  YoutubeApi.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/19/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import Alamofire





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


}
