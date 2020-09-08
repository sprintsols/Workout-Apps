//
//  AboutViewController.swift
//  KRIZMA
//
//  Created by Macbook Pro on 19/07/2018.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

//
//  AboutViewController.swift
//  FashionConnect
//
//  Created by Schnell on 06/11/2017.
//  Copyright © 2017 Sprint Solutions. All rights reserved.
//

import UIKit
import UserNotifications

var daysStr = "Never"
var titleStr = "Reminder"

var sunFlag = false
var monFlag = false
var tueFlag = false
var wedFlag = false
var thuFlag = false
var friFlag = false
var satFlag = false

class AddEditReminderVC: UIViewController
{
    @IBOutlet var lblMain:UILabel!
    @IBOutlet var lblRepeat:UILabel!
    @IBOutlet var lblTitle:UILabel!
    
    @IBOutlet var datePicker:UIDatePicker!
    
    @IBOutlet var delView:UIView!
    
    var timeStr = ""
    var time:Date!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if selectedIndex >= 0
        {
            let remObj = remindersArray[selectedIndex]
            titleStr = remObj.title
            daysStr = remObj.daysStr
            timeStr = remObj.timeStr
            setDate(time: remObj.timeStr)
            delView.alpha = 1
            
            sunFlag = remObj.sunFlag
            monFlag = remObj.monFlag
            tueFlag = remObj.tueFlag
            wedFlag = remObj.wedFlag
            thuFlag = remObj.thuFlag
            friFlag = remObj.friFlag
            satFlag = remObj.satFlag
        }
        else
        {
            getDate(date: datePicker.date)
            titleStr = "Reminder"
            daysStr = "Never"
            
            sunFlag = false
            monFlag = false
            tueFlag = false
            wedFlag = false
            thuFlag = false
            friFlag = false
            satFlag = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        lblTitle.text = titleStr
        lblRepeat.text = daysStr
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle
    {
        return .lightContent
    }
    
    @IBAction func backBtnAction(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dateChangeAction(_ sender: UIDatePicker)
    {
        getDate(date: sender.date)
    }
    
    func setDate(time: String)
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        let date = formatter.date(from: time)
        datePicker.setDate(date!, animated: false)
    }
    
    func getDate(date: Date)
    {
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        if let hour = components.hour, let minutes = components.minute
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            time = formatter.date(from: "\(hour):\(minutes)")
            formatter.dateFormat = "hh:mm a"
            timeStr = formatter.string(from: time!)
            print(timeStr)
        }
    }
    
    @IBAction func saveBtnAction(_ sender: UIButton)
    {
        var remID:String = "1"
        var status = "1"
        
        if selectedIndex >= 0
        {
            let remObj = remindersArray[selectedIndex]
            remID = remObj.remID
            status = remObj.status
            remObj.title = titleStr
            remObj.daysStr = daysStr
            remObj.timeStr = timeStr
        }
        else
        {
            if remindersArray.count > 0
            {
                let remObj = remindersArray.last
                remID = String(format: "%i", Int(remObj!.remID)! + 1)
            }
            
            let remObject = ReminderObject(remID: remID, status: status, title: lblTitle.text!, daysStr:daysStr, timeStr: timeStr, sunFlag: sunFlag, monFlag:monFlag, tueFlag:tueFlag, wedFlag:wedFlag, thuFlag:thuFlag, friFlag:friFlag, satFlag:satFlag)
            
            remindersArray.append(remObject)
        }
        
        
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: remindersArray)
        userDefaults.set(encodedData, forKey: "reminders")
        userDefaults.synchronize()
        
        setReminderNotification(remID: remID)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func setReminderNotification(remID: String)
    {
        removeReminders(remID: remID)
        
        let sunIdentifier = String(format: "identifier%@sun", remID)
        let monIdentifier = String(format: "identifier%@mon", remID)
        let tueIdentifier = String(format: "identifier%@tue", remID)
        let wedIdentifier = String(format: "identifier%@wed", remID)
        let thuIdentifier = String(format: "identifier%@thu", remID)
        let friIdentifier = String(format: "identifier%@fri", remID)
        let satIdentifier = String(format: "identifier%@sat", remID)
        
        var flag = false
        
        if sunFlag
        {
            let timeComponents = Calendar.current.dateComponents([.year,.hour,.minute,], from: time)
            let date = createDate(weekday: 1, hour: timeComponents.hour!, minute: timeComponents.minute!, year: timeComponents.year!)
            createNotification(date: date, identifier: sunIdentifier, catIdentifier: String(format: "category%@sun", remID))
            flag = true
        }
        
        if monFlag
        {
            let timeComponents = Calendar.current.dateComponents([.year,.hour,.minute,], from: time)
            let date = createDate(weekday: 2, hour: timeComponents.hour!, minute: timeComponents.minute!, year: timeComponents.year!)
            createNotification(date: date, identifier: monIdentifier, catIdentifier: String(format: "category%@mon", remID))
            flag = true
        }
        
        if tueFlag
        {
            let timeComponents = Calendar.current.dateComponents([.year,.hour,.minute,], from: time)
            let date = createDate(weekday: 3, hour: timeComponents.hour!, minute: timeComponents.minute!, year: timeComponents.year!)
            createNotification(date: date, identifier: tueIdentifier, catIdentifier: String(format: "category%@tue", remID))
            flag = true
        }
        
        if wedFlag
        {
            let timeComponents = Calendar.current.dateComponents([.year,.hour,.minute,], from: time)
            let date = createDate(weekday: 4, hour: timeComponents.hour!, minute: timeComponents.minute!, year: timeComponents.year!)
            createNotification(date: date, identifier: wedIdentifier, catIdentifier: String(format: "category%@wed", remID))
            flag = true
        }
        
        if thuFlag
        {
            let timeComponents = Calendar.current.dateComponents([.year,.hour,.minute,], from: time)
            let date = createDate(weekday: 5, hour: timeComponents.hour!, minute: timeComponents.minute!, year: timeComponents.year!)
            createNotification(date: date, identifier: thuIdentifier, catIdentifier: String(format: "category%@thu", remID))
            flag = true
        }
        
        if friFlag
        {
            let timeComponents = Calendar.current.dateComponents([.year,.hour,.minute,], from: time)
            let date = createDate(weekday: 6, hour: timeComponents.hour!, minute: timeComponents.minute!, year: timeComponents.year!)
            createNotification(date: date, identifier: friIdentifier, catIdentifier: String(format: "category%@fri", remID))
            flag = true
        }
        
        if satFlag
        {
            let timeComponents = Calendar.current.dateComponents([.year,.hour,.minute,], from: time)
            let date = createDate(weekday: 7, hour: timeComponents.hour!, minute: timeComponents.minute!, year: timeComponents.year!)
            createNotification(date: date, identifier: satIdentifier, catIdentifier: String(format: "category%@sat", remID))
            flag = true
        }
        
        if !flag
        {
            createSingleNotification(date: time)
        }
    }
    
