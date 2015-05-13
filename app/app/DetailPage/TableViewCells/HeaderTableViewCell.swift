//
//  HeaderTableViewCell.swift
//  app
//
//  Created by djzhang on 5/11/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var headerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        let ivView: UIView = UIView()
        ivView.backgroundColor = UIColor.clearColor()
        self.selectedBackgroundView = ivView
    }
    
    func configureCell(object: SectionTitleObject){
        self.headerLabel.text = object.title
    }
    
}
