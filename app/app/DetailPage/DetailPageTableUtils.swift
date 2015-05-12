//
//  DetailPageTableUtils.swift
//  app
//
//  Created by djzhang on 5/10/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

let VIDEO_INFO_CELL_IDENTIFER = "videoInfoCell"
let VIDEO_DESCRIPTION_CELL_IDENTIFER = "descriptionCell"
let VIDEO_STATISTIC_CELL_IDENTIFER = "statisticCell"

let VIDEO_ROWS_EXPAND_IDENTIFER:[String] = [VIDEO_INFO_CELL_IDENTIFER,VIDEO_DESCRIPTION_CELL_IDENTIFER,VIDEO_STATISTIC_CELL_IDENTIFER]

let VIDEO_ROWS_COLLAPSE_IDENTIFER:[String] = [VIDEO_INFO_CELL_IDENTIFER,VIDEO_STATISTIC_CELL_IDENTIFER]

let SUGGESTION_CELL_IDENTIFER = "suggestionCell"

let CHANNEL_INFO_CELL_IDENTIFER = "channelCell"

let HEADER_CELL_IDENTIFIER = "headerCell"

public enum DetailPageCellIdentifier {
    case VideoInfoCellIdentifier
    case VideoDescriptionCellIdentifier
    case VideoStatisticCellIdentifier
    case ChannelInfoCellIdentifier
    case SuggestionListCellIdentifier
}



class DetailPageSection{
    var isOpen  = true
    var animatedObject : AnyObject?
    var sectionIdentifier :    DetailPageCellIdentifier?
    var sectionTitle = ""
    var identifer = ""
    var rowObjects :[AnyObject] = [AnyObject]()
    var rowHeight: CGFloat = 80
    var sectionHeaderHeight: CGFloat = 40
    var sectionFooterHeight: CGFloat = 20
    
    // MARK: animate object
    class func addAnimatedObject(section: DetailPageSection,index:Int){
        section.rowObjects.insert(section.animatedObject!, atIndex: index)
    }
    
    class func removeAnimatedObject(section: DetailPageSection,index:Int){
        section.rowObjects.removeAtIndex(index)
    }
    
    // MARK: make different sections
    class func insertVideoInfoSection(videoCache: YoutubeVideoCache,isOpen:Bool) -> [DetailPageSection]{
        var pageSections:[DetailPageSection] = [DetailPageSection]()
        
        var section: DetailPageSection = DetailPageSection.makeVideoInfoObjectSection(videoCache)
        pageSections.append(section)
        
        section = DetailPageSection.makeVideoDescriptionObjectSection(videoCache)
         pageSections.append(section)
        
        section = DetailPageSection.makeVideoStasticsObjectSection(videoCache)
         pageSections.append(section)
        
        return pageSections
    }
    
    // MARK: video info section
    class func makeVideoInfoObjectSection(videoCache: YoutubeVideoCache) -> DetailPageSection{
        let section: DetailPageSection = DetailPageSection()
        
        section.sectionTitle = ""
        section.rowHeight = 60
        section.sectionHeaderHeight = 0
        section.sectionFooterHeight = 0
        section.sectionIdentifier = DetailPageCellIdentifier.VideoInfoCellIdentifier
        section.identifer = VIDEO_INFO_CELL_IDENTIFER
        section.rowObjects.append(VideoInfoObject())
        
        return section
    }
    class func makeVideoDescriptionObjectSection(videoCache: YoutubeVideoCache) -> DetailPageSection{
        let section: DetailPageSection = DetailPageSection()
        
        section.sectionTitle = ""
        section.rowHeight = 160
        section.sectionHeaderHeight = 0
        section.sectionFooterHeight = 0
        section.sectionIdentifier = DetailPageCellIdentifier.VideoDescriptionCellIdentifier
        section.identifer = VIDEO_DESCRIPTION_CELL_IDENTIFER
        section.rowObjects.append(VideoDescriptonObject())
        
        section.animatedObject = section.rowObjects[0]
        
        return section
    }
    
    class func makeVideoStasticsObjectSection(videoCache: YoutubeVideoCache) -> DetailPageSection{
        let section: DetailPageSection = DetailPageSection()
        
        section.sectionTitle = ""
        section.rowHeight = 60
        section.sectionHeaderHeight = 0
        section.sectionFooterHeight = 0
        section.sectionIdentifier = DetailPageCellIdentifier.VideoStatisticCellIdentifier
        section.identifer = VIDEO_STATISTIC_CELL_IDENTIFER
        section.rowObjects.append(VideoStatisticObject())
        
        return section
    }
    
    
    // MARK: suggestion section
    class func makeSuggestionVideoListSection(array:NSArray) -> DetailPageSection{
        let section: DetailPageSection = DetailPageSection()
        
        section.sectionTitle = "Suggestions"
        
        section.sectionIdentifier = DetailPageCellIdentifier.SuggestionListCellIdentifier
        section.identifer = SUGGESTION_CELL_IDENTIFER
        section.rowObjects = array as [AnyObject]
        
        return section
    }
    
}
