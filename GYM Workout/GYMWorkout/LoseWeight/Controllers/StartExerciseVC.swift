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

class StartExerciseVC: UIViewController, GADInterstitialDelegate, UIScrollViewDelegate
{
    @IBOutlet var lblMain:UILabel!
    @IBOutlet var lblExcCount:UILabel!
    @IBOutlet var lblTime:UILabel!
    @IBOutlet var lblTitle:UILabel!
    @IBOutlet var txtDescp:UITextView!
    @IBOutlet var playBtn:UIButton!
    @IBOutlet var volumeBtn:UIButton!
    
    @IBOutlet var scrollView:UIScrollView!
    @IBOutlet var pager:UIPageControl!
    
    @IBOutlet weak var progressBar: LinearProgressBar!
    
    var imgsArray:[UIImage]!
    
    var player: AVAudioPlayer?
    var playflag = true
    var volumeflag = true
    
    var count = 0
    
    var timer:Timer!
    
    var interstitial: GADInterstitial!
    
    var excObj:ExerciseObject!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        excObj = exerciseArray.object(at: excIndex) as? ExerciseObject
        
        lblMain.text = NSLocalizedString(String(format:"c%i", dayIndex), comment: "")
        lblExcCount.text = String(format: "%i/%i", excIndex+1, exerciseArray.count)
        lblTitle.text = excObj.title
        txtDescp.text = excObj.descp
        lblTime.text = String(format: "0/%@", excObj.sets)
        
        fillScrollView()
        
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
        
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-1649226560506116/2301044728")
        interstitial.delegate = self
        let request = GADRequest()
        interstitial.load(request)
    }
    
    func interstitialDidReceiveAd(_ ad: GADInterstitial)
    {
        print("Ad received")
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
    
    func fillScrollView()
    {
        for view in scrollView.subviews
        {
            view.removeFromSuperview()
        }
        
        let imgView = UIImageView()
        imgView.frame = CGRect(x: 0, y: 0, width: 302, height: 201)
        imgView.image = UIImage(named: excObj.pic1)
        
        let imgView1 = UIImageView()
        imgView1.frame = CGRect(x: 302, y: 0, width: 302, height: 201)
        imgView1.image = UIImage(named: excObj.pic2)
        
        scrollView.addSubview(imgView)
        scrollView.addSubview(imgView1)
        
        var increment:CGFloat = 602
        var pages = 2
        
        if dayIndex == 5 && (excIndex == 1 || excIndex == 4)
        {
            let imgView2 = UIImageView()
            imgView2.frame = CGRect(x: 604, y: 0, width: 302, height: 201)
            imgView2.image = UIImage(named: excObj.pic3)
            scrollView.addSubview(imgView2)
            increment += 302
            pages = 3
        }
        
        pager.numberOfPages = pages
        scrollView.contentSize = CGSize(width: increment, height: 150)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
        pager.currentPage = Int(page)
    }
    
    func playSound()
    {
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
        let sets = Int(excObj.sets)!
        
        if(count < sets)
        {
            count += 1
            lblTime.text = String(format: "%i/%@", count, excObj.sets)
            
            var val = 10.0
            
            if sets == 15
            {
                val = 6.7
            }
            
            progressBar.progressValue = CGFloat(Double(count) * val)
            
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
            
            excIndex += 1
            
            if excIndex >= exerciseArray.count
            {
                if dayIndex == 3 || dayIndex == 6
                {
                    dayIndex = dayIndex+2
                }
                else
                {
                    dayIndex = dayIndex+1
                }
                
                self.navigationController?.popToViewController(homeVC, animated: true)
                
            }
            else
            {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func backBtnAction(_ sender:Any)
    {
        timer.invalidate()
        
        let alert = UIAlertController(title: "GYM WORKOUT", message: "Are you sure you want to exit?", preferredStyle: .alert)
        
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
        }
        else
        {
            playBtn.setImage(UIImage(named: "pause_button"), for: .normal)
            playflag = true
            startTimer()
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

