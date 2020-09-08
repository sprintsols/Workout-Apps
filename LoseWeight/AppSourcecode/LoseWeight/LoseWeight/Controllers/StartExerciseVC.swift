//
//  HomeViewController.swift
//  LoseWeight
//
//  Created by Sprint on 04/12/2018.
//  Copyright © 2018 Sprint Solutions. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleMobileAds

class StartExerciseVC: UIViewController, GADInterstitialDelegate
{
    @IBOutlet var lblMain:UILabel!
    @IBOutlet var lblExcCount:UILabel!
    @IBOutlet var lblTime:UILabel!
    @IBOutlet var lblTitle:UILabel!
    @IBOutlet var txtDescp:UITextView!
    @IBOutlet var imgView:UIImageView!
    @IBOutlet var playBtn:UIButton!
    @IBOutlet var volumeBtn:UIButton!
    
    @IBOutlet weak var progressBar: LinearProgressBar!
    
    var imgsArray:[UIImage]!
    
    var player: AVAudioPlayer?
    var playflag = true
    var volumeflag = true
    
    var count = 0
    
    var timer:Timer!
    
    var interstitial: GADInterstitial!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let excIndex = userDefaults.integer(forKey: "excIndex")
        let excObj = exerciseArray.object(at: excIndex-1) as! ExerciseObject
        
        lblMain.text = String(format: "DAY 0%i",dayIndex)
        lblExcCount.text = String(format: "%i/%i", excIndex, exerciseArray.count)
        lblTitle.text = excObj.title
        txtDescp.text = excObj.descp
        imgsArray = UIImage.gifImageWithName(excObj.title)
        imgView.animationImages = imgsArray
        imgView.animationDuration = 2
        imgView.animationRepeatCount = 2000
        imgView.startAnimating()
        
        let volumeFlag = userDefaults.integer(forKey: "volumeFlag")
        
        if volumeFlag == 1
        {
            volumeBtn.setImage(UIImage(named: "volume_active"), for: .normal)
        }
        else
        {
            volumeBtn.setImage(UIImage(named: "volume_inactive"), for: .normal)
        }
        
        playSound()
        startTimer()
        
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-1649226560506116/8122166907")
        interstitial.delegate = self
        let request = GADRequest()
        interstitial.load(request)
    }
    
    func interstitialDidReceiveAd(_ ad: GADInterstitial)
    {
        print("Ad received")
        let excIndex = userDefaults.integer(forKey: "excIndex")
        if (excIndex%2) == 0
        {
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
            }
        }
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle
    {
        return .lightContent
    }
    
    func playSound() {
        let path = Bundle.main.path(forResource: "tick.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
        } catch {
            // couldn't load file :(
        }
    }
    
    func startTimer()
    {
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    @objc func update()
    {
        if(count < 20)
        {
            count += 1
            lblTime.text = String(format: "%i/20", count)
            progressBar.progressValue = CGFloat(count * 5)
            
            let volumeFlag = userDefaults.integer(forKey: "volumeFlag")
            if volumeFlag == 1
            {
                player?.play()
            }
        }
        else
        {
            timer.invalidate()
            progressBar.progressValue = 0
            var excIndex = userDefaults.integer(forKey: "excIndex")
            excIndex += 1
            
            if excIndex > exerciseArray.count
            {
                dayIndex = dayIndex+1
                
                if dayIndex > 7
                {
                    userDefaults.set(0, forKey: "dayIndex")
                }
                else
                {
                    userDefaults.set(dayIndex, forKey: "dayIndex")
                }
                userDefaults.set(0, forKey: "excIndex")
                self.navigationController?.popToViewController(homeVC, animated: true)
                
            }
            else
            {
                userDefaults.set(excIndex, forKey: "excIndex")
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func backBtnAction(_ sender:Any)
    {
        timer.invalidate()
        
        let alert = UIAlertController(title: "Lose Weight", message: "Are you sure you want to exit?", preferredStyle: .alert)
        
        let yes = UIAlertAction(title: "YES", style: .default)
        { (action:UIAlertAction) in
            self.navigationController?.popToViewController(exerciseVC, animated: true)
        }
        
        let no = UIAlertAction(title: "NO", style: .cancel)
        { (action:UIAlertAction) in
            self.startTimer()
        }
        
        alert.addAction(yes)
        alert.addAction(no)
        present(alert, animated: false, completion: nil)
    }
    
    @IBAction func playBtnAction(_ sender:Any)
    {
        if playflag
        {
            playBtn.setImage(UIImage(named: "play_button"), for: .normal)
            playflag = false
            timer.invalidate()
            imgView.stopAnimating()
            imgView.image = imgsArray.first
        }
        else
        {
            playBtn.setImage(UIImage(named: "pause_button"), for: .normal)
            playflag = true
            startTimer()
            imgView.startAnimating()
        }
    }
    
    @IBAction func volumeBtnAction(_ sender:Any)
    {
        let volumeFlag = userDefaults.integer(forKey: "volumeFlag")
        
        if volumeFlag == 1
        {
            volumeBtn.setImage(UIImage(named: "volume_inactive"), for: .normal)
            userDefaults.set(2, forKey: "volumeFlag")
        }
        else
        {
            volumeBtn.setImage(UIImage(named: "volume_active"), for: .normal)
            userDefaults.set(1, forKey: "volumeFlag")
        }
    }
}

