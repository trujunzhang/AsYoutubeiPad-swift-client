//
//  VideoCollectionViewCellLayout.swift
//  app
//
//  Created by djzhang on 5/4/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import Cartography


class VideoCollectionViewCellLayout {

    class func calculateVideoCollectionViewCellHeight(width: CGFloat) -> CGFloat {
        let thumbnailHeight: CGFloat = (width / 16) * 9

        return thumbnailHeight + 90
    }

}
        
        