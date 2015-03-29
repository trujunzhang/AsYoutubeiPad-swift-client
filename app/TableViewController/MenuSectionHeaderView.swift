//
//  MenuSectionHeaderView.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/29/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import UIKit

class MenuSectionHeaderView: UIViewController {
    

    @IBOutlet var titleLabel: UILabel!
    
    var headerTitle:NSString?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.textColor = UIColor.whiteColor()
        
        titleLabel.text = headerTitle
        
        self.view.frame = CGRectMake(0, 0, REAR_VIEW_WIDTH, TABLE_SECTION_HEADER_HEIGHT)
    }
    
    func setupView(title:NSString){
        headerTitle = title
    }
    
    
    
}