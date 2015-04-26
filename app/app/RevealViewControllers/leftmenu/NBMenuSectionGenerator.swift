//
//  NBMenuSectionGenerator.swift
//  app
//
//  Created by djzhang on 4/22/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import UIKit

struct LoggedUserInfo {
    let email: String
    let userName: String
    let isLogin: Bool

    init() {
        self.userName = ""
        self.email = ""
        self.isLogin = false
    }
    init(userName: String, email: String) {
        self.userName = userName
        self.email = email
        self.isLogin = true
    }
}

class NBMenuSectionGenerator {

    class func generatorSections(tableData: [MenuSectionItemInfo], menuTitleBarTapProtocol: NBMenuTitleBarTapProtocol, userInfo: LoggedUserInfo) -> NBTableModelRowInfo {
        var tableContents: [AnyObject] = [AnyObject]()
        var tableRowHeights: [CGFloat] = [CGFloat]()

        // title bar
        var titleCellObject: NICellObject
        if (userInfo.isLogin == true) {
            titleCellObject = MenuTitleBarLoggedCellObject(userName: userInfo.userName, email: userInfo.email, menuTitleBarTapProtocol: menuTitleBarTapProtocol)
        } else {
            titleCellObject = MenuTitleBarLoggedCellObject(userName: "", email: "", menuTitleBarTapProtocol: menuTitleBarTapProtocol)
        }
        tableContents.append(titleCellObject)
        tableRowHeights.append(MENU_TITLEBAR_HEIGHT)

        for itemInfo: MenuSectionItemInfo in tableData {
            let isHideTitle: Bool = itemInfo.isHideTitle

            // 1. section title
            if (isHideTitle == false) {
                tableContents.append(YTSectionTitleCellObject(title: itemInfo.headerTitle))
                tableRowHeights.append(MENU_SECTION_TITLE_HEIGHT)
            }

            let rows: [MenuRowItemInfo] = itemInfo.rows
            let isRemoteImage: Bool = itemInfo.isRemoteImage
            for row: MenuRowItemInfo in rows {
                // rows
                var cellObject: NICellObject
                if (isRemoteImage == true) {
                    cellObject = YTMenuRemoteRowCellObject(title: row.title, imageUrl: row.imageUrl)
                } else {
                    cellObject = YTMenuRowCellObject(title: row.title, image: UIImage(named: row.imageUrl)!)
                }
                tableContents.append(cellObject)
                tableRowHeights.append(MENU_ROW_HEIGHT)
            }
        }

        return NBTableModelRowInfo(tableContents: tableContents, tableRowHeights: tableRowHeights)
    }


}