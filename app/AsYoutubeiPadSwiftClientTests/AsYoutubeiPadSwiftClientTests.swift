//
//  AsYoutubeiPadSwiftClientTests.swift
//  AsYoutubeiPadSwiftClientTests
//
//  Created by djzhang on 3/15/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit
import XCTest

class AsYoutubeiPadSwiftClientTests: XCTestCase {
    
    func testSwiftInSwift()
    {
        var xy=SubscriptionsViewController()
        
        var swift = MySwiftClass()
        XCTAssertEqual(swift.swiftString, "swift", "error")
    }
    
//    func testOBJCInSwift()
//    {
//        var swift = MySwiftClass()
//        XCTAssertEqual(swift.objcString, "objc", "error")
//    }
//    
//    func testOBJCInOBJC()
//    {
//        var objc = MyOBJCClass()
//        XCTAssertEqual(objc.objcStrng, "objc", "error")
//    }
//    
//    func testSwiftInOBJC()
//    {
//        var objc = MyOBJCClass()
//        XCTAssertEqual(objc.swiftString, "swift", "error")
//    }
    
}
