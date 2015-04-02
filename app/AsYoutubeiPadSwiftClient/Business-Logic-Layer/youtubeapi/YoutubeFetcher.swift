//
//  YoutubeFetcher.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/23/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

protocol AuthorUserFetchingDelegate {
    func endFetchingUserChannel(channel: GTLYouTubeChannel)
    
    func endFetchingUserSubscriptions(array: NSArray)
}

class YoutubeFetcher: NSObject {
    typealias ObjectHandler = (AnyObject!, Bool!) -> Void
    
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
        
        service.executeQuery(query, completionHandler: {
            //GTLYouTubeChannel array
            (ticket, resultList, error) -> Void in
            
            if (error == nil) {
                let result = resultList as GTLYouTubeChannelListResponse
                let array = result.items() as NSArray
                if (array.count >= 1) {
                    let channel: GTLYouTubeChannel = array[0] as GTLYouTubeChannel
                    
                    var channelID: NSString = YoutubeModelParser.getAuthChannelID(channel)
                    var title: NSString = YoutubeModelParser.getAuthChannelTitle(channel)
                    //                    var userName :NSString        = YoutubeModelParser.getAuthChannelTitle(channel)
                    
                    //                    YoutubeUserProfile.sharedInstance.saveLoggedUserChannelInfo(channelID, title: title, userName: userName)
                    //                    YoutubeUserProfile.sharedInstance.userChannel = channel
                    
                    if (self._delegate != nil) {
                        self._delegate?.endFetchingUserChannel(channel)
                    }
                    
                    var subsriptions: NSMutableArray = []
                    self.fetchingLoggedUserSubscriptions(channel)
                }
            }
        })
    }
    
    func fetchingChannelList(channelID: NSString, completeHandler: ObjectHandler) {
        let service: GTLService = self.youTubeService!
        
        var query: GTLQueryYouTube = GTLQueryYouTube.queryForChannelsListWithPart("snippet") as GTLQueryYouTube
        query.fields = "items/snippet(thumbnails)"
        query.identifier = channelID
        
        service.executeQuery(query, completionHandler: {
            //GTLYouTubeChannel array
            (ticket, resultList, error) -> Void in
            
            if (error == nil) {
                let result = resultList as GTLYouTubeChannelListResponse
                let array = result.items() as NSArray
                if (array.count >= 1) {
                    let channel = array[0] as GTLYouTubeChannel
                    completeHandler(channel, true)
                }
            } else {
                completeHandler(nil, false)
            }
            
        })
    }
    
    func fetchingLoggedUserSubscriptions(channel: GTLYouTubeChannel) {
        let service: GTLService = self.youTubeService!
        
        var query: GTLQueryYouTube = GTLQueryYouTube.queryForSubscriptionsListWithPart("id,snippet") as GTLQueryYouTube
        query.maxResults = 50 // used (important)
        query.channelId = channel.identifier
        query.fields = "items/snippet(title,resourceId,thumbnails),nextPageToken"
        
        service.executeQuery(query, completionHandler: {
            // GTLYouTubeSubscription array
            (ticket, resultList, error) -> Void in
            
            if (error == nil) {
                let result = resultList as GTLYouTubeSubscriptionListResponse
                let array = result.items() as NSArray
                if (self._delegate != nil) {
                    self._delegate?.endFetchingUserSubscriptions(array)
                }
            }
        })
        
    }
    
    // Mark : searchList
    
    //- (void)searchByQueryWithRequestInfo:(GYoutubeRequestInfo *)info completionHandler:(YoutubeResponseBlock)responseHandler errorHandler:(ErrorResponseBlock)errorHandler {
    //NSURLSessionDataTask *task =
    //[[MABYT3_APIRequest sharedInstance]
    //searchForParameters:info.parameters
    //completion:^(YoutubeResponseInfo *responseInfo, NSError *error) {
    //if(responseInfo) {
    //NSLog(@"nextPageToken = %@", responseInfo.pageToken);
    //[info putNextPageToken:responseInfo.pageToken];
    //
    //[self fetchVideoListWithVideoId:[YoutubeParser getVideoIdsBySearchResult:responseInfo.array]
    //completionHandler:responseHandler
    //errorHandler:errorHandler];
    //} else {
    //NSLog(@"ERROR: %@", error);
    //}
    //}];
    //}
    
    func prepareRequestSearch(queryTeam:NSString,completeHandler: ObjectHandler) ->GYoutubeRequestInfo {
        var requestInfo: GYoutubeRequestInfo = GYoutubeRequestInfo()
        
        requestInfo.makeRequestForSearchWithQueryTeam(queryTeam)
        
        search(requestInfo, completeHandler: completeHandler)
        
        return requestInfo
    }
    
    func search(requestInfo: GYoutubeRequestInfo, completeHandler: ObjectHandler) {
        MABYT3_APIRequest.sharedInstance().searchForParameters(requestInfo.parameters, completion: { (responseInfo, error) -> Void in
            
            if (error == nil) {
                requestInfo.putNextPageToken(responseInfo.pageToken)
                let videoIds:NSString = YoutubeParser.getVideoIdsBySearchResult(responseInfo.array)
                var x = 0
            }else{
                var y = 0
            }
        })
    }
    
    
}