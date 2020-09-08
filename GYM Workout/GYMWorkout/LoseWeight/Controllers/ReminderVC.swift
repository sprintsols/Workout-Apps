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

var remindersArray = [ReminderObject]()
var selectedIndex = -1

class ReminderVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UNUserNotificationCenterDelegate
{
    @IBOutlet var tblView:UITableView!
    @IBOutlet var lblNoReminder:UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        getReminders()
        tblView.reloadData()
    }
    
    func getReminders()
    {
        let decoded  = userDefaults.object(forKey: "reminders")
        
        if decoded != nil
        {
            remindersArray = NSKeyedUnarchiver.unarchiveObject(with: decoded as! Data) as! [ReminderObject]
        }
        
        if remindersArray.count == 0
        {
            lblNoReminder.alpha = 1
        }
        else
        {
            lblNoReminder.alpha = 0
        }
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle
    {
        return .lightContent
    }
    
    @IBAction func backBtnAction(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addBtnAction(_ sender: UIButton)
    {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in
            
        })
        center.delegate = self
        
        let addVC = self.storyboard?.instantiateViewController(withIdentifier: "AddEditReminderVC") as! AddEditReminderVC
        selectedIndex = -1
        self.navigationController?.pushViewController(addVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return remindersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:ReminderCell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell", for: indexPath) as! ReminderCell
        
        let remObject = remindersArray[indexPath.row]
        
        cell.lblTime.text = remObject.timeStr
        cell.lblTitle.text = remObject.title
        cell.lblRepeat.text = remObject.daysStr
        
        if remObject.status == "1"
        {
            cell.remSwitch.isOn = true
        }
        else
        {
            cell.remSwitch.isOn = false
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let addVC = self.storyboard?.instantiateViewController(withIdentifier: "AddEditReminderVC") as! AddEditReminderVC
        selectedIndex = indexPath.row
        self.navigationController?.pushViewController(addVC, animated: true)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("zain ali")
        let notifAlert = UIAlertView(title: "Reminder", message: response.notification.request.content.body, delegate: self, cancelButtonTitle: "OK")
        notifAlert.show()
        
    }
}


