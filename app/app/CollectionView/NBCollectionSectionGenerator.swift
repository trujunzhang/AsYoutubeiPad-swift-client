//
//  NBCollectionSectionGenerator.swift
//  app
//
//  Created by djzhang on 4/30/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


class NBCollectionSectionGenerator {

    class func generatorSections(array: NSArray) -> [AnyObject] {
        var collectionContents: [AnyObject] = [AnyObject]()

        for object in array{
            println("object is \(object)")
        }

        return collectionContents
    }

}