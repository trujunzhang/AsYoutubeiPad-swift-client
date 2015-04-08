//
//  YoutubeDataFetcherForCaptionTests.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/8/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit
import XCTest

class YoutubeDataFetcherForCaptionTests: XCTestCase {
    
    var isSucess = false
    var videoID :NSString = "uD6Okha_Yj0"
    var videoEmptyID :NSString = "eoXneK3WIgQ"
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK : Test captain empty tracks
    
    func _testFetchCaptainEmptyTracks() {
        let expectation = expectationWithDescription("fetchCaptainEmptyTracks")
        
        YoutubeDataFetcher.sharedInstance.fetchCaptainTracks(videoEmptyID, completeHandler: { (tracksArray, sucess) -> Void in
            
            XCTAssertNotNil(tracksArray, "object not nil")
            
            self.isSucess = sucess
            
            if(sucess == true){
                var array:NSArray = tracksArray as NSArray
                
                XCTAssertTrue(array.count == 0, "Array length must be empty") // Returned empty array
            }
            expectation.fulfill()
            
        })
        
        waitForExpectationsWithTimeout(10) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }
    
    // MARK : Test captain tracks
    
    func testFetchCaptainTracks() {
        let expectation = expectationWithDescription("fetchCaptainTracks")
        
        YoutubeDataFetcher.sharedInstance.fetchCaptainTracks(videoID, completeHandler: { (tracksArray, sucess) -> Void in
            
            XCTAssertNotNil(tracksArray, "object not nil")
            
            self.isSucess = sucess
            
            if(sucess == true){
                var array:NSArray = tracksArray as NSArray
                
                XCTAssertTrue(array.count > 1, "Array length must great than one")
                
                XCTAssertTrue(array[0] is MABYT3_Track, "Array object must be MABYT3_Track")
                
                var track :MABYT3_Track = array[0] as MABYT3_Track
                var lang_default: Bool = track.lang_default
                
                XCTAssertTrue(lang_default, "The first object must be the default track")
            }
            expectation.fulfill()
            
        })
        
        waitForExpectationsWithTimeout(40) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }
    
    // MARK : Test fetching subtitle.
    
    func testFetchCaptainForVideo() {
        let expectation = expectationWithDescription("fetchCaptainForVideo")
        
        var track :MABYT3_Track = MABYT3_Track()
        
        YoutubeDataFetcher.sharedInstance.fetchCaptainForVideo(videoID, defaultTrack: track, completeHandler: { (subtitleString, sucess) -> Void in
            
            XCTAssertNotNil(subtitleString, "object not nil")
            
            self.isSucess = sucess
            
            if(sucess == true){
                XCTAssertTrue(subtitleString is NSString, "Array object must be NSString")
                
                var subtitle:NSString = subtitleString as NSString
                XCTAssertFalse(subtitle.isEqualToString(""), "Array object must be NSString")
                
            }
            expectation.fulfill()
            
        })
        
        waitForExpectationsWithTimeout(40) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }
    
    
}
