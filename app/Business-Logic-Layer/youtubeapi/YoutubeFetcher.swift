//
//  YoutubeFetcher.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/23/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class YoutubeFetcher: NSObject {
    var youTubeService: GTLServiceYouTube?

    class var sharedInstance: YoutubeFetcher {

        struct Singleton {
            static let instance = YoutubeFetcher()
        }

        return Singleton.instance
    }

    override init() {
        super.init()

        self.youTubeService = GTLServiceYouTube()
        self.youTubeService?.shouldFetchNextPages = true
        self.youTubeService?.retryEnabled = true
        self.youTubeService?.APIKey = apiKey
    }

    func initLoggedUser() {
        if (YoutubeUserProfile.sharedInstance.isLogin == true) {
            self.youTubeService?.authorizer = YoutubeUserProfile.sharedInstance.auth
            var canAuthorie = YoutubeUserProfile.sharedInstance.auth.canAuthorize

            self.fetchingLoggedUserChannelInfo()
        }
    }

    func fetchingLoggedUserChannelInfo() {
        let service: GTLService = self.youTubeService!

        var query: GTLQueryYouTube = GTLQueryYouTube.queryForChannelsListWithPart("snippet") as GTLQueryYouTube

        service.executeQuery(query, completionHandler: {
            (ticket, resultList, error) -> Void in

            if (error == nil) {
                NSLog("I am a leaf on the wind: %@", error)
            }
        })


    }

    func fetchingLoggedUserSubscriptions() {


    }


}