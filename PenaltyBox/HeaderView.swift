//
//  HeaderView.swift
//  PenaltyBox
//
//  Created by Aaron Kovacs on 11/22/16.
//  Copyright © 2016 Aaron Kovacs. All rights reserved.
//

import Foundation

class HeaderView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var infoButton: UIButton!

    let separator CAShapeLayer = CAShapeLayer()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        separator.path = UIBezierPath(rect: CGRect(x: 0, y: self.frame.maxY - 0.5, width: self.bounds.width, height: 0.5)).cgPath
        separator.fillColor = UIColor(red: 0.784, green: 0.784, blue: 0.800, alpha: 1.00).cgColor
        
        layer.addSublayer(self.separator)
    }
    
}
