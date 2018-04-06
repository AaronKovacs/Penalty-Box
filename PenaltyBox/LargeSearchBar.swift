//
//  LargeSearchBar.swift
//  PenaltyBox
//
//  Created by Aaron Kovacs on 11/28/16.
//  Copyright © 2016 Aaron Kovacs. All rights reserved.
//

import Foundation

class LargeSearchBar : UISearchBar, UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let digitSet = CharacterSet.decimalDigits
        for ch in string.unicodeScalars {
            if !digitSet.contains(ch) {
                return false
            }
        }
        
        if textField.text == "" {
            return true
        }
        
        if let length: Int = textField.text?.count {
            if length == 2 {
                textField.text = textField.text?.appending(" : ")
            }
            
            let shouldReplace:Bool = length > 6 ? false : true
            return shouldReplace
        }
        
        return true
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundSearchBar()
    }
    
    func roundSearchBar() {
        let newHeight: CGFloat = 38
        for subView in self.subviews {
            for subsubView in subView.subviews {
                if let textField = subsubView as? UITextField {
                    var currentTextFieldBounds = textField.bounds
                    currentTextFieldBounds.size.height = newHeight
                    textField.bounds = currentTextFieldBounds
                    textField.clipsToBounds = false
                    textField.textAlignment = .center
                    textField.font = UIFont.boldSystemFont(ofSize:  18)
                    textField.setRoundedCorners(UIRectCorner.allCorners, radius: 8)
                }
            }
        }
    }
    
}
