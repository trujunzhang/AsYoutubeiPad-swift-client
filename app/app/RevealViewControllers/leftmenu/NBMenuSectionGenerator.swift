//
//  NBMenuSectionGenerator.swift
//  app
//
//  Created by djzhang on 4/22/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import UIKit

class NBMenuSectionGenerator {

    class func generatorSections(tableData: [MenuSectionItemInfo], menuTitleBarTapProtocol: NBMenuTitleBarTapProtocol) -> NBTableModelRowInfo {
        var tableContents: [AnyObject] = [AnyObject]()
        var tableRowHeights: [CGFloat] = [CGFloat]()

        // title bar
        tableContents.append(MenuTitleBarCellObject(title: "", menuTitleBarTapProtocol: menuTitleBarTapProtocol))
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
                var cellObject: YTMenuRowCellObject
                if (isRemoteImage == true) {
                    cellObject = YTMenuRowCellObject(title: row.title, imageUrl: row.imageUrl)
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