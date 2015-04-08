//
//  Tools.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/8/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class Tools: NSObject {
    
  class  func checkParseSRTFromString(subtitleString: String,expect:Int) ->NSMutableArray {
        
        let soSubtitle:SOSubtitle = SOSubtitle()
        let task:BFTask = soSubtitle.subtitleWithString(subtitleString, error: nil)
        
        let resultSubtitle:SOSubtitle = task.result as SOSubtitle
        let array : NSMutableArray = resultSubtitle.subtitleItems
        
        return array
    }
    
    // MARK : Utils for parsing subtitle
  class  func readFile(fileName: String) -> String {
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "srt")
        var data = String(contentsOfFile:path!, encoding: NSUTF8StringEncoding, error: nil)
        
        return data!
    }
    
   class func writeStringToFile(subtitleString :NSString){
        let file = "subtitleString.srt"
        
        if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String] {
            let dir = dirs[0] //documents directory
            let path = dir.stringByAppendingPathComponent(file)
            
            //writing
            subtitleString.writeToFile(path, atomically: false, encoding: NSUTF8StringEncoding, error: nil)
        }
    }
}