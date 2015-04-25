//
//  MenuTitleBarCellObject.swift
//  app
//
//  Created by djzhang on 4/25/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//


import Foundation
import UIKit
import Cartography

// MARK : YTCategoryCellObject

class MenuTitleBarCellObject: NICellObject {

    var title = ""

    init(title: String) {
        super.init(cellClass: MenuTitleBarCell.self, userInfo: nil)

        self.title = title
    }
}

class MenuTitleBarCell: UITableViewCell, NICell {
    var thumbnailImageView: UIImageView?
    var userNameLabel: UILabel?
    var emailLabel: UILabel?

    var titlebarImageView: UIImageView?
    var settingsImageView: UIImageView?


    // MARK : Life Cycle
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        titlebarImageView = UIImageView()
        if let theTitlebarImageView: UIImageView = titlebarImageView {
            theTitlebarImageView.image = UIImage(named: "guide_titlebar_frost_cropped")
            createTapGestureRecognizerForView(theTitlebarImageView, action: "loginTapped")

            self.addSubview(theTitlebarImageView)
        }
        thumbnailImageView = UIImageView()
        if let theThumbnailImageView: UIImageView = thumbnailImageView {
            theThumbnailImageView.image = UIImage(named: "guide_default_user_thumbnail")
            theThumbnailImageView.backgroundColor = UIColor.whiteColor()

            self.addSubview(theThumbnailImageView)
        }
        userNameLabel = UILabel()
        if let theUserName: UILabel = userNameLabel {
            theUserName.textColor = UIColor.whiteColor()

            self.addSubview(theUserName)
        }
        emailLabel = UILabel()
        if let theEmailLabel: UILabel = emailLabel {
            theEmailLabel.textColor = UIColor.whiteColor()

            self.addSubview(theEmailLabel)
        }
        settingsImageView = UIImageView()
        if let theSettingsImageView: UIImageView = settingsImageView {
            theSettingsImageView.image = UIImage(named: "guide_settings")

            self.addSubview(theSettingsImageView)
        }


        if let theTitlebarImageView: UIImageView = titlebarImageView, theSettingsImageView: UIImageView = settingsImageView, theThumbnailImageView: UIImageView = thumbnailImageView, theUserName: UILabel = userNameLabel, theEmailLabel: UILabel = emailLabel {
            layout(theTitlebarImageView, theSettingsImageView) {
                view1, view2 in

                // theTitlebarImageView
                view1.leading == view1.superview!.leading
                view1.top == view1.superview!.top

                view1.width == 216
                view1.height == 44

                // theSettingsImageView
                view2.trailing == view2.superview!.trailing - 11
                view2.top == view2.superview!.top + 5

                view2.width == 35
                view2.height == 34
            }
            layout(theThumbnailImageView, theUserName, theEmailLabel) {
                view1, view2, view3 in

                // theThumbnailImageView
                view1.leading == view1.superview!.leading + 6
                view1.top == view1.superview!.top + 6

                view1.width == 32
                view1.height == 32

                // theUserName
                view2.leading == view1.trailing + 6
                view2.top == view2.superview!.top + 6

                view2.width == 140
                view2.height == 14

                // theEmailLabel
                view3.leading == view1.trailing + 6
                view3.top == view2.bottom + 6

                view3.width == 140
                view3.height == 14
            }
        }


    }

    func createTapGestureRecognizerForView(view: UIView, action: String) {
        let playTap = UITapGestureRecognizer(target: self, action: "wanghao")
        playTap.numberOfTouchesRequired = 1
        playTap.numberOfTapsRequired = 1
        view.userInteractionEnabled = true
        view.addGestureRecognizer(playTap)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        self.userNameLabel!.text = nil
        self.emailLabel!.text = nil
//        self.titlebarImageView!.image = nil
    }

    func shouldUpdateCellWithObject(object: AnyObject!) -> Bool {
        backgroundColor = UIColor.clearColor()

        if let theUserName: UILabel = userNameLabel, theEmailLabel: UILabel = emailLabel {
            theUserName.text = "Zhang Trujun"
            theEmailLabel.text = "wanghaobackup@gmail.com"
        }

        return true
    }

    // MARK: UITapGestureRecognizer
    func loginTapped() {
        let x = 0
    }
}


