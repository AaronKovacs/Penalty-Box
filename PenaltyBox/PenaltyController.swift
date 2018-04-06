//
//  PenaltyController.swift
//  PenaltyBox
//
//  Created by Aaron Kovacs on 11/19/16.
//  Copyright © 2016 Aaron Kovacs. All rights reserved.
//

import Foundation
import UIKit

class PenaltyController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: HeaderView!
    
    var players: [APlayer] = [APlayer]()
    
    var dateFormatter: DateFormatter = DateFormatter()
    
    var countDownTimer: CountdownTimer!
    
    override func viewDidLoad() {
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset = UIEdgeInsetsMake(0, 16, 0, 16)
        tableView.tableFooterView = UIView()

        let retrievedPlayers = UserDefaults.standard.array(forKey: "UserPenalties")
        if retrievedPlayers != nil {
        
            let storageArray:[Int] = retrievedPlayers as! [Int]
            
            for i in storageArray
            {
                players.append(APlayer(title: "\(i) min", penaltyEnd: "00:00", length: i))
            }

        } else {
        
            players.append(APlayer(title: "2 min", penaltyEnd: "00:00", length: 2))
            players.append(APlayer(title: "4 min", penaltyEnd: "00:00", length: 3))
            players.append(APlayer(title: "5 min", penaltyEnd: "00:00", length: 5))
            players.append(APlayer(title: "10 min", penaltyEnd: "00:00", length: 10))

        }
        
     
        headerView.infoButton.addTarget(self, action: #selector(optionsController), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reloadData),
            name: NSNotification.Name(rawValue: "reloadPenaltyTable"),
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateCurrentTime),
            name: NSNotification.Name(rawValue: "updateCurrentTime"),
            object: nil
        )
    }
    
    func reloadData() {
    
        players.removeAll()
            
        players.append(APlayer(title: "2 min", penaltyEnd: "00:00", length: 2))
        players.append(APlayer(title: "4 min", penaltyEnd: "00:00", length: 3))
        players.append(APlayer(title: "5 min", penaltyEnd: "00:00", length: 5))
        players.append(APlayer(title: "10 min", penaltyEnd: "00:00", length: 10))
        
        tableView.reloadData()
        
    }
    
    func optionsController() {
    
        let vc = storyboard?.instantiateViewController(withIdentifier: "OptionsVC")
        self.present(vc!, animated: true, completion: nil)
        
    }

    
    func updateCurrentTime() {
        
        var minuteString:String = String(UserInfo.minutes)
        if UserInfo.minutes < 10 {
        
            minuteString = minuteString.insert(string: "0", ind: 0)
        
        }
        
        var secondsString:String = String(UserInfo.seconds)
        if UserInfo.seconds < 10
        {
            
            secondsString = secondsString.insert(string: "0", ind: 0)
            
        }
        
        headerView.titleLabel.text = "\(minuteString) : \(secondsString)"
        headerView.subtitleLabel.text = "\(String(UserInfo.periodLength)) minute periods"

        if UserInfo.minutes != 0 && UserInfo.seconds != 0{
        
            recalculateEndTimes()
            tableView.reloadData()
            
        }
        
    }
    
    
    func recalculateEndTimes() {
    
        let periodLength:Int = UserInfo.periodLength
        let currentMinutes:Int = UserInfo.minutes
        let currentSeconds:Int = UserInfo.seconds
        for i in players
        {
        
            let penaltyLength:Int = i.length
    
            
            if (currentMinutes - penaltyLength) < 0
            {
                //Rollover to next period
                i.subtitle = "Rollover to next period"
                
                let rollover:Int =  periodLength - abs(currentMinutes - penaltyLength)
                var rolloverString:String = String(rollover)
                
                if rollover < 10 {
                    rolloverString = rolloverString.insert(string: "0", ind: 0)
                }
                
                var secondsString:String = String(currentSeconds)
                
                if currentSeconds < 10 {
                    secondsString = secondsString.insert(string: "0", ind: 0)
                }
                
                let timeString:String = "\(rolloverString) : \(secondsString)"
                
                i.penaltyEnd = timeString

            } else {
                let dif:Int = currentMinutes - penaltyLength
                
                var finalTimeString:String = String(dif)
                
                if dif < 10 {
                    finalTimeString = finalTimeString.insert(string: "0", ind: 0)
                }
                
                var secondsString:String = String(currentSeconds)
                
                if currentSeconds < 10 {
                    secondsString = secondsString.insert(string: "0", ind: 0)
                }
                
                let timeString:String = "\(finalTimeString) : \(secondsString)"
                
                i.subtitle = "Current Period"
                
                i.penaltyEnd = timeString
            }
        
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        if indexPath.section == 1 {
        
            var pickerData = [String]()
            
            for i in 1...59 {
                pickerData.append(String(i))
            }
            
            ActionSheetMultipleStringPicker.show(withTitle: "Penalty Length", rows: [
                pickerData
                ], initialSelection: [0], doneBlock: {
                    picker, values, indexes in
                    
                    let newPenaltyLength:Int = Int(values?.first as! Int) + 1
                    
                    let period:APlayer = APlayer(title: "\(newPenaltyLength) min", penaltyEnd: "00:00", length: newPenaltyLength)
                    self.players.append(period)
                    self.tableView.reloadData()
                    
                    var storageArray:[Int] = [Int]()
                    
                    for i in self.players
                    {
                        storageArray.append(i.length)
                    }
                    
                    UserDefaults.standard.set(storageArray, forKey: "UserPenalties")
                    
                    return
            }, cancel: { ActionMultipleStringCancelBlock in return }, origin: self.view.superview)

        
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            if let cell:PlayerCell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell") as? PlayerCell {
                cell.TitleLabel?.text = players[indexPath.row].title
                cell.TimeLabel?.text = players[indexPath.row].penaltyEnd
                cell.SubtitleLabel.text = players[indexPath.row].subtitle
                return cell
            }
        }
        
        return tableView.dequeueReusableCell(withIdentifier: "CreateCell")!
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 4
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let wrapperView: UIView = UIView(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: 16))
        wrapperView.backgroundColor = UIColor.clear
        
        let view: UIView = UIView(frame: CGRect.init(x: 0, y: 12, width: self.view.bounds.width, height: 4))
        view.backgroundColor = UIColor.white
        
        let separator: CAShapeLayer = CAShapeLayer()
        
        separator.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 0.5)).cgPath
        separator.fillColor = UIColor(red: 0.784, green: 0.784, blue: 0.800, alpha: 1.00).cgColor
        
        view.layer.addSublayer(separator)
        
        wrapperView.addSubview(view)
        
        return wrapperView
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view: UIView = UIView(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: 4))
        view.backgroundColor = UIColor.white
        
        let separator: CAShapeLayer = CAShapeLayer()
        separator.path = UIBezierPath(rect: CGRect(x: 0, y: view.frame.height - 0.5, width: self.view.bounds.width, height: 0.5)).cgPath
        separator.fillColor = UIColor(red: 0.784, green: 0.784, blue: 0.800, alpha: 1.00).cgColor
        view.layer.addSublayer(separator)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0
        {
            return 80
            
        }else if indexPath.section == 1
        {
            return 65
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return players.count
            
        } else if section == 1 {
            return 1
        }
        
        return 0
    }
    
    

    
}

extension PenaltyController: PulleyPrimaryContentControllerDelegate {
    func makeUIAdjustmentsForFullscreen(progress: CGFloat) {}
    func drawerChangedDistanceFromBottom(drawer: PulleyViewController, distance: CGFloat) {}
}

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return substring(to: toIndex)
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }
    func insert(string:String,ind:Int) -> String {
        return String(self.characters.prefix(ind)) + string + String(self.characters.suffix(self.characters.count-ind))
    }
    
}