    func removeReminders(remID: String)
    {
        let sunIdentifier = String(format: "identifier%@sun", remID)
        let monIdentifier = String(format: "identifier%@mon", remID)
        let tueIdentifier = String(format: "identifier%@tue", remID)
        let wedIdentifier = String(format: "identifier%@wed", remID)
        let thuIdentifier = String(format: "identifier%@thu", remID)
        let friIdentifier = String(format: "identifier%@fri", remID)
        let satIdentifier = String(format: "identifier%@sat", remID)
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [sunIdentifier,monIdentifier,tueIdentifier,wedIdentifier,thuIdentifier,friIdentifier,satIdentifier])
    }
    
    func createDate(weekday: Int, hour: Int, minute: Int, year: Int)->Date
    {
        var components = DateComponents()
        components.hour = hour
        components.minute = minute
        components.year = year
        components.weekday = weekday // sunday = 1 ... saturday = 7
        components.weekdayOrdinal = 10
        components.timeZone = .current
        
        let calendar = Calendar(identifier: .gregorian)
        return calendar.date(from: components)!
    }
    
    func createNotification(date: Date, identifier: String, catIdentifier: String)
    {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = titleStr
        content.sound = UNNotificationSound.default
        
        let triggerDaily = Calendar.current.dateComponents([.weekday,.hour,.minute,.second,], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
        
        let request = UNNotificationRequest(identifier: identifier,
                                            content: content, trigger: trigger)
        let snoozeAction = UNNotificationAction(identifier: "Snooze",
                                                title: "Snooze", options: [])
        
        let category = UNNotificationCategory(identifier:catIdentifier,
                                              actions: [snoozeAction],
                                              intentIdentifiers: [], options: [])
        center.setNotificationCategories([category])
        content.categoryIdentifier = catIdentifier
        
        center.add(request, withCompletionHandler: { (error) in
            if let error = error {
                print(error)
            }
        })
    }
    
    func createSingleNotification(date: Date)
    {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["Reminder"])
        
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = titleStr
        content.sound = UNNotificationSound.default
        
        let triggerDaily = Calendar.current.dateComponents([.hour,.minute,.second,], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: false)
        
        let request = UNNotificationRequest(identifier: "Reminder",
                                            content: content, trigger: trigger)
        let snoozeAction = UNNotificationAction(identifier: "Snooze",
                                                title: "Snooze", options: [])
        
        let category = UNNotificationCategory(identifier:"ReminderCategory",
                                              actions: [snoozeAction],
                                              intentIdentifiers: [], options: [])
        center.setNotificationCategories([category])
        content.categoryIdentifier = "ReminderCategory"
        
        center.add(request, withCompletionHandler: { (error) in
            if let error = error {
                print(error)
            }
        })
    }
    
    @IBAction func deleteBtnAction(_ sender: UIButton)
    {
        let remObj = remindersArray[selectedIndex]
        
        remindersArray.remove(at: selectedIndex)
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["Reminder"])
        removeReminders(remID: remObj.remID)
        
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: remindersArray)
        userDefaults.set(encodedData, forKey: "reminders")
        userDefaults.synchronize()
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func repeatBtnAction(_ sender: UIButton)
    {
        let weekVC = self.storyboard?.instantiateViewController(withIdentifier: "WeekDaysVC") as! WeekDaysVC
        self.navigationController?.pushViewController(weekVC, animated: true)
    }
    
    @IBAction func labelBtnAction(_ sender: UIButton)
    {
        let addVC = self.storyboard?.instantiateViewController(withIdentifier: "AddLabelVC") as! AddLabelVC
        self.navigationController?.pushViewController(addVC, animated: true)
    }
}


