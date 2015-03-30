//
//  MenuCollapseTableCell.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/28/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import UIKit
import Haneke

class MenuCollapseTableCell: UITableViewCell {
    
    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    var _isRemoteImage: Bool?
    
    func setupCell(title: String, iconUrl: String, isRemoteImage: Bool) {
        
        _isRemoteImage = isRemoteImage
        
        self.titleLabel.text = title
//        self.titleLabel.textColor = UIColor.whiteColor()
        
        
        if (isRemoteImage == true) {
            let URL: NSURL = NSURL(string: iconUrl)!
            let image = UIImage(named: "thumbnail_border")
            self.iconImage.image = image
            self.iconImage.hnk_setImageFromURL(URL)
            
//            let cache = WebImageCache.SharedLeftMenuImageCache()
//            cache.fetch(URL: URL, formatName: "icons").onSuccess { image in
//                // image will be a nice rounded icon
//                self.iconImage.image = image
//            }
        } else {
            let image = UIImage(named: iconUrl)
            self.iconImage.image = image
        }
        
        // 3
        self.backgroundColor = UIColor.clearColor()
        
//        self.setupLayout()
    }
    
    
    func setupLayout() {
        var width:CGFloat = REAR_VIEW_WIDTH
        var height:CGFloat = TABLE_ROW_HEIGHT
        
        var vTop:CGFloat?
        var vLeft:CGFloat?
        var nodeSize:CGSize?
        var nodeHeight:CGFloat?
        
        var middleY = height / 2
        var icon_WH = LOGIN_ICON_WH
        if(_isRemoteImage == true){
            icon_WH = LOGIN_ICON_WH + 4
        }
        
        //1
        var icon_middle_x = ICON_PADDING_LEFT + LOGIN_ICON_WH/2
        vTop = middleY - icon_WH/2
        vLeft = icon_middle_x - icon_WH/2
        iconImage?.frame = CGRectMake(vLeft!, vTop!, icon_WH, icon_WH)
        
        //2
        vLeft = ICON_PADDING_LEFT + LOGIN_ICON_WH + ICON_PADDING_RIGHT
        var vWidth = width - vLeft!
        
        nodeHeight = 12
        vTop = middleY - nodeHeight!/2
        
        titleLabel?.frame = CGRectMake(vLeft!, vTop!, vWidth,  nodeHeight!)
    }
    
    
}