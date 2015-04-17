//
//  VideoInfoTitleTableViewCell.swift
//  app
//
//  Created by djzhang on 4/17/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit

//NINibCellObject

class VideoInfoTitleTableViewCellObject :NSObject,NINibCellObject {
    
    // MARK : NINibCellObject
    func cellNib() -> UINib! {
        let name:String = ""
        return UINib(nibName: name, bundle: nil)
    }
}


class VideoInfoTitleTableViewCell: UITableViewCell,NICell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // MARK : NICell
    func shouldUpdateCellWithObject(object: AnyObject!) -> Bool {
        
        return true
    }
    
    
}
