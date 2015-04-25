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

let MENU_TITLEBAR_HEIGHT: CGFloat = 50
let MENU_SECTION_TITLE_HEIGHT: CGFloat = 20
let MENU_ROW_HEIGHT: CGFloat = 40

struct NBTableModelRowInfo {
    var tableContents: [AnyObject]
    var tableRowHeights: [CGFloat]
}


// MARK: NBMenuTableViewController

extension NBMenuTableViewController {

    class func instance() -> NBMenuTableViewController {

        var viewController: NBMenuTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("NBMenuTableViewController") as! NBMenuTableViewController

        return viewController
    }
}