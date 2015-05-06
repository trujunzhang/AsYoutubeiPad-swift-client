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

    var thumbnailImage: UIImageView!

    var infoContain: UIView!
    var totalTimeLabel: UILabel!

    var titleLabel: UILabel!
    var infoLabel: UILabel!
    var channelContainer: UIView!
    var channelThumbnailImage: UIImageView!
    var channelTitleLabel: UILabel!

    /**
    ||  thumbnailImage(120*90)(480*360), ratio is (1.3333333333)(0.75),16/9(ratio)
    ||
    ||   titleLabel
    ||   infoLabel
    ||
    ||   *channelContainer*
    ||   channelThumbnailImage  ||  channelTitleLabel
    ||

    :param: titleLabel
    :param: infoLabel
    :param: thumbnailImage
    :param: channelContainer
    :param: channelThumbnailImage
    :param: channelTitleLabel
    */
    class func layoutVideoThumbnailImageContainer(thumbnailImage: UIImageView, titleLabel: UILabel, infoLabel: UILabel, channelContainer: UIView, channelThumbnailImage: UIImageView, channelTitleLabel: UILabel) {

    }

    class func layoutVideoCollectionViewCell(thumbnailImage: UIImageView, titleLabel: UILabel, infoLabel: UILabel, channelContainer: UIView, channelThumbnailImage: UIImageView, channelTitleLabel: UILabel) {

    }

    class func calculateVideoCollectionViewCellHeight(width: CGFloat) -> CGFloat {

        return 0
    }

}
        
        