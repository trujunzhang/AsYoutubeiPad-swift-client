//
//  AutoCompleteProtocol.swift
//  appRestApp
//
//  Created by djzhang on 5/5/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

protocol PopoverContentSelectedProtocol {
    func didSelectItemFromPopover(content: AnyObject)
}

protocol AutoCompleteProtocol {

    func showPopover()

    func hidePopover()

    func search(searchWish: String)
}
