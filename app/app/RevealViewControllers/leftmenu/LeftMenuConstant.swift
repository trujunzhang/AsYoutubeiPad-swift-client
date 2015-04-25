//
//  leftmenuconstant.swift
//  app
//
//  created by djzhang on 4/21/15.
//  copyright (c) 2015 djzhang. all rights reserved.
//

import foundation


let left_menu_width: cgfloat = 270
let left_menu_icon_wh: cgfloat = 31

let menu_titlebar_height: cgfloat = 56
let menu_section_title_height: cgfloat = 30
let menu_row_height: cgfloat = 58

struct nbtablemodelrowinfo {
    var tablecontents: [anyobject]
    var tablerowheights: [cgfloat]
}


// mark: nbmenutableviewcontroller

extension nbmenutableviewcontroller {

    class func instance() -> nbmenutableviewcontroller {

        var viewcontroller: nbmenutableviewcontroller = uistoryboard(name: "main", bundle: nil).instantiateviewcontrollerwithidentifier("nbmenutableviewcontroller") as! nbmenutableviewcontroller

        return viewcontroller
    }
}