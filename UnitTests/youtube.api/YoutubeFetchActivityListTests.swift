//
//  YoutubeFetchActivityListTests.swift
//  appRestApp
//
//  Created by djzhang on 4/29/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//


import Foundation
import XCTest

class YoutubeFetchActivityListTests: YoutubeFetcherBase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }


    func testFetchActivityListOnHomePage() {
        let expectation = expectationWithDescription("fetchActivityListOnHomePage")

        YoutubeFetcher.sharedInstance.fetchActivityListOnHomePage({
            (object, sucess) -> Void in

            XCTAssertNotNil(object, "object not nil")

            self.isSucess = sucess

            if (sucess == true) {
                var array: NSArray = object as! NSArray

                XCTAssertTrue(array.count != 0, "Array length must be one")

                XCTAssertTrue(array[0] is MABYT3_Activity, "Array object must be MABYT3_Channel")

                var channel: GTLYouTubeActivity = array[0] as! GTLYouTubeActivity
//                var uploadsId = YoutubeParser.getChannelUploadsAsPlaylistId(channel)

//                XCTAssertTrue(uploadsId == "UUbn1OgGei-DV7aSRo_HaAiw", "uploadsId must be UUbn1OgGei-DV7aSRo_HaAiw")
            }
            expectation.fulfill()

        })

        waitForExpectationsWithTimeout(10) {
            (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

}
