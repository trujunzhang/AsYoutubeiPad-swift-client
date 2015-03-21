//
//  AsTableCellProtocols.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/21/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import UIKit


public enum LeftTableRowType {
           case LeftTableRowType_Header
           case LeftTableRowType_Section
           case LeftTableRowType_Row
}

protocol ASTableCellProtocols  {
    func updateForRowAtIndexPath(section:Int, row:Int, rowType:LeftTableRowType)
}
