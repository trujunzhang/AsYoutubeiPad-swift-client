//
//  AsMenuTableRowCell.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/19/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import UIKit

//"mt_side_menu_bg"

class AsMenuTableRowCell :ASCellNode{
    
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
        
        let textFontAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(UIFont.labelFontSize()), NSForegroundColorAttributeName: UIColor.blackColor(), NSParagraphStyleAttributeName: textStyle]
        
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
        _videoChannelThumbnailsNode?.frame = CGRectMake(0, 0, 120, 100)
        
        _channelTitleTextNode?.frame = CGRectMake(130, 0, 100, 100)
    }
    
    
    
}
