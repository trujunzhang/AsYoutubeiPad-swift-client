//
//  VideoInfoTableViewCellExt.swift
//  app
//
//  Created by djzhang on 5/10/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

extension VideoInfoTableViewCell{
    
    class func getDescriptionLabelHeight(calcuteString: String, width: CGFloat) -> CGFloat{
        
         func getDescriptionBlockCellFont() -> UIFont {
            return UIFont.systemFontOfSize(12)
        }
        let boundingRect = calcuteString.boundingRectWithSize(CGSizeMake(width, CGFloat.max),
            options: .UsesLineFragmentOrigin | .UsesFontLeading,
            attributes: [NSFontAttributeName: getDescriptionBlockCellFont()],
            context: nil)
        
        return boundingRect.size.height + 120 + 40
    }

}