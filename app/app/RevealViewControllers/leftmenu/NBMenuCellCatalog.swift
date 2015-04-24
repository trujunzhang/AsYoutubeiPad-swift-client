//
//  NBMenuCellCatalog.swift
//  app
//
//  Created by djzhang on 4/24/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

// MARK : YTCategoryCellObject

class YTCategoryCellObject: NICellObject {

    var title = ""
    var image: UIImage?

    init(title: String, image: UIImage, userInfo: AnyObject) {
        super.init(cellClass: YTCategoryCell.self, userInfo: userInfo)
 
        self.userInfo = userInfo
        self.title = title
        self.image = image
    }


}

class YTCategoryCell: UITableViewCell, NICell {
    var titleLabel: UILabel?
    var thumbnailView: UIImageView?
    var divide: UIView?

    // MARK : Life Cycle
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        self.titleLabel!.text = nil
        self.thumbnailView!.image = nil
    }

    func shouldUpdateCellWithObject(object: AnyObject!) -> Bool {
        backgroundColor = UIColor.clearColor()

//        textLabel?.textColor = UIColor.whiteColor()

        return true
    }
}