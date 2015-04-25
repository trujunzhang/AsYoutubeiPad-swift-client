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

            // 1. section title
            tableContents.append(YTSectionTitleCellObject(title: itemInfo.headerTitle))
            tableRowHeights.append(MENU_SECTION_TITLE_HEIGHT)

            var rows: [MenuRowItemInfo] = itemInfo.rows
            for row: MenuRowItemInfo in rows {
                // rows
                tableContents.append(YTMenuRowCellObject(title: row.title, image: UIImage(named: row.imageUrl)!))
                tableRowHeights.append(MENU_ROW_HEIGHT)
            }
        }

        return NBTableModelRowInfo(tableContents: tableContents, tableRowHeights: tableRowHeights)
    }


}