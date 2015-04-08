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
    
    func _testParseSubtitle() {
        
    }
    
    
    // MARK : check parse result
    func checkParseSRTFromFile(fileName: String,expect:Int){
        let subtitleString : String = readFile(fileName)
        
        checkParseSRTFromString(subtitleString, expect: expect)
    }
    
    func checkParseSRTFromString(subtitleString: String,expect:Int){
        
        let soSubtitle:SOSubtitle = SOSubtitle()
        let task:BFTask = soSubtitle.subtitleWithString(subtitleString, error: nil)
        
        let resultSubtitle:SOSubtitle = task.result as SOSubtitle
        let array : NSMutableArray = resultSubtitle.subtitleItems
        
        XCTAssertEqual(array.count, expect, "the same length")
    }
    
    // MARK : Utils for parsing subtitle
    func readFile(fileName: String) -> String {
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "srt")
        var data = String(contentsOfFile:path!, encoding: NSUTF8StringEncoding, error: nil)
        
        return data!
    }
    
    
}
