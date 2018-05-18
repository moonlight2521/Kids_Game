//
//  ViewController.swift
//  Kids Joy Center
//
//  Created by Zun Lin on 3/17/18.
//  Copyright © 2018 Zun Lin. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var memoryButton: UIButton!
    @IBOutlet weak var sortingButton: UIButton!
    @IBOutlet weak var balloonButton: UIButton!
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var backGroundView: UIImageView!
    
    var difficulty: String?
    var gameType: String?
    var player: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        backGroundView.alpha = 0.5
        
        let audioPath = Bundle.main.path(forResource: "TownTheme", ofType: "mp3")
        
        let url = URL(fileURLWithPath: audioPath!)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        }
        catch {
            print("error")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func selectDifficlty(_ sender: UIButton) {
        switch sender {
            case easyButton:
                easyButton.setTitleColor(UIColor.yellow, for: UIControlState.normal)
                mediumButton.setTitleColor(UIColor.black, for: UIControlState.normal)
                hardButton.setTitleColor(UIColor.black, for: UIControlState.normal)
                difficulty = "easy"

        case mediumButton:
                mediumButton.setTitleColor(UIColor.yellow, for: UIControlState.normal)
                easyButton.setTitleColor(UIColor.black, for: UIControlState.normal)
                hardButton.setTitleColor(UIColor.black, for: UIControlState.normal)
                difficulty = "medium"

        case hardButton:
                hardButton.setTitleColor(UIColor.yellow, for: UIControlState.normal)
                easyButton.setTitleColor(UIColor.black, for: UIControlState.normal)
                mediumButton.setTitleColor(UIColor.black, for: UIControlState.normal)
                difficulty = "hard"
            
        default:
                break
        }
    }
    
    @IBAction func selectGame(_ sender: UIButton) {
        switch sender {
            case memoryButton:
                gameType = "gotoMemoryGame"
                print(gameType!)
            case sortingButton:
                gameType = "gotoSortingGame"
                print(gameType!)
            case balloonButton:
                gameType = "gotoBalloonGame"
                print(gameType!)
            default:
                break
        }
    }
    @IBAction func highScore(_ sender: Any) {
        let alert = UIAlertController(title: "High Score", message: "game Type:     level:      diffeculty:      ", preferredStyle: .alert)
        let action = UIAlertAction(title: "Okey", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func gotoGame(_ sender: UIButton) {
        if (difficulty == nil || gameType == nil){
            let alert = UIAlertController(title: "Error", message: "Please pick a diffculty and game type", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okey", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } else {
            print(gameType!)
            print(difficulty!)
            performSegue(withIdentifier: gameType!, sender: self)
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoMemoryGame"{
            if let memoryVC = segue.destination as? MemoryVC {
                memoryVC.setting = difficulty
            }
        } else if segue.identifier == "gotoSortingGame"{
            if let sortingVC = segue.destination as? SortingVC {
                sortingVC.setting = difficulty
            }
        } else if segue.identifier == "gotoBalloonGame"{
            if let balloonVC = segue.destination as? BalloonVC {
                balloonVC.setting = difficulty
            }
        }
    }
    
}

