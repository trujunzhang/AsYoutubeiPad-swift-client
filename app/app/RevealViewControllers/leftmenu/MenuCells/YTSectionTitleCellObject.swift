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
import Haneke

// MARK : section title

class YTSectionTitleCellObject: NICellObject {

    var title = ""

    init(title: String) {
        super.init(cellClass: YTSectionTitleCell.self, userInfo: nil)

        self.title = title
    }
}

class YTSectionTitleCell: UITableViewCell, NICell {
    var titleLabel: UILabel?
    var divide: UIView?

    // MARK : Life Cycle
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        titleLabel = UILabel()
        if let theTitleLabel: UILabel = titleLabel {
            theTitleLabel.textColor = UIColor.whiteColor()

            self.addSubview(theTitleLabel)
        }
        divide = UIView()
        if let theDivide: UIView = divide {

            theDivide.backgroundColor = UIColor.lightGrayColor()
            self.addSubview(theDivide)
        }

        if let theTitleLabel: UILabel = titleLabel, theDivide: UIView = divide {
            let pixelHeight: CGFloat = 1.0

            layout(theTitleLabel, theDivide) {
                view2, view3 in

                // theTitleLabel
                view2.leading == view2.superview!.leading + 20
                view2.centerY == view2.superview!.centerY
                view2.trailing == view2.superview!.trailing - 20

                // theDivide
                view3.bottom == view3.superview!.bottom - 2
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
    }

    func shouldUpdateCellWithObject(object: AnyObject!) -> Bool {
        backgroundColor = UIColor.clearColor()
        let cellObject: YTSectionTitleCellObject = object as! YTSectionTitleCellObject

        if let theTitleLabel: UILabel = titleLabel {
            theTitleLabel.text = cellObject.title
        }

        return true
    }
}