//
//  YoutubeFetcherTests.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/26/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//


import XCTest


class YoutubeFetcherTests: XCTestCase {
    var requestInfo = YTYoutubeRequestInfo()
    var isSucess = false
    
    var videoID :NSString = "eoXneK3WIgQ"
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        isSucess = false
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
        
    func _testFetchChannelForThumbnail(){
        let expectation = expectationWithDescription("fetchChannelForThumbnail")
        
        YoutubeFetcher.sharedInstance.fetchChannelForThumbnail("UCl-radPCbXcrYCE4EdNH3QA", completeHandler: { (object, sucess) -> Void in
            
            XCTAssertNotNil(object, "object not nil")
            
            self.isSucess = sucess
            
            if(sucess == true){
                var array:NSArray = object as NSArray
                
                XCTAssertTrue(array.count == 1, "Array length must be one")
                
                XCTAssertTrue(array[0] is MABYT3_Channel, "Array object must being MABYT3_Channel")
                
                var channel :MABYT3_Channel = array[0] as MABYT3_Channel
                var imageUrl = YoutubeModelParser.getMABChannelThumbnalUrl(channel)
                XCTAssertNotNil(imageUrl, "imageUrl must not nil")
            }
            expectation.fulfill()
            
        })
        
        waitForExpectationsWithTimeout(10) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }
    
    func _testFetchVideoDescription(){
        let expectation = expectationWithDescription("fetchVideoDescription")
        
        YoutubeFetcher.sharedInstance.fetchVideoDescription(videoID, completeHandler: { (object, sucess) -> Void in
            
            XCTAssertNotNil(object, "object not nil")
            
            self.isSucess = sucess
            
            if(sucess == true){
                var array:NSArray = object as NSArray
                
                XCTAssertTrue(array.count == 1, "Array length must be one")
                
                XCTAssertTrue(array[0] is YoutubeVideoCache, "Array object must being YoutubeVideoCache")
                
                var videoCache :YoutubeVideoCache = array[0] as YoutubeVideoCache
                var description = YoutubeParser.getVideoDescription(videoCache)
                XCTAssertNotNil(description, "description must not nil")
            }
            expectation.fulfill()
            
        })
        
        waitForExpectationsWithTimeout(10) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }
    
    
}
