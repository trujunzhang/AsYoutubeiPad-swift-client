//
//  AsNodeMaker.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/24/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


class AsNodeMaker: NSObject {
    class func makeNodeText() -> ASTextNode {
        var node:ASTextNode = ASTextNode()
        node.placeholderColor = UIColor.clearColor()
        
        return node
    }
    
}