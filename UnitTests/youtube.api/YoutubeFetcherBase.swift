//
//  YoutubeFetcherTests.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/26/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//


import XCTest


class YoutubeFetcherBase: XCTestCase {

    var requestInfo = YTYoutubeRequestInfo()
    var isSucess = false

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        requestInfo = YTYoutubeRequestInfo()
        isSucess = false
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

}
