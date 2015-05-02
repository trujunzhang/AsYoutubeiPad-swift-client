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

        let helper: YoutubeRetrievingActivityListItemsFetcherHelper = YoutubeRetrievingActivityListItemsFetcherHelper()
        helper.delegate = self

        let array = getSubscribedChannelIdsArray(subscribedChannelIds)
        helper.startFetchingItems(array)

        waitForExpectationsWithTimeout(100) {
            (error) in
            XCTAssertNil(error, "\(error)")
        }
    }

    func getSubscribedChannelIdsArray(subscribedChannelIds: NSArray) -> NSMutableArray {
        let array: NSMutableArray = NSMutableArray()
        for line in subscribedChannelIds {
            let lineString = line as! String
            var fullNameArr = split(lineString) {
                $0 == ","
            }
//            println("fullNameArr is \(fullNameArr)")
            array.addObjectsFromArray(fullNameArr)
        }
//        println("array is \(array)")
        return array;
    }

    func endFetchingAllItems(array: NSArray) {
        let sortedArray = YoutubeParser.sortNewestVideoListInActivityList(array)
        let newestVideoIdsArray = YoutubeParser.getNewestVideoIdsArrayByMABActivityList(sortedArray)

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
