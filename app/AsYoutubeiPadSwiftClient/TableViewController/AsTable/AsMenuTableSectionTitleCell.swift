//
//  AsMenuTableSectionTitleCell.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/24/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class AsMenuTableSectionTitleCell:ASCellNode {
    
    
    var _nodeCellSize:CGSize?
    var _nodeTitle:ASTextNode?
    var _divider:ASDisplayNode?
    
    init(nodeCellSize: CGSize, title: String) {
        super.init()
        
        _nodeCellSize = nodeCellSize
        
        // 1
        _nodeTitle = AsNodeMaker.makeNodeText()
        
        let textStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = NSTextAlignment.Left
        
        let textFontAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(TITLE_FONT_SIZE), NSForegroundColorAttributeName: UIColor.grayColor(), NSParagraphStyleAttributeName: textStyle]
        
        let attributedString = NSAttributedString(string: title, attributes: textFontAttributes)
        
        _nodeTitle?.attributedString = attributedString
        
        self.addSubnode(_nodeTitle)
        
        // 2
        // hairline cell separator
        _divider = ASDisplayNode()
        _divider?.backgroundColor = UIColor.lightGrayColor()
        self.addSubnode(_divider)
        
        // 3
        self.backgroundColor = UIColor.clearColor()
    }
    
    
    func calculateSizeThatFits(constrainedSize:CGSize )->CGSize{
        return _nodeCellSize!
    }
    
    
    func layout(){
        var width = _nodeCellSize?.width
        var height = _nodeCellSize?.height
        var vTop:CGFloat?
        var nodeSize:CGSize?
        var nodeHeight:CGFloat?
        
        var middleY = height! / 2
        
        // 2
        var scale :CGFloat = UIScreen.mainScreen().scale
        var pixelHeight:CGFloat =  1.0 / scale
        vTop = height! - pixelHeight
        _divider?.frame = CGRectMake(0.0, vTop!, width!,   pixelHeight)
        
        //1
        var vLeft = ICON_PADDING_LEFT
        var vWidth = width! - vLeft
        
        nodeSize = _nodeTitle?.measure(_nodeCellSize!)
        nodeHeight = nodeSize?.height
        vTop = vTop! - nodeHeight! - 3
        
        _nodeTitle?.frame = CGRectMake(vLeft, vTop!, vWidth,  nodeHeight!)
        
        
    }
    
    
    
    
}
