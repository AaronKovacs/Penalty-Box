//
//  SettingsController.swift
//  PenaltyBox
//
//  Created by Aaron Kovacs on 11/19/16.
//  Copyright © 2016 Aaron Kovacs. All rights reserved.
//

import Foundation
import UIKit

class SettingsController: UITableViewController {
    
    @IBOutlet weak var CloseBar: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil) 
        CloseBar.target = self
        CloseBar.action = #selector(close)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
