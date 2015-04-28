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
    
    func testFetchChannelForThumbnail(){
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
//
//    func testFetchChannelForUploadsIds(){
//        let expectation = expectationWithDescription("fetchChannelForUploadsIds")
//
//        YoutubeFetcher.sharedInstance.fetchChannelForUploadsIds(channelIDs, completeHandler: { (object, sucess) -> void in
//
//            xctassertnotnil(object, "object not nil")
//
//            self.issucess = sucess
//
//            if(sucess == true){
//                var array:nsarray = object as! nsarray
//
//                xctasserttrue(array.count == 1, "array length must be one")
//
//                xctasserttrue(array[0] is mabyt3_channel, "array object must be mabyt3_channel")
//
//                var channel :mabyt3_channel = array[0] as! mabyt3_channel
//                var imageurl = youtubemodelparser.getmabchannelthumbnalurl(channel)
//                xctassertnotnil(imageurl, "imageurl must not nil")
//            }
//            expectation.fulfill()
//
//        })
//
//        waitForExpectationsWithTimeout(10) { (error) in
//            XCTAssertNil(error, "\(error)")
//        }
//    }



}
