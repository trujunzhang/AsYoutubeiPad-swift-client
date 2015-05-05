//
//  AutoCompletePopoverEvent.swift
//  app
//
//  Created by djzhang on 5/5/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class AutoCompletePopoverEvent: NSObject, PopoverEvent {

    func startPopoverEvent(sender: AnyObject, handler: SearchBarChangedHandler) {
        let searchWish = sender as! String
        YoutubeDataFetcher.sharedInstance.autoCompleteSuggestionsWithSearchWish(searchWish as String, completeHandler: {
            (object, sucess) -> Void in
            if (sucess == true) {
                handler((object as! NSArray) as! [String])
//                self.popoverTableViewController.contents =
            }
        })
    }


}