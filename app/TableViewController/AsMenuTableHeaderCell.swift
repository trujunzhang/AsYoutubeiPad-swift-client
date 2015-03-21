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
    
    var _nodeCellSize:CGSize?
    var _delegate : ASTableCellProtocols?
    var _videoChannelThumbnailsNode:ASImageNode?
    var _channelTitleTextNode:ASTextNode?
    var _isLogin: Bool?
    
    init(nodeCellSize: CGSize,isLogin:Bool, delegate:ASTableCellProtocols ) {
        super.init()
        
        selectionStyle = UITableViewCellSelectionStyle.None;
        _isLogin = isLogin
        _nodeCellSize = nodeCellSize
        
        _delegate = delegate
        
        if(_isLogin == true){
            self.makeUserProfileUI()
        }else{
            self.makeLoginUI()
        }
        
        // 3
        self.backgroundColor = UIColor.clearColor()
    }
    
    // MARK: Make different panel by login status
    func makeLoginUI(){
        // 1
        _videoChannelThumbnailsNode = ASImageNode()
        _videoChannelThumbnailsNode?.image =  UIImage(named: "signin")
        _videoChannelThumbnailsNode?.addTarget(self, action: "buttonTapped:", forControlEvents: .TouchUpInside)
        self.addSubnode(_videoChannelThumbnailsNode)
        
        // 2
        _channelTitleTextNode = ASTextNode()
        
        let textStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as NSMutableParagraphStyle
        textStyle.alignment = NSTextAlignment.Left
        
        let textFontAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(TITLE_FONT_SIZE), NSForegroundColorAttributeName: UIColor.whiteColor(), NSParagraphStyleAttributeName: textStyle]
        
        let attributedString = NSAttributedString(string: "Sign In", attributes: textFontAttributes)
        
        _channelTitleTextNode?.attributedString = attributedString
        
        self.addSubnode(_channelTitleTextNode)
        
    }
    
    func makeUserProfileUI(){
        
    }
    
    
    
    
    func setText(text:String){
        let textStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as NSMutableParagraphStyle
        textStyle.alignment = NSTextAlignment.Left
        
        let textFontAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(TITLE_FONT_SIZE), NSForegroundColorAttributeName: UIColor.whiteColor(), NSParagraphStyleAttributeName: textStyle]
        
        let attributedString = NSAttributedString(string: "wanghao", attributes: textFontAttributes)
        
        _channelTitleTextNode?.attributedString = attributedString
    }
    
    func buttonTapped(sender :idtype_t){
        if(_delegate != nil){
            _delegate?.updateForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), rowType: .LeftTableRowType_Header)
        }
    }
    
    func calculateSizeThatFits(constrainedSize:CGSize )->CGSize{
        return _nodeCellSize!
    }
    
    
    
    func layout(){
        var width = _nodeCellSize?.width
        var height = _nodeCellSize?.height
        var vTop = (height! - ICON_HEIGHT)/2
        
        _videoChannelThumbnailsNode?.frame = CGRectMake(ICON_PADDING_LEFT, vTop, ICON_HEIGHT, ICON_HEIGHT)
        
        var vLeft = ICON_PADDING_LEFT + ICON_HEIGHT + ICON_PADDING_RIGHT
        vTop = (height! - TITLE_FONT_SIZE)/2-3
        var vWidth = width! - vLeft
        _channelTitleTextNode?.frame = CGRectMake(vLeft, vTop, vWidth,  height!-vTop)
        _channelTitleTextNode?.frame = CGRectMake(vLeft, vTop, 200,  height!-vTop)
    }
    
    
    
    
}
