//
//  YTCategoryCellObject.swift
//  app
//
//  Created by djzhang on 4/26/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//


import Foundation
import UIKit
import Cartography


// MARK : YTCategoryCellObject

class YTMenuRemoteRowCellObject: NICellObject {

    var title = ""
    var image: UIImage?
    var imageUrl = ""

    init(title: String, imageUrl: String) {
        super.init(cellClass: YTMenuRemoteRowCell.self, userInfo: nil)

        self.title = title
        self.imageUrl = imageUrl
    }

}

class YTMenuRemoteRowCell: UITableViewCell, NICell {
    var titleLabel: UILabel?
    var thumbnailView: UIImageView?

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

        if let theThumbnailView: UIImageView = thumbnailView, theTitleLabel: UILabel = titleLabel {
            layout(theThumbnailView, theTitleLabel) {
                view1, view2 in

                // theThumbnailView
                view1.leading == view1.superview!.leading + 16
                view1.centerY == view1.superview!.centerY

                view1.width == LEFT_MENU_ICON_WH
                view1.height == LEFT_MENU_ICON_WH

                // theTitleLabel
                view2.leading == view1.trailing + 20
                view2.centerY == view2.superview!.centerY
                view2.trailing == view2.superview!.trailing - 20
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
        let cellObject: YTMenuRemoteRowCellObject = object as! YTMenuRemoteRowCellObject

        if let theThumbnailView: UIImageView = thumbnailView, theTitleLabel: UILabel = titleLabel {
            let imageUrl = cellObject.imageUrl

            // remote image
//            theThumbnailView.hnk_setImageFromURL(NSURL(string: cellObject.imageUrl)!)

            theTitleLabel.text = cellObject.title
        }

        return true
    }
}

