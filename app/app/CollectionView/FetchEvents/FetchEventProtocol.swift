//
//  FetchEventProtocol.swift
//  app
//
//  Created by djzhang on 5/2/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

protocol FetchEventProtocol {

    func refreshEvent(completeHandler: ObjectHandler)

    func nextFetching(completeHandler: ObjectHandler)

    func hasNextFetcing() -> Bool

}


//func refreshEvent(completeHandler: ObjectHandler){
//}

//func nextFetching(completeHandler: ObjectHandler){
//}
//func hasNextFetcing() -> Bool {
//    return true
//}