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
    
    
    var _nodeCellSize:CGSize?
    var _isRemoteImage:Bool?
    
    func setupCell(title: String, iconUrl: String, isRemoteImage: Bool) {
        
        _isRemoteImage = isRemoteImage

        self.titleLabel.text = title
        self.titleLabel.textColor = UIColor.whiteColor()
        
        if(isRemoteImage == true){
            let url:NSURL = NSURL(string: iconUrl)!
            self.iconImage.hnk_setImageFromURL(url)
        }else{
            let image = UIImage(named: iconUrl)
            self.iconImage.image = image
        }
        
        // 3
        self.backgroundColor = UIColor.clearColor()
    }
    
    
    
    
    
}