//
//  LeftMenuConstant.swift
//  app
//
//  Created by djzhang on 4/21/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


let LEFT_MENU_WIDTH: CGFloat = 270
let LEFT_MENU_ICON_WH:CGFloat = 31


//NBMenuTableViewController

extension NBMenuTableViewController{
    
    class func instance() -> NBMenuTableViewController {
        
        var viewController: NBMenuTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("NBMenuTableViewController") as! NBMenuTableViewController
        
        return viewController
    }
}