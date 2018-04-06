//
//  SearchController.swift
//  PenaltyBox
//
//  Created by Aaron Kovacs on 11/22/16.
//  Copyright © 2016 Aaron Kovacs. All rights reserved.
//

import Foundation

class SearchController: UIViewController, UITableViewDelegate,UITableViewDataSource {
        
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var gripperView: UIView!
    @IBOutlet var seperatorHeightConstraint: NSLayoutConstraint!
    
    var periods:[APeriod] = [APeriod]()

    var currentIndex:[Int] = [0,0]
    
    override func viewDidLoad() {
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        gripperView.setRoundedCorners(UIRectCorner.allCorners, radius: 2.5)
        
        if let storageArray: [Int] = UserDefaults.standard.array(forKey: "UserPeriods") as? [Int] {
            if storageArray.count > 0 {
                for i in storageArray {
                    periods.append(APeriod(title: "\(i) min", length: i, selected: false))
                }
                
                if periods.count > 0{
                    periods[0].selected = true
                }
            } else {
                periods.append(APeriod(title: "13 min", length: 13, selected: true))
                periods.append(APeriod(title: "17 min", length: 17, selected: false))
            }
        }
        
        searchBar.delegate = self
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reloadData),
            name: NSNotification.Name(rawValue: "reloadSearchTable"),
            object: nil
        )
        
    }
    
    func reloadData() {
       
        periods.removeAll()
        
        periods.append(APeriod(title: "13 min", length: 13, selected: true))
        periods.append(APeriod(title: "17 min", length: 17, selected: false))
        
        
        tableView.reloadData()
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "PeriodSizeCell")!
            
            cell.textLabel?.text = periods[indexPath.row].title
            cell.accessoryType = periods[indexPath.row].selected ? UITableViewCellAccessoryType.checkmark : UITableViewCellAccessoryType.none
            
            return cell
        }
        
        return tableView.dequeueReusableCell(withIdentifier: "CreateCell")!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0
        {
            return 81
            
        }else if indexPath.section == 1
        {
            return 65
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0
        {
            return periods.count
            
        }else if section == 1
        {
            return 1
        }
        
        return 0

    }

    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
        
            tableView.cellForRow(at: indexPath)!.accessoryType = .checkmark
            
            for i in 0...periods.count - 1
            {
            
                if periods[i].selected == true
                {
                
                    
                    tableView.cellForRow(at: NSIndexPath(row: i, section: 0) as IndexPath)!.accessoryType = .none
                                
                }
                periods[i].selected = false
            
            }
            
            periods[indexPath.row].selected = true
            
            UserInfo.periodLength = periods[indexPath.row].length
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateCurrentTime"), object: nil)
            
        }else {
            
            //Add period Length
            var pickerData = [String]()
            
            for i in 1...59 {
                pickerData.append(String(i))
            }
            
            ActionSheetMultipleStringPicker.show(withTitle: "Period Size", rows: [
                pickerData
                ], initialSelection: [0], doneBlock: {
                    picker, values, indexes in
                    
                    let newPeriodLength:Int = Int(values?.first as! Int) + 1
                    
                    let period:APeriod = APeriod(title: "\(newPeriodLength) min", length: newPeriodLength, selected: false)
                    self.periods.append(period)
                    self.tableView.reloadData()
                    
                    var storageArray:[Int] = [Int]()
                    
                    for i in self.periods
                    {
                    
                        storageArray.append(i.length)
                    
                    }
                    
                    UserDefaults.standard.set(storageArray, forKey: "UserPeriods")

                    return
            }, cancel: { ActionMultipleStringCancelBlock in return }, origin: self.view.superview)
        }
    }

    
    
    
    
    


}

extension SearchController: PulleyDrawerViewControllerDelegate {
    
    func makeUIAdjustmentsForFullscreen(progress: CGFloat) {}
    func drawerChangedDistanceFromBottom(drawer: PulleyViewController, distance: CGFloat) {}
    
    func collapsedDrawerHeight() -> CGFloat {
        return 68.0
        
    }
    
    func partialRevealDrawerHeight() -> CGFloat {
        return 264.0
    }
    
    func supportedDrawerPositions() -> [PulleyPosition] {
        return PulleyPosition.all
    }
    
    func drawerPositionDidChange(drawer: PulleyViewController) {
        tableView.isScrollEnabled = drawer.drawerPosition == .open
        
        if drawer.drawerPosition != .open {
            searchBar.resignFirstResponder()
        }
    }
}

extension SearchController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        UserInfo.currentTimeString = searchBar.text!
        if let removedText:String = searchBar.text?.replacingOccurrences(of: " : ", with: "") {
            if removedText.count > 0 {
                let minutesString: String = removedText.substring(to: 2)
                let minutes: Int = Int(minutesString)!
                UserInfo.minutes = minutes
                let secondsString: String = removedText.substring(from: 1)
                let seconds: Int = Int(secondsString)!
                UserInfo.seconds = seconds

                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateCurrentTime"), object: nil)
            }
            
            if let drawerVC = self.parent as? PulleyViewController {
                drawerVC.setDrawerPosition(position: .collapsed, animated: true)
            }
        }
        
        searchBar.resignFirstResponder()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if let drawerVC = self.parent as? PulleyViewController {
            drawerVC.setDrawerPosition(position: .open, animated: true)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let length: Int = text.count
        
        if text == "" {
            return true
        }
        
        if length == 2 {
            searchBar.text = text.appending(" : ")
        }
        
        let shouldReplace: Bool = length > 4 ? false : true
        return shouldReplace
        
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        
        var minutesData: [String] = [String]()
        
        for i in 1...UserInfo.periodLength {
            minutesData.append(String(i))
        }
        
        var secondsData:[String] = [String]()
        
        for i in 1...59 {
            secondsData.append(String(i))
        }
        
        let completion: ActionMultipleStringDoneBlock = { picker, values, indexes in
            if let minutes: Int = values?[0] as? Int {
                if let seconds:Int = values?[1] as? Int {
                    UserInfo.minutes = minutes + 1
                    UserInfo.seconds = seconds + 1
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateCurrentTime"), object: nil)
                    
                    if let drawerVC = self.parent as? PulleyViewController
                    {
                        drawerVC.setDrawerPosition(position: .collapsed, animated: true)
                    }
                }
            }
        }
        
        let cancel: ActionMultipleStringCancelBlock = { block in return }
        
        ActionSheetMultipleStringPicker.show(withTitle: "Current Time", rows: [minutesData,secondsData], initialSelection: currentIndex, doneBlock: completion, cancel: cancel, origin: view.superview!)
        
        return false
    }
}
