//
//  AsMenuTableRowCell.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/19/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import UIKit
import Haneke
import Toucan

//class AsMenuTableRowCell :ASCellNode{
    class AsMenuTableRowCell :ASDisplayNode{
    
    var _nodeCellSize:CGSize?
    var _videoChannelThumbnailsNode:ASImageNode?
    var _nodeTitle:ASTextNode?
    var _isRemoteImage:Bool?
    
    init(nodeCellSize: CGSize, title: String, iconUrl: String, isRemoteImage: Bool) {
        super.init()
        
        _nodeCellSize = nodeCellSize
        _isRemoteImage = isRemoteImage
        
        // 1
        makeImageNode(iconUrl, isRemoteImage: isRemoteImage)
        self.addSubnode(_videoChannelThumbnailsNode)
        
        // 2
        _nodeTitle = AsNodeMaker.makeNodeText()
        
        let textStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as NSMutableParagraphStyle
        textStyle.alignment = NSTextAlignment.Left
        
        let textFontAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(TITLE_FONT_SIZE), NSForegroundColorAttributeName: UIColor.lightGrayColor(), NSParagraphStyleAttributeName: textStyle]
        
        let attributedString = NSAttributedString(string: title, attributes: textFontAttributes)
        
        _nodeTitle?.attributedString = attributedString
        
        self.addSubnode(_nodeTitle)


        // 3
        self.backgroundColor = UIColor.clearColor()
    }
    
    func makeImageNode(iconUrl: String ,isRemoteImage:Bool) {
        
        if(isRemoteImage){
            let url:NSURL = NSURL(string: iconUrl)!
            
            let cache:AsImageCacher = AsImageCacher()
            let downloader :AsCacheDownloader = AsCacheDownloader()
            var downloaderNode:ASNetworkImageNode = ASNetworkImageNode(cache:cache, downloader: downloader)

//            downloaderNode.clipsToBounds = true
//            downloaderNode.cornerRadius = 8.0
            
            downloaderNode.URL = url

            _videoChannelThumbnailsNode = downloaderNode
            
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
        var vTop:CGFloat?
        var vLeft:CGFloat?
        var nodeSize:CGSize?
        var nodeHeight:CGFloat?
        
        var middleY = height! / 2
        var icon_WH = LOGIN_ICON_WH
        if(_isRemoteImage == true){
            icon_WH = LOGIN_ICON_WH + 4
        }
        
        //1
        var icon_middle_x = ICON_PADDING_LEFT + LOGIN_ICON_WH/2
        vTop = (height! - icon_WH)/2
        vLeft = icon_middle_x - icon_WH/2
        _videoChannelThumbnailsNode?.frame = CGRectMake(vLeft!, vTop!, icon_WH, icon_WH)
        
        //2
        vLeft = ICON_PADDING_LEFT + LOGIN_ICON_WH + ICON_PADDING_RIGHT
        var vWidth = width! - vLeft!
        
        nodeSize = _nodeTitle?.measure(_nodeCellSize!)
        nodeHeight = nodeSize?.height
        vTop = middleY - nodeHeight!/2
        
        _nodeTitle?.frame = CGRectMake(vLeft!, vTop!, vWidth,  nodeHeight!)
    }
    
    
    
}
