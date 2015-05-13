//
//  VideoWatchTableModel.swift
//  app
//
//  Created by djzhang on 5/12/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import Dollar

class VideoWatchTableModel{
    var LandscapeStep: Int = 0
    var PortraightStep: Int = 0
    
    var videoInfoTappedEnable : Bool = false
    
    var pageSectionDict:[String:DetailPageSection] = [String:DetailPageSection]()
    
    func makeVideoInfoSections(videoCache: YoutubeVideoCache)  {
        let dict:[String:DetailPageSection] = DetailPageSection.insertVideoInfoSection(videoCache,videoInfoTappedEnable:self.videoInfoTappedEnable)
        for (key,value) in dict {
            self.pageSectionDict[key] = value
        }
        let x = 0
    }
    
    func makeSideVideos(array:NSArray) {
        self.pageSectionDict[SECTION_TITLE_CELL_IDENTIFER] =  DetailPageSection.makeSectionTitleSection("Subscription")
        self.pageSectionDict[SUGGESTION_CELL_IDENTIFER] =  DetailPageSection.makeSuggestionVideoListSection(array)
    }
    
    func getSectionByIndex(key: String) -> DetailPageSection{
        
        return self.pageSectionDict[key]!
    }
    
    func getSectionCount() -> Int{
        return self.pageSectionDict.count
    }
    
    func containVideoInfo() -> Bool {
        return $.contains($.keys(self.pageSectionDict), value: VIDEO_INFO_CELL_IDENTIFER)
    }
    
}