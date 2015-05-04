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
import Nimble

class AutoCompleteSuggestionsTests: YoutubeFetcherBase {

    func testAutoCompleteSuggestionsWithSearchWish() {

        let expectation = expectationWithDescription("autoCompleteSuggestionsWithSearchWish")

        YoutubeDataFetcher.sharedInstance.autoCompleteSuggestionsWithSearchWish("sketch 3", completeHandler: {
            (object, sucess) -> Void in

            expect(sucess).to(beTrue())

            if (sucess == true) {
                expect(object as! NSArray).toNot(beEmpty())
            }
            expectation.fulfill()

        })

        waitForExpectationsWithTimeout(40) {
            (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

}