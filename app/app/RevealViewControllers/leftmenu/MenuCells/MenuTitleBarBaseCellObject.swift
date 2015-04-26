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


class MenuTitleBarLoginCellObject: NICellObject {

    var title = ""
    var menuTitleBarTapProtocol: NBMenuTitleBarTapProtocol?

    init(title: String, menuTitleBarTapProtocol: NBMenuTitleBarTapProtocol) {
        super.init(cellClass: MenuTitleBarBaseCell.self, userInfo: nil)

        self.title = title
        self.menuTitleBarTapProtocol = menuTitleBarTapProtocol
    }
}

class MenuTitleBarBaseCell: UITableViewCell {
    var thumbnailImageView: UIImageView?

    var titlebarImageView: UIImageView?
    var settingsImageView: UIImageView?

    var menuTitleBarTapProtocol: NBMenuTitleBarTapProtocol?

    // MARK : Life Cycle
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        titlebarImageView = UIImageView()
        if let theTitlebarImageView: UIImageView = titlebarImageView {
            theTitlebarImageView.image = UIImage(named: "guide_titlebar_frost_cropped")
            createTapGestureRecognizerForTitlebarImageView(theTitlebarImageView)

            self.addSubview(theTitlebarImageView)
        }
        thumbnailImageView = UIImageView()
        if let theThumbnailImageView: UIImageView = thumbnailImageView {
            theThumbnailImageView.image = UIImage(named: "guide_default_user_thumbnail")
            theThumbnailImageView.backgroundColor = UIColor.whiteColor()

            self.addSubview(theThumbnailImageView)
        }

        settingsImageView = UIImageView()
        if let theSettingsImageView: UIImageView = settingsImageView {
            theSettingsImageView.image = UIImage(named: "guide_settings")

            self.addSubview(theSettingsImageView)
        }


        if let theTitlebarImageView: UIImageView = titlebarImageView, theSettingsImageView: UIImageView = settingsImageView, theThumbnailImageView: UIImageView = thumbnailImageView {
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
            layout(theThumbnailImageView) {
                view1 in

                // theThumbnailImageView
                view1.leading == view1.superview!.leading + 6
                view1.top == view1.superview!.top + 6

                view1.width == 32
                view1.height == 32
            }
        }


    }

    func createTapGestureRecognizerForTitlebarImageView(view: UIView) {
        let playTap = UITapGestureRecognizer(target: self, action: "loginTapped")
        playTap.numberOfTouchesRequired = 1
        playTap.numberOfTapsRequired = 1
        view.userInteractionEnabled = true
        view.addGestureRecognizer(playTap)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }


    // MARK: UITapGestureRecognizer
    func loginTapped() {
        if let theMenuTitleBarTapProtocol: NBMenuTitleBarTapProtocol = menuTitleBarTapProtocol {
            theMenuTitleBarTapProtocol.showLoginPanel()
        }
    }
}


