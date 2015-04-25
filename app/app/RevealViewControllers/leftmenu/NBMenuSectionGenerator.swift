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
        
        for itemInfo: MenuSectionItemInfo in tableData {

            // 1. section title
            let sectionTitleObject: YTSectionTitleCellObject = YTSectionTitleCellObject(title: itemInfo.headerTitle)
            tableContents.append(sectionTitleObject)

            var rows: [MenuRowItemInfo] = itemInfo.rows
            for row: MenuRowItemInfo in rows {
                let rowCellObject: YTMenuRowCellObject = YTMenuRowCellObject(title: row.title, image: UIImage(named: row.imageUrl)!)
                tableContents.append(rowCellObject)
            }
        }

        return NBTableModelRowInfo(tableContents: tableContents,tableRowHeights: tableRowHeights)
    }


}