//
//  YouTubeExtractorUtilsTests.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/4/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit
import XCTest


class YouTubeExtractorUtilsTests: YoutubeFetcherBase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func _testYoutubeExtractor() {
        
        let expectation = expectationWithDescription("YoutubeExtractor")
        
        YouTubeExtractorUtils.YoutubeExtractor(videoID, completeHandler: { (object, sucess) -> Void in
            
            XCTAssertNotNil(object, "object not nil")
            
            self.isSucess = sucess
            
            if(sucess == true){
                var dict:[String:IGYouTubeVideo] = object as! Dictionary
                
                XCTAssertTrue(dict.count > 0, "dict length must greater than 0")
                
                let gVideo:IGYouTubeVideo = dict[YTVideoQualityStringSmall240]!
                
                XCTAssertNotNil(gVideo, "IGYouTubeVideo not nil")
                
                let videoURL:NSURL = gVideo.videoURL
//                let url:NSString = videoURL.URLString // TODO djzhang (2015-04-24)
//                XCTAssertFalse(url.isEqualToString(""), "url object must not nil")
                
                
            }
            expectation.fulfill()
            
        })
        
        waitForExpectationsWithTimeout(10) { (error) in
            XCTAssertNil(error, "\(error)")
            
            if(self.isSucess == true){
                
            }
            
        }
        
        
    }
    
    
}
