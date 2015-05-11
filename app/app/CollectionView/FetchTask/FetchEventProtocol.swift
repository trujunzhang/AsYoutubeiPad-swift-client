//
//  FetchTaskProtocol.swift
//  app
//
//  Created by djzhang on 5/2/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

protocol FetchTaskProtocol {

    func refreshEvent(object: AnyObject, completeHandler: ObjectHandler)

    func nextFetching(object: AnyObject, completeHandler: ObjectHandler)

    func endFetching()

    func hasNextFetcing() -> Bool

}


//func refreshEvent(completeHandler: ObjectHandler){
//}

//func nextFetching(completeHandler: ObjectHandler){
//}
//func hasNextFetcing() -> Bool {
//    return true
//}