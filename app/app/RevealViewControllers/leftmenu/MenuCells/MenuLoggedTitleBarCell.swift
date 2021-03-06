//
//  MenuLoggedTitleBarCell.swift
//  app
//
//  Created by djzhang on 4/25/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//


import Foundation
import UIKit
import Cartography

// MARK : MenuTitleBarLoggedCellObject

class MenuTitleBarLoggedCellObject: NICellObject {
    var userName = ""
    var email = ""
    var menuTitleBarTapProtocol: NBMenuTitleBarTapProtocol?

    init(userName: String, email: String, menuTitleBarTapProtocol: NBMenuTitleBarTapProtocol) {
        super.init(cellClass: MenuLoggedTitleBarCell.self, userInfo: nil)
        self.userName = userName
        self.email = email
        self.menuTitleBarTapProtocol = menuTitleBarTapProtocol
    }
}

class MenuLoggedTitleBarCell: MenuTitleBarBaseCell, NICell {
    var userNameLabel: UILabel?
    var emailLabel: UILabel?

    // MARK : Life Cycle
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)


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

        if let theUserName: UILabel = userNameLabel, theEmailLabel: UILabel = emailLabel {

            layout(theUserName, theEmailLabel) {
                view2, view3 in

                // theUserName
                view2.leading == view2.superview!.leading + 50
                view2.top == view2.superview!.top + 6

                view2.width == 140
                view2.height == 14

                // theEmailLabel
                view3.leading == view3.superview!.leading + 50
                view3.top == view2.bottom + 6

                view3.width == 140
                view3.height == 14
            }
        }


    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        self.userNameLabel!.text = nil
        self.emailLabel!.text = nil
    }

    func shouldUpdateCellWithObject(object: AnyObject!) -> Bool {
        backgroundColor = UIColor.clearColor()

        let infoObject: MenuTitleBarLoggedCellObject = object as! MenuTitleBarLoggedCellObject

        self.menuTitleBarTapProtocol = infoObject.menuTitleBarTapProtocol

        if let theUserName: UILabel = userNameLabel, theEmailLabel: UILabel = emailLabel {
            theUserName.text = infoObject.userName
            theEmailLabel.text = infoObject.email
        }

        return true
    }

    class func shouldAppendObjectClassToReuseIdentifier() -> Bool {
        return true
    }

}


