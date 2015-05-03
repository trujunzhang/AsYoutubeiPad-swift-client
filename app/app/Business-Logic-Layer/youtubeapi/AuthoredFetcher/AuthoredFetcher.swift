//
//  AuthoredFetcher.swift
//  appRestApp
//
//  Created by djzhang on 5/1/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class AuthoredFetcher: NSObject {

    var youTubeService: GTLServiceYouTube?
    var delegate: AuthorUserFetchingDelegate?

    class var sharedInstance: AuthoredFetcher {

        struct Singleton {
            static let instance = AuthoredFetcher()
        }

        return Singleton.instance
    }

    override init() {
        super.init()

        self.youTubeService = GTLServiceYouTube()
        if let theYouTubeService: GTLServiceYouTube = self.youTubeService {
            // public parameters
            theYouTubeService.shouldFetchNextPages = true
            theYouTubeService.retryEnabled = true
            theYouTubeService.APIKey = apiKey

            self.setupLoggedAuth()
        }

    }

    func initLoggedUser() {
        self.setupLoggedAuth()
        self.fetchingLoggedUserChannelInfo()
    }

    func setupLoggedAuth() {
        if (YoutubeUserProfile.sharedInstance.hasLogin() == false) {
            return
        }
        // authored parameters
        self.youTubeService?.authorizer = YoutubeUserProfile.sharedInstance.auth
        var canAuthorie = YoutubeUserProfile.sharedInstance.auth.canAuthorize
//        println("canAuthorie is \(canAuthorie)")
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

    func fetchingUploadsIdFromChannelList(channelIDs: NSString, completeHandler: ObjectHandler) {
        let service: GTLService = self.youTubeService!

        var query: GTLQueryYouTube = GTLQueryYouTube.queryForChannelsListWithPart("contentDetails") as! GTLQueryYouTube
        query.fields = "items/contentDetails(relatedPlaylists)"
        query.identifier = channelIDs as String

        service.executeQuery(query, completionHandler: {
            //GTLYouTubeChannel array
            (ticket, resultList, error) -> Void in

            println("error in fetchingUploadsIdFromChannelList is \(error)")

            if (error == nil) {
                let result = resultList as! GTLYouTubeChannelListResponse
                let array = result.items()
                if (array.count >= 1) {
                    completeHandler(array, true)
                } else {
                    completeHandler(nil, false)
                }
            } else {
                completeHandler(nil, false)
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


    // GTLYouTubeActivity
    func prepareFetchingActivityListOnHomePage(completeHandler: ObjectHandler) -> YTYoutubeRequestInfo {
        var requestInfo: YTYoutubeRequestInfo = YTYoutubeRequestInfo()

        requestInfo.makeRequestForActivityListOnHomePage()

        let publishedAfter: GTLDateTime = GTLYoutubeUtils.getPublishedAfterAsGTLDateTime()
        fetchGTLActivityListWithAccessToken(publishedAfter, completeHandler: completeHandler)

        return requestInfo
    }

    func fetchGTLActivityListWithAccessToken(publishedAfter: GTLDateTime, completeHandler: ObjectHandler) {
        let service: GTLService = self.youTubeService!

        var query: GTLQueryYouTube = GTLQueryYouTube.queryForActivitiesListWithPart("id,snippet,contentDetails") as! GTLQueryYouTube
        query.home = true
        query.maxResults = 50
        query.fields = "items/contentDetails,items/snippet(publishedAt,type),nextPageToken"
//        query.publishedAfter = publishedAfter

        //GTLYouTubeActivityListResponse
        service.executeQuery(query, completionHandler: {
            //GTLYouTubeActivity array
            (ticket, response, error) -> Void in

            println("error in fetchActivityList is \(error)")

            if (error == nil) {
                let responseInfo: GTLYouTubeActivityListResponse = response as! GTLYouTubeActivityListResponse
                let array = responseInfo.items()

                if (array.count >= 1) {
                    completeHandler(array, true)
                } else {
                    completeHandler(nil, false)
                }
            } else {
                completeHandler(nil, false)
            }
        })
    }

    func fetchGTLActivityListWithAccessTokenxxx(requestInfo: YTYoutubeRequestInfo, completeHandler: ObjectHandler) {

        let service: GTLService = self.youTubeService!

        var query: GTLQueryYouTube = GTLQueryYouTube.queryForActivitiesListWithPart("snippet,contentDetails") as! GTLQueryYouTube
        query.home = true
        query.maxResults = 50
        query.fields = "items/contentDetails,items/snippet(publishedAt),nextPageToken"

        //GTLYouTubeActivityListResponse
        service.executeQuery(query, completionHandler: {
            //GTLYouTubeActivity array
            (ticket, response, error) -> Void in

            println("error in fetchActivityList is \(error)")

            if (error == nil) {
                let responseInfo: GTLYouTubeActivityListResponse = response as! GTLYouTubeActivityListResponse
                let array = responseInfo.items()

                if (array.count >= 1) {
//                    let sortedArray = YoutubeParser.filterSnippetTypeIsUploadInGTLActivity(array)
//                    let videoIdsPages = YoutubeParser.getVideoIdsArrayByGTLActivityList(sortedArray)

                    // 1. store videoIds pages array
//                    requestInfo.videoIdsPages = videoIdsPages

                    // 2. Fetching the first page
//                    YoutubeFetcher.fetchVideoListWithVideoId(videoIdsPages[0] as! NSString, completeHandler: {
//                        (object, sucess) -> Void in
//
//                        if (sucess == true) {
//                            // 2. array of YoutubeVideoCache
//                            completeHandler(object, true)
//                        } else {
//                            completeHandler(nil, false)
//                        }
//                    })

                    requestInfo.putNextPageToken(responseInfo.nextPageToken)
                    completeHandler(array, true)
                } else {
                    completeHandler(nil, false)
                }
            } else {
                completeHandler(nil, false)
            }
        })
    }


    func fetchGTLPlayListItems(playlistID: NSString, completeHandler: ObjectHandler) {

        let service: GTLService = self.youTubeService!

        var query: GTLQueryYouTube = GTLQueryYouTube.queryForPlaylistItemsListWithPart("snippet,contentDetails") as! GTLQueryYouTube
        query.playlistId = playlistID as String
        query.maxResults = 5
//        query.fields = "items/contentDetails,items/snippet(publishedAt,channelId,type,title)"
        query.fields = "items/contentDetails,items/snippet(publishedAt,title)"

        service.executeQuery(query, completionHandler: {
            (ticket, resultList, error) -> Void in

            println("error in fetchGTLPlayListItems is \(error)")

            if (error == nil) {
                let result = resultList as! GTLYouTubePlaylistItemListResponse
                let array = result.items()

                if (array.count >= 1) {
                    completeHandler(array, true)
                } else {
                    completeHandler(nil, false)
                }
            } else {
                completeHandler(nil, false)
            }
        })
    }


}