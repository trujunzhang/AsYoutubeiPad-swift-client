//
//  NBMenuCellCatalog.swift
//  app
//
//  Created by djzhang on 4/24/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import UIKit
import Cartography

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

        titleLabel = UILabel()
        if let theTitleLabel: UILabel = titleLabel {
            theTitleLabel.textColor = UIColor.whiteColor()

            self.addSubview(theTitleLabel)
        }
        thumbnailView = UIImageView()
        if let theThumbnailView: UIImageView = thumbnailView {

            self.addSubview(theThumbnailView)
        }
        divide = UIView()
        if let theDivide: UIView = divide {

            theDivide.backgroundColor = UIColor.lightGrayColor()
            self.addSubview(theDivide)
        }

        if let theThumbnailView: UIImageView = thumbnailView, theTitleLabel: UILabel = titleLabel, theDivide: UIView = divide {
            let pixelHeight: CGFloat = 1.0 / UIScreen.mainScreen().scale

            layout(theThumbnailView, theTitleLabel, theDivide) {
                view1, view2, view3 in
                
                // theThumbnailView
                view1.leading == view1.superview!.leading + 4
                view1.centerY == view1.superview!.centerY

                view1.width == LEFT_MENU_ICON_WH
                view1.height == LEFT_MENU_ICON_WH

                // theTitleLabel
                view2.leading == view1.leading + 20
                view2.centerY == view2.superview!.centerY
                view2.trailing == view2.superview!.trailing - 20

                // theDivide
                view3.top == view3.superview!.top
                view3.leading == view3.superview!.leading + 20
                view3.trailing == view3.superview!.trailing - 20

                view3.height == pixelHeight
            }
        }


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