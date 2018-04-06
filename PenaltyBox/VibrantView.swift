//
//  VibrantView.swift
//  PenaltyBox
//
//  Created by Aaron Kovacs on 11/22/16.
//  Copyright © 2016 Aaron Kovacs. All rights reserved.
//

import Foundation

class VibrantView: UIView {
    
    var gradientLayer: CAGradientLayer!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isOpaque = true
        clipsToBounds = true
        backgroundColor = UIColor.clear
        tintColor = UIColor.white
        layer.cornerRadius = 8.0
        layer.masksToBounds = true
        layer.borderWidth = 0.0
        gradientLayer = applyGradient(colours: [UIColor(red: 0.961, green: 0.404, blue: 0.325, alpha: 1.00), UIColor(red: 0.953, green: 0.227, blue: 0.216, alpha: 1.00)])
        layer.insertSublayer(gradientLayer, at: 0)
    }
   
    
    
}

extension UIView {
    func applyGradient(colours: [UIColor]) -> CAGradientLayer {
        return self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        return gradient
    }
}
