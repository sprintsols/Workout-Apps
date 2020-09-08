//
//  SettingsVC.swift
//  KRIZMA
//
//  Created by Macbook Pro on 17/07/2018.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import MessageUI

class SettingsVC: UIViewController, MFMailComposeViewControllerDelegate
{
    override func viewDidLoad()
    {
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle
    {
        return .lightContent
    }
    
    @IBAction func backBtnAction(_ button:UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resetBtnAction(_ button:UIButton)
    {
        let alert = UIAlertController(title: "Daily Yoga", message: "Are you sure you want to reset your current plan?", preferredStyle: .alert)
        
        let yes = UIAlertAction(title: "Reset", style: .default)
        { (action:UIAlertAction) in
            
            userDefaults.set(1, forKey: "dayIndex")
            userDefaults.set(1, forKey: "excIndex")
            
            let resetAlert = UIAlertController(title: "", message: "Your plan has been resetted successfully.", preferredStyle: .alert)
            resetAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(resetAlert, animated: false, completion: nil)
        }
        
        let no = UIAlertAction(title: "NO", style: .cancel)
        { (action:UIAlertAction) in
            
            
        }
        
        alert.addAction(yes)
        alert.addAction(no)
        present(alert, animated: false, completion: nil)
    }
    
    @IBAction func aboutBtnAction(_ button:UIButton)
    {
        let aboutVC = (self.storyboard?.instantiateViewController(withIdentifier: "AboutViewController")) as! AboutViewController
        self.navigationController?.pushViewController(aboutVC, animated: true)
    }
    
    @IBAction func reminderBtnAction(_ button:UIButton)
    {
        let reminderVC = (self.storyboard?.instantiateViewController(withIdentifier: "ReminderVC")) as! ReminderVC
        self.navigationController?.pushViewController(reminderVC, animated: true)
    }
    
    @IBAction func inviteBtnAction(_ button:UIButton)
    {
        let url:URL = URL(string: "itms-apps://itunes.apple.com/us/developer/Zain%20Ali/id10249785354")!
        
        let activityViewController = UIActivityViewController(activityItems: ["Daily Yoga", url], applicationActivities: nil)

        present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func feedbackBtnAction(_ button:UIButton)
    {
        let mailComposeViewController = configuredMailComposeViewController()
        
        if MFMailComposeViewController.canSendMail()
        {
            self.present(mailComposeViewController, animated: true, completion: nil)
        }
        else
        {
            showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController
    {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["info@sprintsols.com"])
        mailComposerVC.setSubject("Daily Yoga App - Feedback")
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert()
    {
        let sendMailErrorAlert = UIAlertView(title: "", message: "Your device could not send email. Please check email configuration in device settings and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        
        switch result.rawValue
        {
            case MFMailComposeResult.cancelled.rawValue:
                print("Mail cancelled")
            case MFMailComposeResult.saved.rawValue:
               print("Mail saved")
            case MFMailComposeResult.sent.rawValue:
                print("Mail sent")
            case MFMailComposeResult.failed.rawValue:
                print("Mail Failed")
            default:
                break
        }
    }
    
    @IBAction func rateBtnAction(_ button:UIButton)
    {
        if let url = URL(string: "itms-apps://itunes.apple.com/us/developer/Zain%20Ali/id10249785354") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:])
            }
            else
            {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
