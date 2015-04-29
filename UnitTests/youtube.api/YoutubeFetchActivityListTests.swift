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
    var expectation: XCTestExpectation?

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



        waitForExpectationsWithTimeout(20) {
            (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

}
