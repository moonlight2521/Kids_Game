//
//  SortingVC.swift
//  Kids Joy Center
//
//  Created by Zun Lin on 3/22/18.
//  Copyright © 2018 Zun Lin. All rights reserved.
//

import UIKit

class SortingVC: UIViewController, UIGestureRecognizerDelegate {
    
    var setting: String?
    var count = 0
    var x = 0
    var points = 0
    var itemCount = 0
    
    var start = CGPoint()
    
    var itemView = UIView()
    var skyView = UIView()
    var waterView1 = UIView()
    var waterView2 = UIView()
    var sandView1 = UIView()
    var sandView2 = UIView()
    
    var backgroundImage = UIImageView()
    var subView = [UIImageView]()
    
    var itemArray = [UIImageView]()
    var itemNumArray = [Int]()
    var itemNumArray2 = [Int]()
    var itemArray2 = [UIImageView]()
    
    var timelogo = UIImageView()
    var timeMin = UIImageView()
    var timeSec = UIImageView()
    var timeTenthSec = UIImageView()
    
    var scorelogo = UIImageView()
    var scorePoints = UIImageView()
    var scorePoints2 = UIImageView()
    
    var gameTime = Timer()

    var panGR: UIPanGestureRecognizer!
    
    var alert = UIAlertController()
    var yesAction = UIAlertAction()
    var noAction = UIAlertAction()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Let's Sort it!"
        count = 0
        x = 0
        points = 0
        itemCount = 0

        gameTime = Timer()
        
