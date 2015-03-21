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
    
    var _nodeCellSize:CGSize?
    var _delegate : ASTableCellProtocols?
    var _videoChannelThumbnailsNode:ASImageNode?
    var _channelTitleTextNode:ASTextNode?
    
    init(nodeCellSize: CGSize, delegate:ASTableCellProtocols ) {
        super.init()
        
        selectionStyle = UITableViewCellSelectionStyle.None;
        
        _nodeCellSize = nodeCellSize
        _delegate = delegate
        
        
        // 1
        var title = "Travel"
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "'at' h:mm:ss" // superset of OP's format
        let str = dateFormatter.stringFromDate(NSDate())

        makeImageNode("Travel", isRemoteImage: false)
        self.addSubnode(_videoChannelThumbnailsNode)
        
        // 2
        _channelTitleTextNode = ASTextNode()
        
        let textStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as NSMutableParagraphStyle
        textStyle.alignment = NSTextAlignment.Left
        
        let textFontAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(TITLE_FONT_SIZE), NSForegroundColorAttributeName: UIColor.whiteColor(), NSParagraphStyleAttributeName: textStyle]
        
        let attributedString = NSAttributedString(string: str, attributes: textFontAttributes)
        
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
        
        //        _videoChannelThumbnailsNode?.addTarget(self, action: "buttonTapped:", forControlEvents: ASControlNodeEvent.ASControlNodeEventTouchUpInside)
        
        _videoChannelThumbnailsNode?.addTarget(self, action: "buttonTapped:", forControlEvents: .TouchUpInside)
        
    }
    
    
    
    func setText(text:String){
        let textStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as NSMutableParagraphStyle
        textStyle.alignment = NSTextAlignment.Left
        
        let textFontAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(TITLE_FONT_SIZE), NSForegroundColorAttributeName: UIColor.whiteColor(), NSParagraphStyleAttributeName: textStyle]
        
        let attributedString = NSAttributedString(string: "wanghao", attributes: textFontAttributes)
        
        _channelTitleTextNode?.attributedString = attributedString
        
        //        self.setNeedsLayout()
        //        self.setNeedsDisplay()
        
        //                self.invalidateCalculatedSize()
    }
    
    func buttonTapped(sender :idtype_t){
        //        _channelTitleTextNode
        println("tapped button")
        if(_delegate != nil){
            _delegate?.updateForRowAtIndexPath(0, row: 0, rowType: .LeftTableRowType_Header)
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
