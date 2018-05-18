//
//  MemoryVC.swift
//  Kids Joy Center
//
//  Created by Zun Lin on 3/21/18.
//  Copyright © 2018 Zun Lin. All rights reserved.
//

import UIKit
import AVFoundation

class MemoryVC: UIViewController, UIGestureRecognizerDelegate {
    
    var setting: String?
    var cover: UIImageView?
    var cardNumArray = [Int]()
    var count = 0
    var time = Timer()
    var temp = Int()
    var pick = true
    var row = 0
    var cloumn = 0
    var points = 0
    var totalCardcount = 0
    
    var backgroundImage = UIImageView()
    var timelogo = UIImageView()
    var timeMin = UIImageView()
    var timeSec = UIImageView()
    var timeTenthSec = UIImageView()
    var scorelogo = UIImageView()
    var scorePoints = UIImageView()
    var scorePoints2 = UIImageView()
    
    
    var imageArray = [UIImageView]()
    var imageArray2 = [UIImageView]()
    var cardCoverArray = [UIImageView]()
    
    
    var tapGR : UITapGestureRecognizer!

    var alert = UIAlertController()
    var yesAction = UIAlertAction()
    var noAction = UIAlertAction()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        cardNumArray = [Int]()
//        count = 0
//        time = Timer()
//        temp = Int()
//        pick = true
//        row = 0
//        cloumn = 0
//        points = 0
//        totalCardcount = 0
        
