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

    var infoContainer: UIView!
    var totalTimeLabel: UILabel!

    var titleLabel: UILabel!
    var infoLabel: UILabel!
    var channelThumbnailImage: UIImageView!
    var channelTitleLabel: UILabel!

    /**
    ||  thumbnailImage(120*90)(480*360), ratio is (1.3333333333)(0.75)
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
    class func layoutVideoThumbnailImageContainer(thumbnailImage: UIImageView, totalTimeLabel: UILabel) {
        layout(thumbnailImage, totalTimeLabel) {
            view1, view2 in

            view1.top == view1.superview!.top
            view1.leading == view1.superview!.leading
            view1.trailing == view1.superview!.trailing
            view1.height == (view1.width / 4) * 3

            view2.trailing == view2.superview!.trailing
            view2.bottom == view2.superview!.bottom
            view2.height == 10
        }
    }

    class func layoutVideoTitleLabel(infoContainer: UIView) {
        layout(infoContainer) {
            view1 in

            view1.leading == view1.superview!.leading
            view1.trailing == view1.superview!.trailing
            view1.bottom == view1.superview!.bottom
            view1.height == COLLECTION_CELL_INFO_HEIGHT
        }
    }

    class func layoutVideoTitleLabel(titleLabel: UILabel, infoLabel: UILabel) {
        layout(titleLabel, infoLabel) {
            view1 in

            view1.leading == view1.superview!.leading
            view1.trailing == view1.superview!.trailing
            view1.top == view1.superview!.top + 4
            view1.height == 36

            view2.leading == view2.superview!.leading
            view2.trailing == view2.superview!.trailing
            view2.top == view1.superview!.bottom + 4
            view2.height == 18
        }
    }

    class func layoutVideoInfoContainer(channelThumbnailImage: UIImageView, channelTitleLabel: UILabel) {
        layout(channelThumbnailImage, channelTitleLabel) {
            view1 in

            view1.leading == view1.superview!.leading
            view1.bottom == view1.superview!.bottom - 4
            view1.width == 24
            view1.height == 24

            view2.leading == view1.superview!.trailing + 4
            view2.trailing == view2.superview!.trailing
            view2.bottom == view2.superview!.bottom - 4
            view2.height == 18
        }
    }

    class func calculateVideoCollectionViewCellHeight(width: CGFloat) -> CGFloat {
        let thumbnailHeight: CGFloat = (width / 4) * 3

        return 0
    }

}
        
        