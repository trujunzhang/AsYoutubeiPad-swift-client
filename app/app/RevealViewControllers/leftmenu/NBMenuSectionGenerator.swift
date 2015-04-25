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

    class func generatorSections(tableData: [MenuSectionItemInfo]) -> NBTableModelRowInfo {
        var tableContents: [AnyObject] = [AnyObject]()
        var tableRowHeights: [CGFloat] = [CGFloat]()

        let titleBar: MenuTitleBarCellObject = MenuTitleBarCellObject(title: "")
        tableContents.append(titleBar)
        tableRowHeights.append(MENU_TITLEBAR_HEIGHT)

        for itemInfo: MenuSectionItemInfo in tableData {

            // 1. section title
            let sectionTitleObject: YTSectionTitleCellObject = YTSectionTitleCellObject(title: itemInfo.headerTitle)
            tableContents.append(sectionTitleObject)
            tableRowHeights.append(MENU_SECTION_TITLE_HEIGHT)

            var rows: [MenuRowItemInfo] = itemInfo.rows
            for row: MenuRowItemInfo in rows {
                let rowCellObject: YTMenuRowCellObject = YTMenuRowCellObject(title: row.title, image: UIImage(named: row.imageUrl)!)
                tableContents.append(rowCellObject)
                tableRowHeights.append(MENU_ROW_HEIGHT)
            }
        }

        return NBTableModelRowInfo(tableContents: tableContents, tableRowHeights: tableRowHeights)
    }

    private class func appendTableContent(cellObject: NICellObject,toArray:[AnyObject], withCellHeight:CGFloat){

    }


}