//
//  YouTubeExtractorUtilsTests.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/4/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit
import XCTest

class YouTubeExtractorUtilsTests: YoutubeFetcherBaseTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testYoutubeExtractor() {
        
        let expectation = expectationWithDescription("YoutubeExtractor")
        
        YouTubeExtractorUtils.YoutubeExtractor(videoID, completeHandler: { (object, sucess) -> Void in
            
            XCTAssertNotNil(object, "object not nil")
            
            self.isSucess = sucess
            
            if(sucess == true){
                var array:NSArray = object as NSArray
                
                XCTAssertTrue(array.count > 0, "Array length must greater than 0")
                
                let model:AnyObject = array[0]
                let youtubeVideo:IGYouTubeVideo = model  as IGYouTubeVideo // Used
                XCTAssertTrue(model is IGYouTubeVideo, "Array object must being IGYouTubeVideo")
                
                let url:NSString = youtubeVideo.videoURL.URLString
                
                XCTAssertFalse(url.isEqualToString(""), "url object must not nil")
                                
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
