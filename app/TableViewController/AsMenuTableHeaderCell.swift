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
    
    init(nodeCellSize: CGSize, title: String, iconUrl: String, isRemoteImage: Bool) {
        super.init()
        
        // 1
        makeImageNode(iconUrl, isRemoteImage: isRemoteImage)
        self.addSubnode(_videoChannelThumbnailsNode)
        
        // 2
        _nodeCellSize = nodeCellSize
        _channelTitleTextNode = ASTextNode()
        
        let textStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as NSMutableParagraphStyle
        textStyle.alignment = NSTextAlignment.Left
        
        let textFontAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(TITLE_FONT_SIZE), NSForegroundColorAttributeName: UIColor.whiteColor(), NSParagraphStyleAttributeName: textStyle]
        
        let attributedString = NSAttributedString(string: title, attributes: textFontAttributes)
        
        _channelTitleTextNode?.attributedString = attributedString
        
        self.addSubnode(_channelTitleTextNode)
        
        // 3
        self.backgroundColor = UIColor.clearColor()
    }
    
    func makeImageNode(iconUrl: String ,isRemoteImage:Bool) {
        if(isRemoteImage){
            
        }else{
            _videoChannelThumbnailsNode = ASImageNode()
            let image = UIImage(named: iconUrl)
            _videoChannelThumbnailsNode?.image = image
        }
    }
    
    
    func calculateSizeThatFits(constrainedSize:CGSize )->CGSize{
        return _nodeCellSize!
    }
    
    
    
    func layout(){
        
        var height = _nodeCellSize?.height
        
        var vLeft:CGFloat = 16.0
        var vTop = (height! - ICON_HEIGHT)/2
        
        _videoChannelThumbnailsNode?.frame = CGRectMake(vLeft, vTop, ICON_HEIGHT, ICON_HEIGHT)
        
        vLeft = 16 + ICON_HEIGHT + 16
        vTop = (height! - TITLE_FONT_SIZE)/2-3
        _channelTitleTextNode?.frame = CGRectMake(vLeft, vTop, 200,  height!-vTop)
    }
    
    
    
}
