//
//  HomeViewController.swift
//  LoseWeight
//
//  Created by Sprint on 04/12/2018.
//  Copyright © 2018 Sprint Solutions. All rights reserved.
//

import UIKit

class ReadyViewController: UIViewController
{
    @IBOutlet var lblMain:UILabel!
    @IBOutlet var lblTime:UILabel!
    @IBOutlet var lblTitle:UILabel!
    @IBOutlet var imgView:UIImageView!
    @IBOutlet var playBtn:UIButton!
    
    var flag = true
    
    var count = 10
    
    var timer:Timer!
    
    var imgsArray:[UIImage]!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle
    {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        count = 10
        let excIndex = userDefaults.integer(forKey: "excIndex")
        let excObj = exerciseArray.object(at: excIndex-1) as! ExerciseObject
        
        lblTime.text = "10"
        lblMain.text = String(format: "DAY 0%i",dayIndex)
        lblTitle.text = excObj.title
        
        imgsArray = UIImage.gifImageWithName(excObj.title)
        imgView.animationImages = imgsArray
        imgView.animationDuration = 1
        imgView.animationRepeatCount = 2000
        imgView.startAnimating()
        
        startTimer()
    }
    
    func startTimer()
    {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    @objc func update()
    {
        if(count > 0)
        {
            count -= 1
            lblTime.text = String(format: "%i", count)
        }
        else
        {
            timer.invalidate()
            
            let startVC = self.storyboard?.instantiateViewController(withIdentifier: "StartExerciseVC") as! StartExerciseVC
            self.navigationController?.pushViewController(startVC, animated: true)
        }
    }
    
    @IBAction func backBtnAction(_ sender:Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func skipBtnAction(_ sender:Any)
    {
        timer.invalidate()
        
        let startVC = self.storyboard?.instantiateViewController(withIdentifier: "StartExerciseVC") as! StartExerciseVC
        self.navigationController?.pushViewController(startVC, animated: true)
    }
    
    @IBAction func playBtnAction(_ sender:Any)
    {
        if flag
        {
            playBtn.setImage(UIImage(named: "play_button"), for: .normal)
            flag = false
            timer.invalidate()
            imgView.stopAnimating()
            imgView.image = imgsArray.first
        }
        else
        {
            playBtn.setImage(UIImage(named: "pause_button"), for: .normal)
            flag = true
            startTimer()
            imgView.startAnimating()
        }
    }
}

