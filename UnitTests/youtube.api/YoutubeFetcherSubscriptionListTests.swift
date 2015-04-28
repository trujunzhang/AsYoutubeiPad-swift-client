//
//  YoutubeFetcherSubscriptionListTests.swift
//  appRestApp
//
//  Created by djzhang on 4/28/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import XCTest

class YoutubeFetcherSubscriptionListTests: YoutubeFetcherBase, AuthorUserFetchingDelegate {
    var expectation:XCTestExpectation?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func _testRetrievingSubscriptionList() {
        expectation = expectationWithDescription("retrievingSubscriptionList")
        
        YoutubeFetcher.sharedInstance.delegate = self
        let hasLogin = YoutubeUserProfile.sharedInstance.hasLogin()
        XCTAssertTrue(hasLogin == true, "Before testing fetching subscription list, must login first")
        
        if (hasLogin == true) {
            YoutubeFetcher.sharedInstance.initLoggedUser()
        }
        
        waitForExpectationsWithTimeout(20) { (error) in
            XCTAssertNil(error, "\(error)")
        }
    }
    
    // MARK: AuthorUserFetchingDelegate
    func endFetchingUserChannel(channel: GTLYouTubeChannel) {
        let x = 0
        
    }
    
    func endFetchingUserSubscriptions(array: NSArray) {
        expectation!.fulfill()
        
        
    }
}
