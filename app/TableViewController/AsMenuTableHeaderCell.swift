//
//  AsMenuTableRowCell.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/19/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import UIKit

class AsMenuTableHeaderCell :ASCellNode{
    
    let ICON_HEIGHT:CGFloat = 26.0
    let TITLE_FONT_SIZE:CGFloat = 16
    
    var _nodeCellSize:CGSize?;
    var _videoChannelThumbnailsNode:ASImageNode?;
    var _channelTitleTextNode:ASTextNode?;
    
    init(nodeCellSize: CGSize) {
        super.init()
        
        _nodeCellSize = nodeCellSize
        
        
        // 3
        self.backgroundColor = UIColor.clearColor()
    }
    
    func calculateSizeThatFits(constrainedSize:CGSize )->CGSize{
        return _nodeCellSize!
    }
    
    
    
    func layout(){
        
        var height = _nodeCellSize?.height
        
        var vLeft:CGFloat = 16.0
        var vTop = (height! - ICON_HEIGHT)/2
        
    }
    
    
    
}
