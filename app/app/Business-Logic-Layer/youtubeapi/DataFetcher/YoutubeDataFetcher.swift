//
//  YoutubeDataFetcher.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/8/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class YoutubeDataFetcher: NSObject {
    class var sharedInstance: YoutubeDataFetcher {

        struct Singleton {
            static let instance = YoutubeDataFetcher()
        }

        return Singleton.instance
    }


    func fetchCaptainTracksAndCaption(videoID: NSString, completeHandler: ObjectHandler) {

        fetchCaptainTracks(videoID, completeHandler: {
            (array, tracksSucess) -> Void in
            if (tracksSucess == true) {
                let tracksArray: NSArray = array as! NSArray
                if (tracksArray.count == 0) {
                    completeHandler(nil, false)
                } else {
                    self.fetchNextCaptainForVideo(videoID, tracksArray: tracksArray, completeHandler: completeHandler)
                }
            } else {
                completeHandler(nil, false)
            }

        })
    }


    func fetchCaptainTracks(videoID: NSString, completeHandler: ObjectHandler) {
        MABYT3_VideoGoogleRequest.sharedInstance().fetchCaptainTracks(videoID as String, completion: {
            (responseInfo, error) -> Void in

            if (error == nil) {
                var array: NSArray = responseInfo.array as NSArray
                completeHandler(array, true)
            } else {
                completeHandler(nil, false)
            }
        })
    }

    func fetchNextCaptainForVideo(videoID: NSString, tracksArray: NSArray, completeHandler: ObjectHandler) {
        var track: MABYT3_Track = tracksArray[0] as! MABYT3_Track
        if (track.lang_default == true) {
            // 2
            self.fetchCaptainForVideo(videoID, defaultTrack: track, completeHandler: {
                (subtitleString, sucess) -> Void in

                if (sucess == true) {
                    completeHandler(subtitleString, true)
                } else {
                    completeHandler(nil, false)
                }

            })
        }
    }

    func fetchCaptainForVideo(videoID: NSString, defaultTrack: MABYT3_Track, completeHandler: ObjectHandler) {
        MABYT3_VideoGoogleRequest.sharedInstance().fetchVideoTranscript(videoID as String, withTrack: defaultTrack, completion: {
            (responseInfo, error) -> Void in

            if (error == nil) {
                // 2
                var subtitleString: NSString = responseInfo.subtitleString

                if (subtitleString.isEqualToString("") == false) {
                    completeHandler(subtitleString, true)
                } else {

                }


            } else {
                completeHandler(nil, false)
            }
        })
    }

    func autoCompleteSuggestionsWithSearchWish(searchWish: String, completeHandler: ObjectHandler) {
        MABYT3_AutoCompleteRequest.sharedInstance().autoCompleteSuggestionsWithSearchWish(searchWish, completion: {
            (responseInfo, error) -> Void in
            if (error == nil) {
                // array of NSString
                completeHandler(responseInfo.array, true)
            } else {
                completeHandler(nil, false)
            }
        })
    }

}