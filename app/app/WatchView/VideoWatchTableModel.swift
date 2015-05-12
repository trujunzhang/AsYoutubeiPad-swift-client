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
    
    var videoInfoSections:[DetailPageSection] = [DetailPageSection]()
    
    let videoCache: YoutubeVideoCache = YoutubeVideoCache()
    var pageSections:[String:DetailPageSection] = [String:DetailPageSection]()
    
    func makeVideoInfoSections() -> [DetailPageSection] {
        self.videoInfoSections = DetailPageSection.insertVideoInfoSection(self.videoCache,videoInfoTappedEnable:self.videoInfoTappedEnable)
        
        return self.videoInfoSections
    }
    
    func makeSideVideos(array:NSArray) -> DetailPageSection {
        let section:DetailPageSection = DetailPageSection.makeSuggestionVideoListSection(array)
        
        return section
    }
    
    func getSectionByIndex(key: String) -> DetailPageSection{
        return self.pageSections[key]!
    }
    
    func getSectionCount() -> Int{
        return self.pageSections.count
    }
    
}