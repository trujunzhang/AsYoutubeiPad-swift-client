//
//  YoutubeFetcherForVideos.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/4/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit
import XCTest

class YoutubeFetcherForVideosTests: YoutubeFetcherTests {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    
    func testSearchVideosByVideoType() {
        let expectation = expectationWithDescription("SearchVideoListByVideoType")
        
        var videoCache:YoutubeVideoCache? // used
        
        requestInfo =
            YoutubeFetcher.sharedInstance.prepareRequestSearch("sketch 3", completeHandler: { (object, sucess) -> Void in
                XCTAssertNotNil(object, "object not nil")
                
                self.isSucess = sucess
                
                if(sucess == true){
                    var array:NSArray = object as NSArray
                    
                    XCTAssertTrue(array.count > 1000, "Array length must greater than 0")
                    
                    let model:AnyObject = array[0]
                    videoCache = model  as YoutubeVideoCache // Used
                    XCTAssertTrue(model is YoutubeVideoCache, "Array object must being YoutubeVideoCache")
                    
                    self.requestInfo.appendArray(array)
                }
                expectation.fulfill()
            })
        
        waitForExpectationsWithTimeout(10) { (error) in
            XCTAssertNil(error, "\(error)")
            
            if(self.isSucess == true){
                var pageToken = self.requestInfo.getPageToken()
                XCTAssertNotNil(pageToken, "pageToken not nil")
                
                var length = self.requestInfo.getVideoListCount()
                XCTAssertTrue(length == 20, "fetching data length is equal")
                
                var expectVideoCache:YoutubeVideoCache = self.requestInfo.videoList[0] as YoutubeVideoCache
                var identifier = videoCache?.identifier
                XCTAssertEqual(identifier!, expectVideoCache.identifier, "the same YoutubeVideoCache")
            }
        }
    }


}
