//
//  tabBarButton.swift
//  PenaltyBox
//
//  Created by Aaron Kovacs on 11/19/16.
//  Copyright © 2016 Aaron Kovacs. All rights reserved.
//

import Foundation

class TabBarButton: UIButton {
    
    var splitter: UIView = {
        let view: UIView = UIView.init()
        view.backgroundColor = UIColor(red: 0.400, green: 0.400, blue: 0.400, alpha: 1.00)
        return view
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        
        
        tintColor = Defaults.BGColor
        backgroundColor = UIColor.white
        isOpaque = true
        clipsToBounds = false
        
        setTitle("Add Penalty", for: .normal)
        setTitleColor(Defaults.centralColor, for: .normal)
        setTitleColor(UIColor(red: 0.498, green: 0.498, blue: 0.498, alpha: 1.00), for: .highlighted)
        
        addSubview(splitter)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        splitter.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}

}
