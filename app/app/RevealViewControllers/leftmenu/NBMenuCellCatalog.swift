//
//  NBMenuCellCatalog.swift
//  app
//
//  Created by djzhang on 4/24/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

// MARK : YTCategoryCellObject

class YTCategoryCellObject: NITitleCellObject {

    class func makeCategoryCellObject(title: String!, image: UIImage!) -> YTCategoryCellObject {
        return YTCategoryCellObject(title: title, image: image, userInfo: nil)
    }

    init!(title: String!, image: UIImage!, userInfo: AnyObject!) {
        super.init(title: title, image: image, cellClass: YTCategoryCell.self, userInfo: userInfo)
    }
    override init!(title: String!, image: UIImage!) {
        super.init(title: title, image: image)
    }
}

class YTCategoryCell: NITextCell {
    override func shouldUpdateCellWithObject(object: AnyObject!) -> Bool {
        backgroundColor = UIColor.clearColor()
        
        textLabel?.textColor = UIColor.whiteColor()

        return super.shouldUpdateCellWithObject(object)
    }
}