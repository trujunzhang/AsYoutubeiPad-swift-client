//
//  MenuLoginTitleBarCell.swift
//  app
//
//  Created by djzhang on 4/25/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//


import Foundation
import UIKit
import Cartography

// MARK : MenuTitleBarLoggedCellObject

class MenuLoginTitleBarCellObject: NICellObject {
    var menuTitleBarTapProtocol: NBMenuTitleBarTapProtocol?
    
    init(menuTitleBarTapProtocol: NBMenuTitleBarTapProtocol) {
        super.init(cellClass: MenuLoginTitleBarCell.self, userInfo: nil)
        
        self.menuTitleBarTapProtocol = menuTitleBarTapProtocol
    }
}

class MenuLoginTitleBarCell: MenuTitleBarBaseCell, NICell {
    var loginLabel: UILabel?
    
    // MARK : Life Cycle
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        loginLabel = UILabel()
        if let theLoginLabel: UILabel = loginLabel {
            theLoginLabel.textColor = UIColor.whiteColor()
            
            self.addSubview(theLoginLabel)
        }
        
        if let theLoginLabel: UILabel = loginLabel {
            
            layout(theLoginLabel) {
                view2 in
                
                // theUserName
                view2.leading == view2.superview!.leading + 50
                view2.centerY == view2.superview!.centerY
                
                view2.width == 140
                view2.height == 14
                
            }
        }
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.loginLabel!.text = nil
    }
    
    func shouldUpdateCellWithObject(object: AnyObject!) -> Bool {
        backgroundColor = UIColor.clearColor()
        
        let infoObject: MenuLoginTitleBarCellObject = object as! MenuLoginTitleBarCellObject
        self.menuTitleBarTapProtocol = infoObject.menuTitleBarTapProtocol
        
        if let theLoginLabel: UILabel = loginLabel {
            theLoginLabel.text = "Login in"
        }
        
        return true
    }
    
    class func shouldAppendObjectClassToReuseIdentifier() -> Bool {
        return true
    }
    
}


