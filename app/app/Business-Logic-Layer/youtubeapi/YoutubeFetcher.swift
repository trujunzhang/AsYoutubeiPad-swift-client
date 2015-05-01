//
//  YoutubeFetcher.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/23/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


class YoutubeFetcher: NSObject {


    class func fetchingUploadsIdFromChannelListByChannelIdsArray(channelIDsArray: NSArray, completeHandler: ObjectHandler) {
        let channels: NSMutableArray = NSMutableArray()

        let count = channelIDsArray.count
        var fetchingStep = 0
        var channelIDs: NSString = channelIDsArray[fetchingStep] as! NSString

        self.fetchingNextUploadsIdFromChannelList(channelIDs, completeHandler: {
            (object, sucess) -> Void in

            if (sucess == true) {
                var array: NSArray = object as! NSArray

//                let count = array.count
//                println("channels count in fetchingUploadsIdFromChannelListByChannelIdsArray is \(count)")


            }
        })

    }

    class func fetchingNextUploadsIdFromChannelList(channelIDs: NSString, completeHandler: ObjectHandler) {
        AuthoredFetcher.sharedInstance.fetchingUploadsIdFromChannelList(channelIDs, completeHandler: {
            (object, sucess) -> Void in

            if (sucess == true) {
                var array: NSArray = object as! NSArray
//                let count = array.count
//                println("channels count in fetchingUploadsIdFromChannelListByChannelIdsArray is \(count)")
                completeHandler(object, true)
            }
        })
    }

    class func prepareFetchingRelativeVideos(relatedToVideoId: NSString, completeHandler: ObjectHandler) -> YTYoutubeRequestInfo {
        var requestInfo: YTYoutubeRequestInfo = YTYoutubeRequestInfo()

        requestInfo.makeRequestForRelatedVideo(relatedToVideoId)
        search(requestInfo, completeHandler: completeHandler)

        return requestInfo
    }


    // Mark : searchList
    class func prepareRequestSearch(queryTeam: NSString, completeHandler: ObjectHandler) -> YTYoutubeRequestInfo {
        var requestInfo: YTYoutubeRequestInfo = YTYoutubeRequestInfo()

        requestInfo.makeRequestForSearchWithQueryTeam(queryTeam)
        search(requestInfo, completeHandler: completeHandler)

        return requestInfo
    }


    class func search(requestInfo: YTYoutubeRequestInfo, completeHandler: ObjectHandler) {

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
    class func fetchVideoListWithVideoId(videoIds: NSString, completeHandler: ObjectHandler) {
        var parameters = [
                "part": "id,snippet,contentDetails,statistics",
                "id": videoIds,
        ]

        fetchVideoList(parameters, completeHandler: completeHandler)
    }

    class func fetchVideoDescription(videoId: NSString, completeHandler: ObjectHandler) {
        var parameters = [
                "part": "snippet, statistics",
                "id": videoId,
        ]

        fetchVideoList(parameters, completeHandler: completeHandler)
    }

    // YoutubeVideoCache
    class func fetchVideoList(_parameters: NSDictionary, completeHandler: ObjectHandler) {

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
    class func fetchChannelForPageChannel(channelID: NSString, completeHandler: ObjectHandler) {
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

    class func fetchVideoFromPlaylistItems(channelIDs: NSString, completeHandler: ObjectHandler) {
        self.fetchChannelForUploadsIds(channelIDs, completeHandler: {
            (object, sucess) -> Void in

            if (sucess == true) {
                var channels: NSArray = object as! NSArray
                let playlistIds: NSString = YoutubeParser.getUploadsIdsAsPlaylistIds(channels)

            }
        })
    }

    class func fetchChannelForUploadsIds(channelIDs: NSString, completeHandler: ObjectHandler) {
        let fields = "items/contentDetails"
        fetchChannelWithChannelId(channelIDs, part: "contentDetails", fields: fields, completeHandler: completeHandler)
    }

    class func fetchChannelForThumbnail(channelID: NSString, completeHandler: ObjectHandler) {
        let fields = "items/snippet(thumbnails)"
        fetchChannelWithChannelId(channelID, part: "snippet", fields: fields, completeHandler: completeHandler)
    }

    // return MABYT3_Channel
    class func fetchChannelWithChannelId(channelID: NSString, part: String, fields: String, completeHandler: ObjectHandler) {
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



    // MARK: youtube.activities.list
    class func fetchActivityListWithChannelId(channelId: NSString, completeHandler: ObjectHandler) {
        var parameters: NSMutableDictionary = [
                "part": "snippet,contentDetails",
                "fields": "items/contentDetails,items/snippet(publishedAt)",
                "maxResults": "2",
                "key": apiKey
        ]
        fetchActivityListWithoutAuth(parameters,completeHandler: completeHandler)
    }
    // MABYT3_Activity
    class func fetchActivityListWithoutAuth(parameters: NSMutableDictionary, completeHandler: ObjectHandler) {

        println("parameters is \(parameters)")

        MABYT3_APIRequest.sharedInstance().LISTActivitiesForURL(parameters, completion: {
            (responseInfo, error) -> Void in
            if (error == nil) {
                completeHandler(responseInfo.array, true)
            } else {
                completeHandler(nil, false)
            }
        })
    }

    // MARK : playlistItems.list
    class func fetchPlayListItemWithPlayListId(playlistID: NSString, completeHandler: ObjectHandler) {
        var parameters = NSMutableDictionary(dictionary: [
                "part": "snippet,contentDetails",
                "fields": "items/contentDetails,items/snippet(publishedAt,title)",
                "playlistId": playlistID,
                "maxResults": "5"
        ]
        )
        fetchPlayListItemWithDictionary(parameters, completeHandler: completeHandler)
    }

    // MABYT3_PlayList
    class func fetchPlayListItemWithDictionary(parameters: NSMutableDictionary, completeHandler: ObjectHandler) {
//        println("parameters is \(parameters)")

        MABYT3_APIRequest.sharedInstance().LISTPlayListItemForURL(parameters, completion: {
            (responseInfo, error) -> Void in
            if (error == nil) {
                completeHandler(responseInfo.array, true)
            } else {
                completeHandler(nil, false)
            }
        })
    }


}