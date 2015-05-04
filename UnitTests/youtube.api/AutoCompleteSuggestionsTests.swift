//
//  AutoCompleteSuggestionsTests.swift
//  appRestApp
//
//  Created by djzhang on 5/4/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


import UIKit
import XCTest


class AutoCompleteSuggestionsTests: YoutubeFetcherBase {

    func testAutoCompleteSuggestionsWithSearchWish() {

        let expectation = expectationWithDescription("autoCompleteSuggestionsWithSearchWish")

        YoutubeDataFetcher.sharedInstance.autoCompleteSuggestionsWithSearchWish("sketch 3", completeHandler: {
            (subtitleString, sucess) -> Void in

            XCTAssertNotNil(subtitleString, "object not nil")

            self.isSucess = sucess

            if (sucess == true) {
                XCTAssertTrue(subtitleString is NSString, "Array object must be NSString")

                var subtitle: NSString = subtitleString as! NSString
                XCTAssertFalse(subtitle.isEqualToString(""), "Array object must be NSString")

                let expect = 1923
//                let  array : NSMutableArray = Tools.checkParseSRTFromString(subtitle, expect: expect) // TODO djzhang (2015-04-24)
//                XCTAssertEqual(array.count, expect, "The same length")
            }
            expectation.fulfill()

        })

        waitForExpectationsWithTimeout(40) {
            (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

}