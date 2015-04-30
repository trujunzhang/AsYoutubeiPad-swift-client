//
//  YoutubeFetcherPlayListItemTests.swift
//  appRestApp
//
//  Created by djzhang on 4/28/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import XCTest

class YoutubeFetcherPlayListTests: YoutubeFetcherBase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }


    func _testFetchPlayListWithPlayListId() {
        let expectation = expectationWithDescription("fetchPlayListWithPlayListId")

        YoutubeFetcher.sharedInstance.fetchPlayListItemWithPlayListId(playlistID, completeHandler: {
            (object, sucess) -> Void in

            XCTAssertNotNil(object, "object not nil")

            self.isSucess = sucess

            if (sucess == true) {
                var array: NSArray = object as! NSArray

                XCTAssertTrue(array.count >= 1, "Array length must be one")

                XCTAssertTrue(array[0] is MABYT3_PlayListItem, "Array object must be MABYT3_PlayListItem")

                var channel: MABYT3_PlayListItem = array[0] as! MABYT3_PlayListItem
//                var imageUrl = YoutubeModelParser.getMABChannelThumbnalUrl(channel)
//                XCTAssertNotNil(imageUrl, "imageUrl must not nil")
            }
            expectation.fulfill()

        })

        waitForExpectationsWithTimeout(10) {
            (error) in
            XCTAssertNil(error, "\(error)")
        }
    }


    func _testFetchGTLPlayListItems() {
        let expectation = expectationWithDescription("fetchGTLPlayListItems")

        YoutubeFetcher.sharedInstance.fetchGTLPlayListItems(playlistID, completeHandler: {
            (object, sucess) -> Void in

            XCTAssertNotNil(object, "object not nil")

            self.isSucess = sucess

            if (sucess == true) {
                var array: NSArray = object as! NSArray

                XCTAssertTrue(array.count >= 1, "Array length must be one")

                XCTAssertTrue(array[0] is GTLYouTubePlaylistItem, "Array object must be GTLYouTubePlaylistItem")

                var channel: GTLYouTubePlaylistItem = array[0] as! GTLYouTubePlaylistItem
//                var imageUrl = YoutubeModelParser.getMABChannelThumbnalUrl(channel)
//                XCTAssertNotNil(imageUrl, "imageUrl must not nil")
            }
            expectation.fulfill()

        })

        waitForExpectationsWithTimeout(10) {
            (error) in
            XCTAssertNil(error, "\(error)")
        }
    }
}
