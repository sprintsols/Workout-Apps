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

class WeekDaysVC: UIViewController
{
    @IBOutlet var sunImgView:UIImageView!
    @IBOutlet var monImgView:UIImageView!
    @IBOutlet var tueImgView:UIImageView!
    @IBOutlet var wedImgView:UIImageView!
    @IBOutlet var thuImgView:UIImageView!
    @IBOutlet var friImgView:UIImageView!
    @IBOutlet var satImgView:UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if sunFlag
        {
            sunImgView.alpha = 1
        }
        
        if monFlag
        {
            monImgView.alpha = 1
        }
        
        if tueFlag
        {
            tueImgView.alpha = 1
        }
        
        if wedFlag
        {
            wedImgView.alpha = 1
        }
        
        if thuFlag
        {
            thuImgView.alpha = 1
        }
        
        if friFlag
        {
            friImgView.alpha = 1
        }
        
        if satFlag
        {
            satImgView.alpha = 1
        }
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle
    {
        return .lightContent
    }
    
    @IBAction func backBtnAction(_ sender: UIButton)
    {
        daysStr = ""
        daysStr = sunFlag ? "Sun," : ""
        daysStr = monFlag ? daysStr + "Mon," : daysStr
        daysStr = tueFlag ? daysStr + "Tue," : daysStr
        daysStr = wedFlag ? daysStr + "Wed," : daysStr
        daysStr = thuFlag ? daysStr + "Thu," : daysStr
        daysStr = friFlag ? daysStr + "Fri," : daysStr
        daysStr = satFlag ? daysStr + "Sat," : daysStr
        
        if daysStr.isEmpty
        {
            daysStr = "Never"
        }
        else
        {
            daysStr = String(daysStr.dropLast())
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sunBtnAction(_ sender: UIButton)
    {
        sunFlag = !sunFlag
        
        if sunFlag
        {
            sunImgView.alpha = 1
        }
        else
        {
            sunImgView.alpha = 0
        }
    }
    
    @IBAction func monBtnAction(_ sender: UIButton)
    {
        monFlag = !monFlag
        
        if monFlag
        {
            monImgView.alpha = 1
        }
        else
        {
            monImgView.alpha = 0
        }
    }
    
    @IBAction func tueBtnAction(_ sender: UIButton)
    {
        tueFlag = !tueFlag
        
        if tueFlag
        {
            tueImgView.alpha = 1
        }
        else
        {
            tueImgView.alpha = 0
        }
    }
    
    @IBAction func wedBtnAction(_ sender: UIButton)
    {
        wedFlag = !wedFlag
        
        if wedFlag
        {
            wedImgView.alpha = 1
        }
        else
        {
            wedImgView.alpha = 0
        }
    }
    
    @IBAction func thuBtnAction(_ sender: UIButton)
    {
        thuFlag = !thuFlag
        
        if thuFlag
        {
            thuImgView.alpha = 1
        }
        else
        {
            thuImgView.alpha = 0
        }
    }
    
    @IBAction func friBtnAction(_ sender: UIButton)
    {
        friFlag = !friFlag
        
        if friFlag
        {
            friImgView.alpha = 1
        }
        else
        {
            friImgView.alpha = 0
        }
    }
    
    @IBAction func satBtnAction(_ sender: UIButton)
    {
        satFlag = !satFlag
        
        if satFlag
        {
            satImgView.alpha = 1
        }
        else
        {
            satImgView.alpha = 0
        }
    }
}


