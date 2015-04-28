//
//  YoutubeFetcherForChannelTests.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/4/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit
import XCTest

class YoutubeFetcherForChannelTests: YoutubeFetcherBase {

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
            var channel :GTLYouTubeChannel = object as! GTLYouTubeChannel
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
                var array:NSArray = object as! NSArray

                XCTAssertTrue(array.count == 1, "Array length must be one")

                XCTAssertTrue(array[0] is MABYT3_Channel, "Array object must be MABYT3_Channel")

                var channel :MABYT3_Channel = array[0] as! MABYT3_Channel
                var imageUrl = YoutubeModelParser.getMABChannelThumbnalUrl(channel)
                XCTAssertNotNil(imageUrl, "imageUrl must not nil")
            }
            expectation.fulfill()

        })

        waitForExpectationsWithTimeout(10) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func testFetchChannelForUploadsIds(){
        let expectation = expectationWithDescription("fetchChannelForUploadsIds")

        YoutubeFetcher.sharedInstance.fetchChannelForUploadsIds(channelIDs, completeHandler: { (object, sucess) -> Void in

            XCTAssertNotNil(object, "object not nil")

            self.isSucess = sucess

            if(sucess == true){
                var array:NSArray = object as! NSArray

                XCTAssertTrue(array.count == 3, "Array length must be one")

                XCTAssertTrue(array[0] is MABYT3_Channel, "Array object must be MABYT3_Channel")

                var channel :MABYT3_Channel = array[0] as! MABYT3_Channel
                var imageUrl = YoutubeParser.getChannelUploadsAsPlaylistId(channel)
//                XCTAssertNotNil(imageUrl, "imageUrl must not nil")
            }
            expectation.fulfill()

        })

        waitForExpectationsWithTimeout(10) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }



}
