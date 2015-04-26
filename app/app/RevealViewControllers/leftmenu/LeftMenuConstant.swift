//
//  LeftMenuConstant.swift
//  app
//
//  Created by djzhang on 4/21/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


let LEFT_MENU_WIDTH: CGFloat = 270
let LEFT_MENU_ICON_WH: CGFloat = 31

let MENU_TITLEBAR_HEIGHT: CGFloat = 56
let MENU_SECTION_TITLE_HEIGHT: CGFloat = 30
let MENU_ROW_HEIGHT: CGFloat = 58


struct NBTableModelRowInfo {
    var tableContents: [AnyObject]
    var tableRowHeights: [CGFloat]
    var tableParams: [AnyObject]
}

class LeftRowParamInfo {
    var rowSectionIdentifier: CellIdentifier = .CategoriesCellIdentifier
    var rowParas: AnyObject = -1
    var hasSectionTitle: Bool = true
    var hasAction: Bool = false

    init() {

    }
    init(hasSectionTitle: Bool) {
        self.hasSectionTitle = hasSectionTitle
        self.hasAction = false
    }
    init(sectionIdentifier: CellIdentifier, rowParas: AnyObject) {
        self.rowSectionIdentifier = sectionIdentifier
        self.rowParas = rowParas
    }

    var simpleDescription: String {
        return "LeftRowParamInfo: rowSectionIdentifier is \(rowSectionIdentifier), rowParas is \(rowParas), hasSectionTitle is \(hasSectionTitle), hasAction is \(hasAction)"
    }

}


protocol NBMenuTitleBarTapProtocol {
    func showLoginPanel() -> Void
}

// MARK: NBMenuTableViewController

extension NBMenuTableViewController {

    class func instance() -> NBMenuTableViewController {

        var viewController: NBMenuTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("NBMenuTableViewController") as! NBMenuTableViewController

        return viewController
    }
}