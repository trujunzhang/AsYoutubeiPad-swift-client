//
//  MenuSectionHeaderView.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/29/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class MenuSectionHeaderView: UIView {
    
    var titleLabel:UILabel?
    var divideView:UIView?
    
    func setupView(title:NSString){
        //1
        titleLabel = UILabel()
        
        titleLabel?.text = title
        titleLabel?.textColor = UIColor.whiteColor()
        
//        self.addSubview(titleLabel!)
        
        // 2
    }
    
    override func layoutSubviews() {
        let height:CGFloat = TABLE_SECTION_HEADER_HEIGHT
        
        
        
    }

}