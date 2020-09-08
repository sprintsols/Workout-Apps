//
//  HomeViewController.swift
//  LoseWeight
//
//  Created by Sprint on 04/12/2018.
//  Copyright © 2018 Sprint Solutions. All rights reserved.
//

import UIKit

class ReadyViewController: UIViewController, UIScrollViewDelegate
{
    @IBOutlet var lblMain:UILabel!
    @IBOutlet var lblTime:UILabel!
    @IBOutlet var lblTitle:UILabel!
    @IBOutlet var playBtn:UIButton!
    
    @IBOutlet var scrollView:UIScrollView!
    @IBOutlet var pager:UIPageControl!
    
    var excObj:ExerciseObject!
    
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
        excObj = exerciseArray.object(at: excIndex) as? ExerciseObject
        
        lblTime.text = "10"
        lblMain.text = NSLocalizedString(String(format:"c%i", dayIndex), comment: "")
        lblTitle.text = excObj.title
        
        startTimer()
        
        fillScrollView()
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
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pager.currentPage = Int(pageIndex)
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
        }
        else
        {
            playBtn.setImage(UIImage(named: "pause_button"), for: .normal)
            flag = true
            startTimer()
        }
    }
}

