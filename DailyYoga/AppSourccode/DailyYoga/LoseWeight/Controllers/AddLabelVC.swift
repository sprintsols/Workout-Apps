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

class AddLabelVC: UIViewController
{
    @IBOutlet var txtField:UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        txtField.text = titleStr
        
        txtField.becomeFirstResponder()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle
    {
        return .lightContent
    }
    
    @IBAction func backBtnAction(_ sender: UIButton)
    {
        if !(txtField.text?.isEmpty)!
        {
            titleStr = txtField.text!
        }
        else
        {
            titleStr = "Reminder"
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func crossBtnAction(_ sender: UIButton)
    {
        txtField.text = ""
    }
}


