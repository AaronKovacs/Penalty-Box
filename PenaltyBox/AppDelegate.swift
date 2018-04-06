//
//  AppDelegate.swift
//  PenaltyBox
//
//  Created by Aaron Kovacs on 11/19/16.
//  Copyright © 2016 Aaron Kovacs. All rights reserved.
//

import UIKit
import AVFoundation

struct Defaults {
    
    static var centralColor:UIColor = UIColor(red: 0.366, green: 0.313, blue: 0.768, alpha: 1.00)
    static var BGColor:UIColor = UIColor.white
}

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {}
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}
    func applicationDidEnterBackground(_ application: UIApplication) {}
    func applicationWillEnterForeground(_ application: UIApplication) {}
    func applicationDidBecomeActive(_ application: UIApplication) {}
    func applicationWillTerminate(_ application: UIApplication) {}

}

