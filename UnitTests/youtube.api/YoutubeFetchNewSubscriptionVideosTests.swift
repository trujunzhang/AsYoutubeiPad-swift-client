//
//  YoutubeFetchNewSubscriptionVideosTests.swift
//  appRestApp
//
//  Created by djzhang on 4/28/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

import UIKit
import XCTest

// http://stackoverflow.com/questions/19640796/retrieving-all-the-new-subscription-videos-in-youtube-v3-api

//Retrieving all the new subscription videos in YouTube v3 API
//You can retrieve this information with the Youtube V3 API but it is incredibly inefficient:
//
//1, First get the channel ID from the username (one request).
//2, Now get the subscriptions for the channel (batchable - one request per 50 subs).
//3, Now get the playlists for each subscribed channel (batchable - one request per 50 subs).
//4, Get the most recent playlistItems for the "uploads" system playlist of each channel. (one request per sub).
//5, Get the video related to each playlistItem (batchable - one request 50 playlistItems).
//
//You can now sort the videos by publishing date and print the most recent.

class YoutubeFetchNewSubscriptionVideosTests: YoutubeFetcherBase, RetrievingItemsFetchingHelperDelegate {
    var expectation: XCTestExpectation?

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }


    func _testFetchingUploadsIdFromChannelList() {
        let expectation = expectationWithDescription("FetchingUploadsIdFromChannelList")

        let helper: YoutubeRetrievingNewSubscriptionVideosFetcherHelper = YoutubeRetrievingNewSubscriptionVideosFetcherHelper()
        helper.delegate = self
        helper.startFetchingItems(subscribedChannelIds)

        waitForExpectationsWithTimeout(400) {
            (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    // MARK: RetrievingItemsFetchingHelperDelegate
    func endFetchingAllItems(array: NSArray) {
        // of GTLYouTubeChannel

//        println("Array in endFetchingNewSubscriptionVideos is \(array)")

        let uploadIds = YoutubeParser.getUploadIdsArrayInContentDetailsFromGTLChannelList(array)

        startFetchingPlayListItems(uploadIds)
    }

    func startFetchingPlayListItems(array: NSArray) {
        let helper: YoutubeRetrievingPlayListItemsFetcherHelper = YoutubeRetrievingPlayListItemsFetcherHelper()
        helper.delegate = self
        helper.startFetchingItems(array)
    }

    // MARK: RetrievingPlayListItemsFetchingHelperDelegate
    func endFetchingPlayListItems(array: NSArray) {

        println("Array in endFetchingPlayListItems is \(array.count)")

        let x = 0
    }

}
