//
//  YoutubeRetrievingPlayListItemsFetcherHelper.swift
//  appRestApp
//
//  Created by djzhang on 4/30/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


//
//protocol RetrievingPlayListItemsFetchingHelperDelegate {
////    func failureFetchingNewsSubscriptionVideos()
//
//    func endFetchingNewSubscriptionVideos(array: NSArray)
//}
//
//class YoutubeRetrievingPlayListItemsFetcherHelper: NSObject, RetrievingPlayListItemsFetchingDelegate {
//    var delegate: RetrievingPlayListItemsFetchingHelperDelegate?
//    var channelIDsArray: NSArray?
//    var fetchingStep: Int = 0
//
//    var fetchedChannels: NSMutableArray = NSMutableArray()
//    var youtubeRetrievingPlayListItemsFetcher: YoutubeRetrievingPlayListItemsFetcher?
//
//    func startFetchingNewSubscriptionVideos(channelIDsArray: NSArray) {
//        self.channelIDsArray = channelIDsArray
//
//        youtubeRetrievingPlayListItemsFetcher = YoutubeRetrievingPlayListItemsFetcher()
//        if let newSubscriptionVideosFetcher: YoutubeRetrievingPlayListItemsFetcher = youtubeRetrievingPlayListItemsFetcher {
//            newSubscriptionVideosFetcher.delegate = self
//        }
//
//        fetchingNextStep()
//    }
//
//    func fetchingNextStep() {
//        if (fetchingStep == channelIDsArray!.count) {
//            if (self.delegate != nil) {
//                self.delegate!.endFetchingNewSubscriptionVideos(fetchedChannels)
//            }
//            return
//        }
//
//        let object: AnyObject? = self.channelIDsArray?.objectAtIndex(fetchingStep)
//        var channelIDs: NSString = object as! NSString
//        fetchingStep++
//
//        if let newSubscriptionVideosFetcher: YoutubeRetrievingPlayListItemsFetcher = youtubeRetrievingPlayListItemsFetcher {
//            newSubscriptionVideosFetcher.fetchingNextUploadsIdFromChannelList(channelIDs)
//        }
//    }
//
//
//
//    // MARK: RetrievingPlayListItemsFetchingDelegate
//    func nextFetching(array: NSObject) {
//        let channels = array as! [AnyObject]
//        fetchedChannels.addObjectsFromArray(channels)
//
////        println("Result in nextFetching is \(channels)")
//
//        fetchingNextStep()
//    }
//}