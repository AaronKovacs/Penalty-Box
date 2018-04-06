//
//  SearchController.swift
//  PenaltyBox
//
//  Created by Aaron Kovacs on 11/22/16.
//  Copyright © 2016 Aaron Kovacs. All rights reserved.
//

import Foundation

class PickerController: UIViewController {

    @IBOutlet var minutePicker: UIPickerView!
    @IBOutlet var secondsPicker: UIPickerView!
    @IBOutlet var navBar: UINavigationBar!
    @IBOutlet var gripperView: UIView!
    @IBOutlet var seperatorHeightConstraint: NSLayoutConstraint!
    
    var currentIndex:[Int] = [0, 0]
    
    override func viewDidLoad() {
        gripperView.setRoundedCorners(UIRectCorner.allCorners, radius: 2.5)
    }
    
}

extension PickerController: PulleyDrawerViewControllerDelegate {
    
    func makeUIAdjustmentsForFullscreen(progress: CGFloat) { }
    func drawerPositionDidChange(drawer: PulleyViewController){}
    func drawerChangedDistanceFromBottom(drawer: PulleyViewController, distance: CGFloat) { }
    
    func collapsedDrawerHeight() -> CGFloat {
        return 68.0
    }
    
    func partialRevealDrawerHeight() -> CGFloat {
        return 264.0
    }
    
    func supportedDrawerPositions() -> [PulleyPosition] {
        return PulleyPosition.all
    }
    
}
