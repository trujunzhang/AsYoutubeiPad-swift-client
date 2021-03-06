//
//  YoutubeFetchActivityListTests.swift
//  appRestApp
//
//  Created by djzhang on 4/29/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit
import XCTest

import Nimble

class YoutubeFetchActivityListTests: YoutubeFetcherBase, RetrievingItemsFetchingHelperDelegate {
    var expectation: XCTestExpectation?

    func testFetchingNesestVideoIdsFromGTLActivitylList() {
        expectation = expectationWithDescription("fetchActivityListOnHomePage")

        let helper: YoutubeRetrievingGTLActivityListItemsFetcherHelper = YoutubeRetrievingGTLActivityListItemsFetcherHelper()
        helper.delegate = self

        helper.startFetchingItems()

        waitForExpectationsWithTimeout(200) {
            (error) in
            XCTAssertNil(error, "\(error)")
        }
    }


    func endFetchingAllItems(array: NSArray) {
        println("count of array in endFetchingAllItems  is \(array.count)")

        let sortedArray = YoutubeParser.filterSnippetTypeIsUploadInGTLActivity(array)
        let newestVideoIdsArray = YoutubeParser.getVideoIdsArrayByGTLActivityList(sortedArray)

        println("count of sortedArray is \(sortedArray.count)")
        println("newestVideoIdsArray is \(newestVideoIdsArray)")

        expectation!.fulfill()
//        self.checkFetchingNewestVideoIDSResult(array, sucess: true)
    }

    func checkFetchingNewestVideoIDSResult(object: AnyObject, sucess: Bool) {
        self.isSucess = sucess

        expect(sucess).to(beTrue())

        if (sucess == true) {
            var array: NSArray = object as! NSArray

            expect(array).toNot(beEmpty())

            let firstObject: AnyObject = array[0]
            expect(firstObject is YoutubeVideoCache).to(beTrue())

            var channel: YoutubeVideoCache = firstObject as! YoutubeVideoCache
        }
    }


}
