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

var excIndex = 0

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
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        lblMain.text = NSLocalizedString(String(format:"c%i", dayIndex), comment: "")
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
        
        let count = NSLocalizedString(String(format:"c%i_count", dayIndex), comment: "") as NSString
        
        for i in 0..<count.intValue
        {
            let title = NSLocalizedString(String(format:"c%i_name%i", dayIndex, i+1), comment: "")
            let imgName = NSLocalizedString(String(format:"c%i_pic%i", dayIndex, i+1), comment: "")
            let descp = NSLocalizedString(String(format:"c%i_descp%i", dayIndex, i+1), comment: "")
            
            let excObj = ExerciseObject()
            excObj.excID = Int(i)
            excObj.title = title
            excObj.imgName = imgName
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
        excIndex = 1
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
        cell.imgView.image = UIImage(named: excObj.imgName)
        
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