        addbackGround()
        addItem()
        addItemBackground()
        addSkyArea()
        addWaterArea()
        addSandArea()
        screenSetting()
        gameTime = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(addTime), userInfo: nil, repeats: true)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func screenSetting(){
        if (setting == "easy"){
            itemCount = 8
            addImage(num: itemCount)
            count = 60
        }else if (setting == "medium"){
            itemCount = 10
            addImage(num: 10)
            count = 45
        }else if (setting == "hard"){
            itemCount = 12
            addImage(num: 12)
            count = 30
        }
    }
    
    //add toy image to the screen
    func addImage(num: Int){
        for _ in 1...num{
            let randomIndex = Int(arc4random_uniform(UInt32(itemArray.count)))
            itemArray[randomIndex].frame = CGRect(x: 20 + x, y: 100, width: 50, height: 50)
            x = x + 80
            itemArray[randomIndex].isUserInteractionEnabled = true
            self.view.addSubview(itemArray[randomIndex])
            
            panGR = UIPanGestureRecognizer(target: self, action: #selector(panned))

            panGR.delegate = self
            self.itemArray[randomIndex].addGestureRecognizer(panGR)
            itemArray2.append(itemArray[randomIndex])
            itemNumArray2.append(itemNumArray[randomIndex])
            itemArray.remove(at: randomIndex)
            itemNumArray.remove(at: randomIndex)
        }
    }
    //pannding gesture
    @objc func panned(_ sender: UIPanGestureRecognizer){
        let item = sender.view as! UIImageView
        let itemIndex = itemArray2.index(of: item)
        if(sender.state == UIGestureRecognizerState.began){
            start = item.center
        }else if(sender.state == UIGestureRecognizerState.changed){
            sender.view?.center = sender.location(in: sender.view?.superview)
        }else if(sender.state == UIGestureRecognizerState.ended){
            if skyView.frame.intersects(item.frame){
                print("sky")
                if (itemNumArray2[itemIndex!] == 1){
                    points += 5
                    itemCount -= 1
                    addPoints(p: points)
                    addAlert(c: itemCount)
                } else {
                    goback(itemIndex: itemIndex!)
                }
            }
            if waterView1.frame.intersects(item.frame) || waterView2.frame.intersects(item.frame){
                print("water")
                if (itemNumArray2[itemIndex!] == 2){
                    points += 5
                    itemCount -= 1
                    addPoints(p: points)
                    addAlert(c: itemCount)
                } else {
                    goback(itemIndex: itemIndex!)
                }
            }
            
            if sandView1.frame.intersects(item.frame) || sandView2.frame.intersects(item.frame){
                print("sand")
                if (itemNumArray2[itemIndex!] == 3){
                    points += 5
                    itemCount -= 1
                    addPoints(p: points)
                    addAlert(c: itemCount)

                } else {
                    goback(itemIndex: itemIndex!)
                }
            }
        }
    }
    func addAlert (c: Int) {
        if c == 0 {
            alert = UIAlertController(title: "You won!", message: "do you want to play again", preferredStyle: .alert)
            yesAction = UIAlertAction(title: "Yes", style: .cancel, handler:{(UIAlertAction) in self.viewDidLoad()})
            noAction = UIAlertAction(title: "No", style: .default, handler:{(UIAlertAction) in self.navigationController?.popViewController(animated: true)})
            
            alert.addAction(self.yesAction)
            alert.addAction(self.noAction)
            present(self.alert, animated: true, completion: nil)
            
        }
    }
    
    func goback(itemIndex: Int){
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
            self.itemArray2[itemIndex].center = self.start
        }, completion: nil)
    }
    
    //add toy to the array
    func addItem(){
        for i in 1...3{
            for k in 1...5{
                let imageView = UIImageView(image: UIImage(named: "\(i)-\(k)"))
                imageView.contentMode =  UIViewContentMode.scaleAspectFill
                itemArray.append(imageView)
                itemNumArray.append(i)
            }
        }
    }
    
    func addPoints(p: Int){
        let x = p % 10
        let y = p / 10
        scorelogo.image = UIImage(named: "score")
        scorelogo.frame = CGRect(x: 820, y:575, width: 70, height: 40)
        scorelogo.contentMode =  UIViewContentMode.scaleAspectFill
        self.backgroundImage.addSubview(scorelogo)
        
        scorePoints.image = UIImage(named: "cartoon-number-\(y)")
        scorePoints.frame = CGRect(x: 960, y:580, width: 30, height: 30)
        self.backgroundImage.addSubview(scorePoints)
        
        scorePoints2.image = UIImage(named: "cartoon-number-\(x)")
        scorePoints2.frame = CGRect(x: 990, y:580, width: 30, height: 30)
        self.backgroundImage.addSubview(scorePoints2)
    }
    
    @objc func addTime(){
        gameTime.invalidate()

        count -= 1
        let mintues = (count / 60) % 60
        let seconds = (count % 60) / 10
        let tenthSeconds = (count % 60) % 10
        
        timelogo.image = UIImage(named: "time")
        timelogo.frame = CGRect(x: 40, y:565, width: 70, height: 40)
        timelogo.contentMode =  UIViewContentMode.scaleAspectFill
        self.backgroundImage.addSubview(timelogo)
        
        timeMin.image = UIImage(named: "cartoon-number-\(mintues)")
        timeMin.frame = CGRect(x: 150, y:570, width: 30, height: 30)
        self.backgroundImage.addSubview(timeMin)
        
        timeSec.image = UIImage(named: "cartoon-number-\(seconds)")
        timeSec.frame = CGRect(x: 190, y:570, width: 30, height: 30)
        self.backgroundImage.addSubview(timeSec)
        
        timeTenthSec.image = UIImage(named: "cartoon-number-\(tenthSeconds)")
        timeTenthSec.frame = CGRect(x: 230, y:570, width: 30, height: 30)
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
    
//********************************************AddPlayGround**********************************************
    //add backbround image`
    func addbackGround(){
        backgroundImage = UIImageView(frame: CGRect(x: UIScreen.main.bounds.minX, y: 150, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.85))
        backgroundImage.image = UIImage(named: "air-land-water")
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    //add toy item background
    func addItemBackground(){
        itemView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height * 0.25 ))
        itemView.backgroundColor = UIColor.init(red: 0.4039, green: 0.6588, blue: 0.9686, alpha: 1)
        self.view.addSubview(itemView)
    }
    
    func addSkyArea(){
        skyView = UIView(frame: CGRect(x: 0, y: 190 , width: UIScreen.main.bounds.width, height: 330))
        skyView.backgroundColor = UIColor.init(red: 1, green: 1, blue: 0, alpha: 0)
        self.itemView.addSubview(skyView)
    }
    func addWaterArea(){
        waterView1 = UIView(frame: CGRect(x: 0, y: 520 , width: 730, height: 150))
        waterView1.backgroundColor = UIColor.init(red: 1, green: 0, blue:0 , alpha: 0)
        self.itemView.addSubview(waterView1)
        waterView2 = UIView(frame: CGRect(x: 0, y: 670 , width: 500, height: 150))
        waterView2.backgroundColor = UIColor.init(red: 1, green: 0, blue:0 , alpha: 0)
        self.itemView.addSubview(waterView2)
    }
    func addSandArea(){
        sandView1 = UIView(frame: CGRect(x: 730, y: 520 , width: 300, height: 150))
        sandView1.backgroundColor = UIColor.init(red: 0, green: 0, blue:1 , alpha: 0)
        self.itemView.addSubview(sandView1)
        sandView2 = UIView(frame: CGRect(x: 500, y: 670 , width: 600, height: 150))
        sandView2.backgroundColor = UIColor.init(red: 0, green: 0, blue:1 , alpha: 0)
        self.itemView.addSubview(sandView2)
    }
    
}
