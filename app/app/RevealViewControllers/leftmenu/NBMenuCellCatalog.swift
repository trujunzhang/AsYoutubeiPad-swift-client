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

        if let theTitleLabel: UILabel = titleLabel, theThumbnailView: UIImageView = thumbnailView, theDivide: UIView = divide {
            let pixelHeight: CGFloat = 1.0f / UIScreen.mainScreen().scale

            layout(theTitleLabel, theThumbnailView, theDivide) {
                view1, view2, view3 in

                // _titleLabel
                view1.leading == view1.superview!.leading + 20
                view1.trailing == view1.superview!.trailing - 200

                view1.top == view1.superview!.top + 10
                view1.height == 14

                // _likeCountLabel
                view2.leading == view2.superview!.leading + 20
                view2.trailing == view2.superview!.trailing - 200

                view2.top == view1.bottom + 4
                view2.height == 14

                // _toggleButton
                view3.top == view3.superview!.top
                view3.trailing == view3.superview!.trailing

                view3.width == VIDEO_INFO_TOGGLE_WIDTH_HEIGHT
                view3.height == VIDEO_INFO_TOGGLE_WIDTH_HEIGHT
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