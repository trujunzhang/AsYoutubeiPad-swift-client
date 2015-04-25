//
//  MenuUserProfileCell.swift
//  app
//
//  Created by djzhang on 4/24/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit

class MenuUserProfileCellObject: NSObject,NINibCellObject {
    
    // MARK: NINibCellObject
    func cellNib() -> UINib! {
        return UINib(nibName: "MenuUserProfileCell", bundle: nil)
    }
    
}


class MenuUserProfileCell: UITableViewCell,NICell {
    
    @IBOutlet weak var userThumbnailImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var settingImageView: UIImageView!
    
    @IBOutlet weak var titlebarImageView: UIImageView!

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: NINibCell
    func shouldUpdateCellWithObject(object: AnyObject!) -> Bool {
        
        return true
    }
    

    
    
}
