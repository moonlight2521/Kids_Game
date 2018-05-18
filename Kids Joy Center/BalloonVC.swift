//
//  BalloonVC.swift
//  Kids Joy Center
//
//  Created by Zun Lin on 3/22/18.
//  Copyright © 2018 Zun Lin. All rights reserved.
//

import UIKit

class BalloonVC: UIViewController {
    
    var backgroundImage = UIImageView()
    var setting: String?
    var count = 0
    var balloonCount = 0
    
    var randomNum = arc4random_uniform(1)
    var randomSec = Int(arc4random_uniform(6)+20)
    var gameTime = Timer()
    var balloonTime = Timer()

    var balloonArray = [UIImageView]()
    var numberArray = [UIImageView]()
    
    var skull = UIImageView()
    var star = UIImageView()
    var timelogo = UIImageView()
    var timeMin = UIImageView()
    var timeSec = UIImageView()
    var timeTenthSec = UIImageView()
    
    var tapGR : UITapGestureRecognizer!
    
    var alert = UIAlertController()
    var yesAction = UIAlertAction()
    var noAction = UIAlertAction()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Let's pop it!"
        addbackGround()
        addballoon()
       // addTime()
        gameTime = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(addTime), userInfo: nil, repeats: true)
        balloonTime = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(addBalloonToScreen), userInfo: nil, repeats: true)

        if (setting == "easy"){
            count = 60
        }else if (setting == "medium"){
            count = 45
        }else if (setting == "hard"){
            count = 30
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func addBalloonToScreen(){
        balloonCount = balloonCount + 1
        //balloon color
        //var randomBalloonColor = Int(arc4random_uniform(10)) + 1
        let randomLocation = arc4random_uniform(950)
        if (setting == "easy"){
            randomNum = arc4random_uniform(9) + 1
        }else if (setting == "medium"){
            randomNum = arc4random_uniform(7) + 1
        }else if (setting == "hard"){
            randomNum = arc4random_uniform(5) + 1
        }
        
        if balloonCount % randomSec == 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(balloonArray.count)))
            
            balloonArray[randomIndex].frame = CGRect(x: Int(randomLocation), y: 775, width: 80, height: 80)
            star.frame = CGRect(x: 20, y: 20, width: 20, height: 20)

            balloonArray[randomIndex].isUserInteractionEnabled = true
            star.isUserInteractionEnabled = true
            
            balloonArray[randomIndex].addSubview(star)
            view.addSubview(balloonArray[randomIndex])
            
            moveStar(Index: randomIndex)
        } else if balloonCount % randomSec == 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(balloonArray.count)))

            balloonArray[randomIndex].frame = CGRect(x: Int(randomLocation), y: 775, width: 80, height: 80)
            skull.frame = CGRect(x: 20, y: 20, width: 20, height: 20)

            balloonArray[randomIndex].isUserInteractionEnabled = true
            skull.isUserInteractionEnabled = true

            view.addSubview(balloonArray[randomIndex])
            
            balloonArray[randomIndex].addSubview(skull)
            view.addSubview(balloonArray[randomIndex])
            
            moveSkull(Index: randomIndex)
        } else {
            let randomIndex = Int(arc4random_uniform(UInt32(balloonArray.count)))
            
            balloonArray[randomIndex].frame = CGRect(x: Int(randomLocation), y: 775, width: 80, height: 80)
            numberArray[randomIndex].frame = CGRect(x: 20, y: 20, width: 20, height: 20)
            
            balloonArray[randomIndex].isUserInteractionEnabled = true
            numberArray[randomIndex].isUserInteractionEnabled = true
            
            balloonArray[randomIndex].addSubview(numberArray[randomIndex])
            view.addSubview(balloonArray[randomIndex])
            
            moveBalloon(Index: randomIndex)
        }
        
    }
    func moveStar(Index: Int){
        if (setting == "easy"){
            UIView.animate(withDuration: 12, delay: 0, options: [.allowAnimatedContent], animations: {
                self.balloonArray[Index].frame.origin.y -= 1000
            }, completion: nil)
        } else if (setting == "medium"){
            UIView.animate(withDuration: 10, delay: 0, options: .allowUserInteraction, animations: {
                self.balloonArray[Index].frame.origin.y -= 1000
            }, completion: nil)
        } else if (setting == "hard"){
            UIView.animate(withDuration: 8, delay: 0, options: .allowUserInteraction, animations: {
                self.balloonArray[Index].frame.origin.y -= 1000
            }, completion: nil)
        }
    }
    func moveSkull(Index: Int){
        if (setting == "easy"){
            UIView.animate(withDuration: 12, delay: 0, options: [.allowUserInteraction], animations: {
                self.balloonArray[Index].frame.origin.y -= 1000
            }, completion: nil)
        } else if (setting == "medium"){
            UIView.animate(withDuration: 10, delay: 0, options: .allowUserInteraction, animations: {
                self.balloonArray[Index].frame.origin.y -= 1000
            }, completion: nil)
        } else if (setting == "hard"){
            UIView.animate(withDuration: 8, delay: 0, options: .allowUserInteraction, animations: {
                self.balloonArray[Index].frame.origin.y -= 1000
            }, completion: nil)
        }
    }
    func moveBalloon(Index: Int){
        if (setting == "easy"){
            UIView.animate(withDuration: 12, delay: 0, options: [.allowUserInteraction], animations: {
                self.balloonArray[Index].frame.origin.y -= 1000
            }, completion: nil)
        } else if (setting == "medium"){
            UIView.animate(withDuration: 10, delay: 0, options: .allowUserInteraction, animations: {
                self.balloonArray[Index].frame.origin.y -= 1000
            }, completion: nil)
        } else if (setting == "hard"){
            UIView.animate(withDuration: 8, delay: 0, options: .allowUserInteraction, animations: {
                self.balloonArray[Index].frame.origin.y -= 1000
            }, completion: nil)
        }
    }
    func addballoon(){
        for i in 1...10{
            let imageView = UIImageView(image: UIImage(named: "color\(i)"))
            imageView.contentMode =  UIViewContentMode.scaleAspectFill
            balloonArray.append(imageView)
            print("color\(i)")
        }
        for i in 1...10{
            let imageView = UIImageView(image: UIImage(named: "cartoon-number-\(i)"))
            imageView.contentMode =  UIViewContentMode.scaleAspectFill
            numberArray.append(imageView)
            print("cartoon-number-\(i)")
        }
        
        skull = UIImageView(image: UIImage(named: "skull"))
        skull.contentMode =  UIViewContentMode.scaleAspectFill
        
        star = UIImageView(image: UIImage(named: "star"))
        star.contentMode =  UIViewContentMode.scaleAspectFill
        
    }

    func addbackGround(){
        backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "sky-background")
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
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
            gameTime.invalidate()
            
            alert = UIAlertController(title: "Gameover", message: "do you want to play again", preferredStyle: .alert)
            yesAction = UIAlertAction(title: "Yes", style: .default, handler: {(UIAlertAction) in self.viewDidLoad()})
            noAction = UIAlertAction(title: "No", style: .cancel, handler: {(UIAlertAction) in self.navigationController?.popViewController(animated: true)})
           
            alert.addAction(yesAction)
            alert.addAction(noAction)
            
            present(alert, animated: true, completion: nil)
        }
    }
}
