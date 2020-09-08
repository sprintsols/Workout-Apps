//
//  ExcerciseVC.swift
//  LoseWeight
//
//  Created by Sprint on 04/12/2018.
//  Copyright © 2018 Sprint Solutions. All rights reserved.
//

import UIKit

var exerciseArray = NSMutableArray()
var exerciseVC:ExerciseVC!
var selectedExc:ExerciseObject!

class ExerciseVC: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet var lblMain:UILabel!
    @IBOutlet var tblView:UITableView!
    @IBOutlet var startView:UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        exerciseVC = self
        
        let day = userDefaults.integer(forKey: "dayIndex")
        
        if day != dayIndex
        {
            startView.alpha = 0
        }
        else
        {
            tblView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 95, right: 0)
            startView.alpha = 1
            
            let excIndex = userDefaults.integer(forKey: "excIndex")
            if excIndex < 1
            {
                userDefaults.set(1, forKey: "excIndex")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        lblMain.text = String(format: "DAY 0%i",dayIndex)
        getExcercises()
        tblView.reloadData()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle
    {
        return .lightContent
    }

    func getExcercises()
    {
        exerciseArray = NSMutableArray()
        
        let count = NSLocalizedString(String(format:"Day%i_count", dayIndex), comment: "") as NSString
        
        for i in 0..<count.intValue
        {
            let title = NSLocalizedString(String(format:"Day%i_title%i", dayIndex, i+1), comment: "")
            let descp = NSLocalizedString(String(format:"Day%i_descp%i", dayIndex, i+1), comment: "")
            
            let excObj = ExerciseObject()
            excObj.excID = Int(i)
            excObj.title = title
            excObj.descp = descp
            
            exerciseArray.add(excObj)
        }
    }
    
    @IBAction func backBtnAction(_ sender:Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func startBtnAction(_ sender:Any)
    {
        userDefaults.set(dayIndex, forKey: "dayIndex")
        
        let readyVC = self.storyboard?.instantiateViewController(withIdentifier: "ReadyViewController") as! ReadyViewController
        self.navigationController?.pushViewController(readyVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return exerciseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:ExerciseCell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath) as! ExerciseCell
        
        let excObj = exerciseArray.object(at: indexPath.row) as! ExerciseObject
        cell.lblTitle.text = excObj.title
        cell.imgView.image = UIImage.gifImageWithName(excObj.title)
        
        let excIndex = userDefaults.integer(forKey: "excIndex")
        
        let day = userDefaults.integer(forKey: "dayIndex")
        
        if day == dayIndex
        {
            if excIndex == indexPath.row + 1
            {
                cell.bgView.image = UIImage(named: "exercise_selected_bg")
                cell.lblTitle.textColor = UIColor.white
                cell.lblSubTitle.textColor = UIColor.white
            }
            else
            {
                cell.bgView.image = UIImage(named: "exercise_bg")
                cell.lblTitle.textColor = UIColor(red: 83.0/255.0, green: 90.0/255.0, blue: 93.0/255.0, alpha: 1)
                cell.lblSubTitle.textColor = UIColor(red: 254.0/255.0, green: 107.0/255.0, blue: 0, alpha: 1)
            }
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
}

