//
//  YoutubeFetcher.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/23/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

protocol AuthorUserFetchingDelegate  {
    func endFetchingUserChannel(channel :GTLYouTubeChannel)
    func endFetchingUserSubscriptions(array:NSArray)
}

class YoutubeFetcher: NSObject {
    var youTubeService: GTLServiceYouTube?
    var _delegate: AuthorUserFetchingDelegate?
    
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
        query.mine = true
        
        service.executeQuery(query, completionHandler: { //GTLYouTubeChannel array
            (ticket, resultList, error) -> Void in
            
            if (error == nil) {
                let result = resultList as GTLYouTubeChannelListResponse
                let array = result.items() as NSArray
                if(array.count >= 1){
                    let channel = array[0] as GTLYouTubeChannel
                    YoutubeUserProfile.sharedInstance.userChannel = channel
                    
                    if(self._delegate != nil){
                        self._delegate?.endFetchingUserChannel(channel)
                    }
                    
                    var subsriptions: NSMutableArray = []
                    self.fetchingLoggedUserSubscriptions(channel)
                }
            }
        })
    }
    
    func fetchingChannelList(channelID: NSString,completeHandler:(NSObject,error: NSError) ->Void!) {
        let service: GTLService = self.youTubeService!
        
        var query: GTLQueryYouTube = GTLQueryYouTube.queryForChannelsListWithPart("snippet") as GTLQueryYouTube
        query.fields = "items/snippet(thumbnails)"
        query.identifier = channelID
        
        service.executeQuery(query, completionHandler: { //GTLYouTubeChannel array
            (ticket, resultList, error) -> Void in
            var channel:GTLYouTubeChannel?
            
            if (error == nil) {
                let result = resultList as GTLYouTubeChannelListResponse
                let array = result.items() as NSArray
                if(array.count >= 1){
                    channel = array[0] as GTLYouTubeChannel
                }
            }else{
            }
            
            completeHandler(channel!, error: error)
            
        })
    }
    
    func fetchingLoggedUserSubscriptions(channel:GTLYouTubeChannel) {
        let service: GTLService = self.youTubeService!
        
        var query: GTLQueryYouTube = GTLQueryYouTube.queryForSubscriptionsListWithPart("id,snippet") as GTLQueryYouTube
        query.maxResults = 50 // used (important)
        query.channelId = channel.identifier
        query.fields = "items/snippet(title,resourceId,thumbnails),nextPageToken"
        
        service.executeQuery(query, completionHandler: { // GTLYouTubeSubscription array
            (ticket, resultList, error) -> Void in
            
            if (error == nil) {
                let result = resultList as GTLYouTubeSubscriptionListResponse
                let array = result.items() as NSArray
                if(self._delegate != nil){
                    self._delegate?.endFetchingUserSubscriptions(array)
                }
            }
        })
        
    }
    
    
}