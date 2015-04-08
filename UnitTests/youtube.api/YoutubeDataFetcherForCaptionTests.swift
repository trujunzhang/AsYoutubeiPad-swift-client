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
    
    func _testFetchCaptainEmptyTracks() {
        let expectation = expectationWithDescription("fetchCaptainEmptyTracks")
        
        YoutubeDataFetcher.sharedInstance.fetchCaptainTracks(videoEmptyID, completeHandler: { (object, sucess) -> Void in
            
            XCTAssertNotNil(object, "object not nil")
            
            self.isSucess = sucess
            
            if(sucess == true){
                var array:NSArray = object as NSArray
                
                XCTAssertTrue(array.count == 0, "Array length must be empty")
            }
            expectation.fulfill()
            
        })
        
        waitForExpectationsWithTimeout(10) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }
    
    func _testFetchCaptainTracks() {
        let expectation = expectationWithDescription("fetchCaptainTracks")
        
        YoutubeDataFetcher.sharedInstance.fetchCaptainTracks(videoID, completeHandler: { (object, sucess) -> Void in
            
            XCTAssertNotNil(object, "object not nil")
            
            self.isSucess = sucess
            
            if(sucess == true){
                var array:NSArray = object as NSArray
                
                XCTAssertTrue(array.count > 1, "Array length must great than one")
                
                XCTAssertTrue(array[0] is MABYT3_Track, "Array object must be MABYT3_Track")
                
                var track :MABYT3_Track = array[0] as MABYT3_Track
                var lang_default: Bool = track.lang_default
                
                XCTAssertTrue(lang_default, "The first object must be the default track")
            }
            expectation.fulfill()
            
        })
        
        waitForExpectationsWithTimeout(10) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }
    
    
    
}
