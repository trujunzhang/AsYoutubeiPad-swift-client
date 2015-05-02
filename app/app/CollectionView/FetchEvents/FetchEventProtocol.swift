//
//  FetchEventProtocol.swift
//  app
//
//  Created by djzhang on 5/2/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

protocol FetchEventProtocol {

    func startFetching()
    
    func endFetching()
    
    func nextFetching()
    
    func hasNextFetcing() -> Bool
    
}