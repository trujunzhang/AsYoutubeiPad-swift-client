//
//  YoutubeFetcherTests.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/26/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//


import XCTest


class YoutubeFetcherTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func _testFetchingChannelList() {
        let expectation = expectationWithDescription("fetchingChannelList")
        
        YoutubeFetcher.sharedInstance.fetchingChannelList("UC0wObT_HayGfWLdRAnFyPwA", completeHandler: { (object, sucess) -> Void in
            var channel :GTLYouTubeChannel = object as GTLYouTubeChannel
            var imageUrl = channel.snippet.thumbnails.high
            
            expectation.fulfill()
            
        })
        
        waitForExpectationsWithTimeout(10) { (error) in
            XCTAssertNil(error, "\(error)")
        }
        
    }
    
    func testSearchVideosByVideoType() {
        let expectation = expectationWithDescription("SearchVideoListByVideoType")
        
        var requestInfo: GYoutubeRequestInfo =
        YoutubeFetcher.sharedInstance.prepareRequestSearch("sketch 3", completeHandler: { (object, sucess) -> Void in
            var array:NSArray = object as NSArray
            
            var length = array.count
            
            XCTAssertGreaterThan(length, 0, "Array length must greater than 0")
            
            XCTAssertEqual(array[0] is YoutubeVideoCache, true, "Array object must being YoutubeVideoCache")
            var videoCache:YoutubeVideoCache = array[0] as YoutubeVideoCache
            
            expectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(10) { (error) in
            XCTAssertNil(error, "\(error)")
            var pageToken = requestInfo.getPageToken()
            
            XCTAssertNotNil(pageToken, "pageToken not nil")
        }
        
    }
    
    
    
}
