//
//  DetailPageTableUtils.swift
//  app
//
//  Created by djzhang on 5/10/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

let VIDEO_INFO_CELL_IDENTIFER = "videoInfoIdentifier"
let CHANNEL_INFO_CELL_IDENTIFER = "channelInfoIdentifier"
let SUGGESTION_CELL_IDENTIFER = "suggestionVideoInfoIdentifier"

public enum DetailPageCellIdentifier {
    case VideoInfoCellIdentifier
    case ChannelInfoCellIdentifier
    case SuggestionListCellIdentifier
}



class DetailPageSection{
    var sectionIdentifier :    DetailPageCellIdentifier?
    var sectionTitle = ""
    var identifer = ""
    var rowObjects :[AnyObject] = [AnyObject]()
    
    class func makeVideoInfoSection(object:AnyObject) -> DetailPageSection{
        let section: DetailPageSection = DetailPageSection()
        
        section.sectionTitle = ""
        section.sectionIdentifier = DetailPageCellIdentifier.VideoInfoCellIdentifier
        section.identifer = VIDEO_INFO_CELL_IDENTIFER
        section.rowObjects.append(object)
        
        return section
    }
}
