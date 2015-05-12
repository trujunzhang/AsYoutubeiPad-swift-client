//
//  VideoWatchTableModel.swift
//  app
//
//  Created by djzhang on 5/12/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


class VideoWatchTableModel{
    var LandscapeStep: Int = 0
    var PortraightStep: Int = 0
    
    var videoInfoTappedEnable : Bool = false
    
    let videoCache: YoutubeVideoCache = YoutubeVideoCache()
    var pageSectionDict:[String:DetailPageSection] = [String:DetailPageSection]()
    
    func makeVideoInfoSections()  {
        let dict:[String:DetailPageSection] = DetailPageSection.insertVideoInfoSection(self.videoCache,videoInfoTappedEnable:self.videoInfoTappedEnable)
        for (key,value) in dict {
            self.pageSectionDict[key] = value
        }
        let x = 0
    }
    
    func makeSideVideos(array:NSArray) {
        self.pageSectionDict[SUGGESTION_CELL_IDENTIFER] =  DetailPageSection.makeSuggestionVideoListSection(array)
    }
    
    func getSectionByIndex(key: String) -> DetailPageSection{
      
        return self.pageSectionDict[key]!
    }
    
    func getSectionCount() -> Int{
        return self.pageSectionDict.count
    }
    
}