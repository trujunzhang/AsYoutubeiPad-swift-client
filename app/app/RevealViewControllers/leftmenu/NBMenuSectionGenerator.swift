//
//  NBMenuSectionGenerator.swift
//  app
//
//  Created by djzhang on 4/22/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


class NBMenuSectionGenerator {

    class func generatorSections(tableData: [MenuSectionItemInfo]) -> [AnyObject] {
        var tableContents: [AnyObject] = [AnyObject]()
        for itemInfo: MenuSectionItemInfo in tableData {

            // 1. section title
            let sectionTitle: YTSectionTitleCellObject = YTSectionTitleCellObject(title: itemInfo.headerTitle)
            tableContents.append(sectionTitle)
        }

        return  tableContents
    }


}