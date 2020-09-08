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
        tblView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 95, right: 0)
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
            let title = NSLocalizedString(String(format:"c%i_title%i", dayIndex, i+1), comment: "")
            let sets = NSLocalizedString(String(format:"c%i_sets_count%i", dayIndex, i+1), comment: "")
            let descp = NSLocalizedString(String(format:"c%i_descp%i", dayIndex, i+1), comment: "")
            let pic1 = NSLocalizedString(String(format:"c%i_pic%i_1", dayIndex, i+1), comment: "")
            let pic2 = NSLocalizedString(String(format:"c%i_pic%i_2", dayIndex, i+1), comment: "")
            let pic3 = NSLocalizedString(String(format:"c%i_pic%i_3", dayIndex, i+1), comment: "")
            
            let excObj = ExerciseObject()
            excObj.excID = Int(i)
            excObj.title = title
            excObj.sets = sets
            excObj.descp = descp
            excObj.pic1 = pic1
            excObj.pic2 = pic2
            excObj.pic3 = pic3
            
            exerciseArray.add(excObj)
        }
    }
    
    @IBAction func backBtnAction(_ sender:Any)
    {
        self.navigationController?.popViewController(animated: true)
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
        cell.lblSubTitle.text = String(format: "x%@", excObj.sets)
        cell.imgView.image = UIImage(named: excObj.pic2)
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        excIndex = indexPath.row
        let readyVC = self.storyboard?.instantiateViewController(withIdentifier: "ReadyViewController") as! ReadyViewController
        self.navigationController?.pushViewController(readyVC, animated: true)
    }
}

