//
//  HomeViewController.swift
//  LoseWeight
//
//  Created by Sprint on 04/12/2018.
//  Copyright © 2018 Sprint Solutions. All rights reserved.
//

import UIKit
import AVFoundation

var homeVC: HomeViewController!
let userDefaults = UserDefaults.standard
var dayIndex = 1

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet var lblDays:UILabel!
    @IBOutlet var lblPercentage:UILabel!
    @IBOutlet var tblView:UITableView!
    @IBOutlet weak var progressBar: LinearProgressBar!
    
    var player: AVAudioPlayer?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        homeVC = self
        let volumeFlag = userDefaults.integer(forKey: "volumeFlag")
        
        if volumeFlag < 1
        {
            userDefaults.set(1, forKey: "volumeFlag")
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        tblView.reloadData()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle
    {
        return .lightContent
    }
    
    @IBAction func settingsBtnAction(_ sender:Any)
    {
        let settingsVC = self.storyboard?.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:ExerciseCell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath) as! ExerciseCell
        
        cell.lblTitle.text = String(format: "Day 0%i", indexPath.row+1)
        cell.lblSubTitle.text = NSLocalizedString(String(format: "c%i", indexPath.row+1), comment: "")
        cell.bgView.image = UIImage(named: String(format: "c%i", indexPath.row+1))
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.row != 3 && indexPath.row != 6
        {
            dayIndex = indexPath.row + 1
            
            let excVC = self.storyboard?.instantiateViewController(withIdentifier: "ExerciseVC") as! ExerciseVC
            self.navigationController?.pushViewController(excVC, animated: true)
        }
        else
        {
            DispatchQueue.main.async {
                let restAlert = UIAlertController(title: "", message: "Take rest and enjoy the day.", preferredStyle: .alert)
                restAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(restAlert, animated: false, completion: nil)
            }
        }
    }
}

