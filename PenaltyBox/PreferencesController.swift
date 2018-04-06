//
//  PreferencesController.swift
//  PenaltyBox
//
//  Created by Aaron Kovacs on 11/28/16.
//  Copyright © 2016 Aaron Kovacs. All rights reserved.
//

import Foundation

class PreferencesController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            UserDefaults.standard.removeObject(forKey: "UserPenalties")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadPenaltyTable"), object: nil)
            
            let alert:UIAlertController = UIAlertController(title: "Success", message: "Saved penalties removed", preferredStyle: .alert)
            alert.addAction(.init(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            

        } else if indexPath.row == 1 {
            UserDefaults.standard.removeObject(forKey: "UserPeriods")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadSearchTable"), object: nil)

            let alert:UIAlertController = UIAlertController(title: "Success", message: "Saved periods removed", preferredStyle: .alert)
            alert.addAction(.init(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
