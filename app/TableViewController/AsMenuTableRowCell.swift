//
//  AsMenuTableRowCell.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/19/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import UIKit

class AsMenuTableRowCell :ASCellNode{
    
    var _nodeCellSize:CGSize?;
    var _videoChannelThumbnailsNode:ASImageNode?;
    var _channelTitleTextNode:ASTextNode?;
    
    init(nodeCellSize: CGSize, title: String, iconUrl: String, isRemoteImage: Bool) {
        super.init()
        
        _nodeCellSize = nodeCellSize
        
        // 1
        makeImageNode(iconUrl, isRemoteImage: isRemoteImage)
        self.addSubnode(_videoChannelThumbnailsNode)
        
        // 2
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
        var width = _nodeCellSize?.width
        var height = _nodeCellSize?.height
        var vTop = (height! - LOGIN_ICON_WH)/2
        
        _videoChannelThumbnailsNode?.frame = CGRectMake(ICON_PADDING_LEFT, vTop, LOGIN_ICON_WH, LOGIN_ICON_WH)
        
        var vLeft = ICON_PADDING_LEFT + LOGIN_ICON_WH + ICON_PADDING_RIGHT
        vTop = (height! - TITLE_FONT_SIZE)/2-3
        var vWidth = width! - vLeft
        _channelTitleTextNode?.frame = CGRectMake(vLeft, vTop, vWidth,  height!-vTop)
    }
    
    
    
}
