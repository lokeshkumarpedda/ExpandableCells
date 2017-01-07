//
//  CellDetails.swift
//  ExpandableCells
//
//  Created by Lokesh on 07/01/17.
//  Copyright © 2017 Next. All rights reserved.
//

import UIKit

class CellDetails {
    var mValue : String?
    var mId : Int?
    var mExpanded : Bool?
    var mIsExpandable : Bool?
    
    init(value : String, id : Int, expanded : Bool , isExpandable : Bool) {
        self.mValue = value
        self.mId = id
        self.mExpanded = expanded
        self.mIsExpandable = isExpandable
    }
}