        self.navigationItem.title = "Let's Match it!"
        addbackGround()
        setScreen()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setScreen(){
        if (setting == "easy"){
            addItem(num: 6)
            totalCardcount = 6
            addbackCard(a: 3, b: 4, x: 100)
            count = 120
            time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(addTime), userInfo: nil, repeats: true)
            
        }else if (setting == "medium"){
            addItem(num: 8)
            addbackCard(a: 4, b: 4, x: 50)
            count = 105
            totalCardcount = 8
            time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(addTime), userInfo: nil, repeats: true)
            
        }else if (setting == "hard"){
            addItem(num: 10)
            addbackCard(a: 5, b: 4, x: 0)
            count = 90
            totalCardcount = 10
            time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(addTime), userInfo: nil, repeats: true)
        }
    }
    
    func addbackCard(a: Int, b: Int, x: Int){
        var index = 0
        for i in 1...a{
            for k in 1...b{
                imageArray[index].frame = CGRect(x: 190 + x + i * 100, y: 110 + k * 100, width: 80, height: 80)
                cardCoverArray[index].frame = CGRect(x: 175 + x + i * 100, y: 100 + k * 100, width: 100, height: 100)
                imageArray[index].isUserInteractionEnabled = true
                cardCoverArray[index].isUserInteractionEnabled = true
                
                self.view.addSubview(imageArray[index])
                self.view.addSubview(cardCoverArray[index])
                
                tapGR = UITapGestureRecognizer(target: self, action: #selector(isTapped))
                tapGR.numberOfTapsRequired = 1
                tapGR.delegate = self

                cardCoverArray[index].addGestureRecognizer(tapGR)
                index += 1
            }
        }
    }

    @objc func isTapped(_ sender: UITapGestureRecognizer){
        let tapped = sender.view as! UIImageView
        let tappedIndex = cardCoverArray.index(of: tapped)
        
        if(pick){
            UIView.animate(withDuration: 1, delay: 0, animations: {
                self.cardCoverArray[tappedIndex!].alpha = 0
            }, completion: nil)
            temp = tappedIndex!
            pick = false
        } else {
            UIView.animate(withDuration: 1, delay: 0, animations: {
                self.cardCoverArray[tappedIndex!].alpha = 0
            }, completion: nil)
            if(cardNumArray[tappedIndex!] == cardNumArray[temp]){
                self.totalCardcount -= 1
                print(self.totalCardcount)
                points += 5
                addPoints(p: points)
                if self.totalCardcount == 0 {
                    self.alert = UIAlertController(title: "You won!", message: "do you want to play again", preferredStyle: .alert)
                    self.yesAction = UIAlertAction(title: "Yes", style: .cancel, handler:{(UIAlertAction) in self.viewDidLoad()})
                    self.noAction = UIAlertAction(title: "No", style: .default, handler:{(UIAlertAction) in self.navigationController?.popViewController(animated: true)})
                    
                    self.alert.addAction(self.yesAction)
                    self.alert.addAction(self.noAction)
                    self.present(self.alert, animated: true, completion: nil)
                }
                
            }
//            print(cardNumArray[tappedIndex!])
//            print(cardNumArray[temp])
            if(cardNumArray[tappedIndex!] != cardNumArray[temp]){
            UIView.animate(withDuration: 1, delay: 0, animations: {
                self.cardCoverArray[tappedIndex!].alpha = 1
                self.cardCoverArray[self.temp].alpha = 1
            }, completion: nil)
            }
            pick = true
        }
    }
    
    // add image to the array 
    func addItem(num: Int){
        while cardNumArray.count < num{
            let randomNum = Int(arc4random_uniform(UInt32(10))) + 1
            if cardNumArray.contains(randomNum){
            } else {
                cardNumArray.append(randomNum)
            }
        }
        let cardNumArray2 = cardNumArray
        for i in 1...cardNumArray2.count{
            let randomNum = Int(arc4random_uniform(UInt32(cardNumArray.count)))
            cardNumArray.insert(cardNumArray2[i-1], at: randomNum)
        }
        for i in 1...cardNumArray.count{
            let imageView = UIImageView(image: UIImage(named: "\(cardNumArray[i-1])"))
            imageView.contentMode =  UIViewContentMode.scaleAspectFill
            imageArray.append(imageView)
        }
        for _ in 1...cardNumArray.count{
            let coverView = UIImageView(image: UIImage(named: "question"))
            coverView.contentMode =  UIViewContentMode.scaleAspectFill
            cardCoverArray.append(coverView)
        }
    }
    //points function
    func addPoints(p: Int){
        let x = p % 10
        let y = p / 10
        scorelogo.image = UIImage(named: "score")
        scorelogo.frame = CGRect(x: 800, y:65, width: 70, height: 40)
        scorelogo.contentMode =  UIViewContentMode.scaleAspectFill
        self.backgroundImage.addSubview(scorelogo)
        
        scorePoints.image = UIImage(named: "cartoon-number-\(y)")
        scorePoints.frame = CGRect(x: 950, y:70, width: 30, height: 30)
        self.backgroundImage.addSubview(scorePoints)
        
        scorePoints2.image = UIImage(named: "cartoon-number-\(x)")
        scorePoints2.frame = CGRect(x: 990, y:70, width: 30, height: 30)
        self.backgroundImage.addSubview(scorePoints2)
    }
    
    //timer image objc function
    @objc func addTime(){
        count -= 1
        let mintues = (count / 60) % 60
        let seconds = (count % 60) / 10
        let tenthSeconds = (count % 60) % 10
        timelogo.image = UIImage(named: "time")
        timelogo.frame = CGRect(x: 40, y:65, width: 70, height: 40)
        timelogo.contentMode =  UIViewContentMode.scaleAspectFill
        self.backgroundImage.addSubview(timelogo)
        
        
        timeMin.image = UIImage(named: "cartoon-number-\(mintues)")
        timeMin.frame = CGRect(x: 150, y:70, width: 30, height: 30)
        self.backgroundImage.addSubview(timeMin)
        
        timeSec.image = UIImage(named: "cartoon-number-\(seconds)")
        timeSec.frame = CGRect(x: 190, y:70, width: 30, height: 30)
        self.backgroundImage.addSubview(timeSec)
        
        timeTenthSec.image = UIImage(named: "cartoon-number-\(tenthSeconds)")
        timeTenthSec.frame = CGRect(x: 230, y:70, width: 30, height: 30)
        self.backgroundImage.addSubview(timeTenthSec)
        if (count == 0) {
            time.invalidate()
            
            alert = UIAlertController(title: "Gameover", message: "do you want to play again", preferredStyle: .alert)
            yesAction = UIAlertAction(title: "Yes", style: .cancel, handler:{(UIAlertAction) in self.setScreen()})
            noAction = UIAlertAction(title: "No", style: .default, handler:{(UIAlertAction) in self.navigationController?.popViewController(animated: true)})

            alert.addAction(yesAction)
            alert.addAction(noAction)
            present(alert, animated: true, completion: nil)
        }
    }
    //background function
    func addbackGround(){
        backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
}

