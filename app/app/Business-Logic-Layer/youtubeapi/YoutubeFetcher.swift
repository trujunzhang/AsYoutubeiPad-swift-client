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
    var youTubeService: GTLServiceYouTube?
    var delegate: AuthorUserFetchingDelegate?

    class var sharedInstance: YoutubeFetcher {

        struct Singleton {
            static let instance = YoutubeFetcher()
        }

        return Singleton.instance
    }

    override init() {
        super.init()

        self.youTubeService = GTLServiceYouTube()
        if let theYouTubeService: GTLServiceYouTube = self.youTubeService {
            theYouTubeService.shouldFetchNextPages = true
            theYouTubeService.retryEnabled = true
            theYouTubeService.APIKey = apiKey
        }
    }

    func initLoggedUser() {
        self.youTubeService?.authorizer = YoutubeUserProfile.sharedInstance.auth
        var canAuthorie = YoutubeUserProfile.sharedInstance.auth.canAuthorize
        println("canAuthorie is \(canAuthorie)")
        self.fetchingLoggedUserChannelInfo()
    }

    func fetchingLoggedUserChannelInfo() {
        let service: GTLService = self.youTubeService!

        var query: GTLQueryYouTube = GTLQueryYouTube.queryForChannelsListWithPart("snippet") as! GTLQueryYouTube
        query.mine = true

        service.executeQuery(query, completionHandler: {
            //GTLYouTubeChannel array
            (ticket, resultList, error) -> Void in

            println("error in fetchingLoggedUserChannelInfo is \(error)")

            if (error == nil) {
                let result = resultList as! GTLYouTubeChannelListResponse
                let array = result.items()
                if (array.count >= 1) {
                    let channel: GTLYouTubeChannel = array[0] as! GTLYouTubeChannel

                    YoutubeUserProfile.sharedInstance.saveLoggedUserChannel(channel)

                    if (self.delegate != nil) {
                        self.delegate?.endFetchingUserChannel(channel)
                    }

                    var subsriptions: NSMutableArray = []
                    self.fetchingLoggedUserSubscriptions(channel)
                }
            }
        })
    }

    func fetchingChannelList(channelID: NSString, completeHandler: ObjectHandler) {
        let service: GTLService = self.youTubeService!

        var query: GTLQueryYouTube = GTLQueryYouTube.queryForChannelsListWithPart("snippet") as! GTLQueryYouTube
        query.fields = "items/snippet(thumbnails)"
        query.identifier = channelID as String

        service.executeQuery(query, completionHandler: {
            //GTLYouTubeChannel array
            (ticket, resultList, error) -> Void in

            if (error == nil) {
                let result = resultList as! GTLYouTubeChannelListResponse
                let array = result.items()
                if (array.count >= 1) {
                    let channel = array[0] as! GTLYouTubeChannel
                    completeHandler(channel, true)
                }
            } else {
                completeHandler(nil, false)
            }

        })
    }

    func fetchingLoggedUserSubscriptions(channel: GTLYouTubeChannel) {
        let service: GTLService = self.youTubeService!

        var query: GTLQueryYouTube = GTLQueryYouTube.queryForSubscriptionsListWithPart("id,snippet") as! GTLQueryYouTube
        query.maxResults = 50 // used (important)
        query.channelId = channel.identifier
        query.fields = "items/snippet(title,resourceId,thumbnails),nextPageToken"

        service.executeQuery(query, completionHandler: {
            // GTLYouTubeSubscription array
            (ticket, resultList, error) -> Void in

            if (error == nil) {
                let result = resultList as! GTLYouTubeSubscriptionListResponse
                let array = result.items()
                if (self.delegate != nil) {
                    self.delegate?.endFetchingUserSubscriptions(array)
                }
            }
        })

    }

    // Mark : searchList


    func prepareRequestSearch(queryTeam: NSString, completeHandler: ObjectHandler) -> YTYoutubeRequestInfo {
        var requestInfo: YTYoutubeRequestInfo = YTYoutubeRequestInfo()

        requestInfo.makeRequestForSearchWithQueryTeam(queryTeam)
        search(requestInfo, completeHandler: completeHandler)

        return requestInfo
    }

    func prepareFetchingRelativeVideos(relatedToVideoId: NSString, completeHandler: ObjectHandler) -> YTYoutubeRequestInfo {
        var requestInfo: YTYoutubeRequestInfo = YTYoutubeRequestInfo()

        requestInfo.makeRequestForRelatedVideo(relatedToVideoId)
        search(requestInfo, completeHandler: completeHandler)

        return requestInfo
    }


    func search(requestInfo: YTYoutubeRequestInfo, completeHandler: ObjectHandler) {

        MABYT3_APIRequest.sharedInstance().searchForParameters(requestInfo.parameters, completion: {
            (responseInfo, error) -> Void in

            if (error == nil) {
                // 2
                let videoIds: NSString = YoutubeParser.getVideoIdsBySearchResult(responseInfo.array)

                self.fetchVideoListWithVideoId(videoIds, completeHandler: {
                    (object, sucess) -> Void in

                    if (sucess == true) {
                        // 1. pageToken
                        requestInfo.putNextPageToken(responseInfo.pageToken)
                        // 2. array of YoutubeVideoCache
                        completeHandler(object, true)
                    } else {
                        completeHandler(nil, false)
                    }
                })

            } else {
                completeHandler(nil, false)
            }
        })
    }

    // MARK : Videos.List
    func fetchVideoListWithVideoId(videoIds: NSString, completeHandler: ObjectHandler) {
        var parameters = [
                "part": "id,snippet,contentDetails,statistics",
                "id": videoIds,
        ]

        fetchVideoList(parameters, completeHandler: completeHandler)
    }

    func fetchVideoDescription(videoId: NSString, completeHandler: ObjectHandler) {
        var parameters = [
                "part": "snippet, statistics",
                "id": videoId,
        ]

        fetchVideoList(parameters, completeHandler: completeHandler)
    }

    func fetchVideoList(_parameters: NSDictionary, completeHandler: ObjectHandler) {

        MABYT3_APIRequest.sharedInstance().LISTVideosForURL(NSMutableDictionary(dictionary: _parameters), completion: {
            (responseInfo, error) -> Void in
            if (error == nil) {
                completeHandler(responseInfo.array, true)
            } else {
                completeHandler(nil, false)
            }
        })
    }

    // MARK : thumbnail
    func fetchChannelForPageChannel(channelID: NSString, completeHandler: ObjectHandler) {
        self.fetchChannelWithChannelId(channelID, part: "statistics,brandingSettings", fields: "items(brandingSettings,statistics)", completeHandler: {
            (object, sucess) -> Void in

            if (sucess == true) {
                let array = object as! NSArray
                if (array.count >= 1) {
                    let channel = array[0] as! MABYT3_Channel
                    completeHandler(channel, true)
                } else {
                    completeHandler(nil, false)
                }
            } else {
                completeHandler(nil, false)
            }
        })

    }

    func fetchChannelForUploadsIds(channelIDs: NSString, completeHandler: ObjectHandler) {
        let fields = "items/contentDetails"
        fetchChannelWithChannelId(channelIDs, part: "contentDetails", fields: fields, completeHandler: completeHandler)
    }

    func fetchChannelForThumbnail(channelID: NSString, completeHandler: ObjectHandler) {
        let fields = "items/snippet(thumbnails)"
        fetchChannelWithChannelId(channelID, part: "snippet", fields: fields, completeHandler: completeHandler)
    }

    // return MABYT3_Channel
    func fetchChannelWithChannelId(channelID: NSString, part: String, fields: String, completeHandler: ObjectHandler) {
        var parameters = NSMutableDictionary(dictionary: [
                "part": part,
                "fields": fields,
                "id": channelID,
        ]
        )

        MABYT3_APIRequest.sharedInstance().LISTChannelsThumbnailsForURL(parameters, completion: {
            (responseInfo, error) -> Void in
            if (error == nil) {
                completeHandler(responseInfo.array, true)
            } else {
                completeHandler(nil, false)
            }
        })
    }

    // MARK: PlayList
    func fetchPlayListWithPlayListId(playlistID: NSString, completeHandler: ObjectHandler) {
        let fields = "items/snippet"
        fetchPlayListWithPlayListId(playlistID, part: "snippet", fields: fields, completeHandler: completeHandler)
    }

    // MABYT3_PlayList
    func fetchPlayListWithPlayListId(playlistID: NSString, part: String, fields: String, completeHandler: ObjectHandler) {
        var parameters = NSMutableDictionary(dictionary: [
                "part": part,
                "fields": fields,
                "id": playlistID,
        ]
        )

        MABYT3_APIRequest.sharedInstance().LISTPlayListForURL(parameters, completion: {
            (responseInfo, error) -> Void in
            if (error == nil) {
                completeHandler(responseInfo.array, true)
            } else {
                completeHandler(nil, false)
            }
        })
    }


}