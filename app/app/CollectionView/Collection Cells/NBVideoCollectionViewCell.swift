//
//  YTVideoCollectionViewCell.swift
//  app
//
//  Created by djzhang on 4/30/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit
import Foundation

class NBVideoCollectionViewCellObject: NSObject, NICollectionViewNibCellObject {
    
    
    // MARK: NICollectionViewNibCellObject
    func collectionViewCellNib() -> UINib {
        return UINib(nibName: "NBVideoCollectionViewCell", bundle: nil)
    }
}

class NBVideoCollectionViewCell: UICollectionViewCell, NICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    // MARK: NICollectionViewCell
    func shouldUpdateCellWithObject(object: AnyObject!) -> Bool {
        return true
    }
    
    
}
