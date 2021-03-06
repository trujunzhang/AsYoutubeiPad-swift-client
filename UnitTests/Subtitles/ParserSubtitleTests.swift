//
//  ParserSubtitleTests.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/8/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//


import Foundation

import UIKit
import XCTest

class ParserSubtitleTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testParseSubtitle() {
        let expect  = 1923
        
        let fileName = "An_Angular2_Todo_App-First_look_at_App_Development_in_Angular2"
        
        let  array :NSMutableArray = Tools.checkParseSRTFromFile(fileName, expect: expect)
         XCTAssertEqual(array.count, expect, "The same length")
    }

    
}
