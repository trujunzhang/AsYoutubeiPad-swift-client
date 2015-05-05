//
//  AutoCompleteProtocol.swift
//  appRestApp
//
//  Created by djzhang on 5/5/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

typealias SearchBarChangedHandler = (AnyObject!) -> Void

protocol PopoverContentSelectedProtocol {
    func didSelectItemFromPopover(content: AnyObject)
}

protocol PopoverEvent {
    func startPopoverEvent(sender: AnyObject, handler: SearchBarChangedHandler)
}

protocol AutoCompleteProtocol {

    func showPopover()

    func hidePopover()

}
