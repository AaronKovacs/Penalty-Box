//
//  CountdownNavBar.swift
//  PenaltyBox
//
//  Created by Aaron Kovacs on 11/19/16.
//  Copyright © 2016 Aaron Kovacs. All rights reserved.
//

import Foundation

class CountdownNavBar: UIView {
    
    var splitter: UIView = {
        let view: UIView = UIView.init()
        view.backgroundColor = UIColor(red: 0.400, green: 0.400, blue: 0.400, alpha: 1.00)
        return view
    }()
    
    var countDownTimer: UILabel = {
        let label: UILabel = UILabel.init()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.isOpaque = true
        label.backgroundColor = Defaults.BGColor
        label.text = "00:00"
        return label
    }()
    var timeSelectorButton: UIButton = {
        let button: UIButton = UIButton.init()
        button.setTitleColor(Defaults.centralColor, for: .normal)
        button.setTitleColor(UIColor(red: 0.502, green: 0.502, blue: 0.502, alpha: 1.00), for: .highlighted)
        button.setTitle("17 min", for: .normal)
        return button
    }()
    
    var stopPlay: UIButton = {
        let button: UIButton = UIButton.init()
        button.setImage(UIImage(named: "IconReset")?.add_tintedImage(with: Defaults.centralColor, style: ADDImageTintStyleKeepingAlpha), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = Defaults.centralColor
        return button
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.white
        isOpaque = true
        
        addSubview(splitter)
        addSubview(countDownTimer)
        addSubview(timeSelectorButton)
        
        stopPlay.addTarget(self, action: #selector(resetTime), for: .touchUpInside)
        addSubview(stopPlay)
    }
    
    
    @objc func resetTime() {
    }
    
    func setTimeSelectorTitleAttr(title:String) {
    
        let attrString:NSMutableAttributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: title + " ", attributes: [NSForegroundColorAttributeName : Defaults.centralColor, NSFontAttributeName : UIFont.systemFont(ofSize: 14)]))
        
        let attachment: NSTextAttachment = NSTextAttachment()
        attachment.image = UIImage(named: "Sort Down-48")?.add_tintedImage(with: Defaults.centralColor, style: ADDImageTintStyleKeepingAlpha)
        attachment.bounds.origin = CGPoint.init(x: textAttch.bounds.origin.x, y: textAttch.bounds.origin.y + 1)
        attrString.append(NSAttributedString(attachment: attachment))
        
        timeSelectorButton.setAttributedTitle(attrString, for: .normal)
    
    }
    
    func setTimeSelectorTitle(title:String) {
        timeSelectorButton.setTitle(title, for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        splitter.frame = CGRect.init(x: 0, y: self.bounds.height - 0.5, width: self.bounds.width, height: 0.5)
        
        let frameMid = self.frame.height / 2
        timeSelectorButton.frame = CGRect.init(x: 16, y: frameMid - 10, width: 100, height: 20)
        countDownTimer.frame = CGRect.init(x: self.frame.width / 4  , y: frameMid - 10, width: self.frame.width / 2, height: 20)
        stopPlay.frame = CGRect.init(x: self.frame.width - 70, y: frameMid - 20, width: 40, height: 40)
    }
    
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
}
