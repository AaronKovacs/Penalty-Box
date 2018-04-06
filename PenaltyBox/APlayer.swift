//
//  APlayer.swift
//  PenaltyBox
//
//  Created by Aaron Kovacs on 11/19/16.
//  Copyright © 2016 Aaron Kovacs. All rights reserved.
//

import Foundation
import UIKit

class APlayer {
    
    var title:String!
    var penaltyEnd:String!
    var subtitle:String = "Current Period"
    var length:Int!

    init(title:String, penaltyEnd:String!, length:Int)
    {
    
        self.title = title
        self.penaltyEnd = penaltyEnd
        self.length = length
    
    }
    
}
