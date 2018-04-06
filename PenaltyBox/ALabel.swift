//
//  ALabel.swift
//  PenaltyBox
//
//  Created by Aaron Kovacs on 11/19/16.
//  Copyright © 2016 Aaron Kovacs. All rights reserved.
//

import Foundation

class ALabel: UILabel {
    
    init() {
        super.init(frame: CGRect.zero)
        isOpaque = true
        backgroundColor = Defaults.BGColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
