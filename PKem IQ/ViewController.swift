//
//  ViewController.swift
//  PKem IQ
//
//  Created by EOSS-TH on 9/1/2558 BE.
//  Copyright (c) 2558 EOSS-TH. All rights reserved.
//

import UIKit
import iAd
import GameKit

class ViewController: UIViewController, GKGameCenterControllerDelegate {

    @IBOutlet weak var leaderBoard: UIButton!
    @IBOutlet weak var maxScore: UILabel!
    @IBOutlet weak var threeNumbers: UIButton!
    @IBOutlet weak var fourNumbers: UIButton!
    @IBOutlet weak var fiveNumbers: UIButton!
    @IBOutlet weak var continue1: UIButton!
    @IBOutlet weak var continue2: UIButton!
    @IBOutlet weak var continue3: UIButton!
    
    @IBOutlet weak var toggleSound: UISwitch!
    
    @IBAction func toggleSound(sender: UISwitch) {
        SoundConfig().toggle(sender.on)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        threeNumbers.makeRoundButton(1.2, radius: 5, color: UIColor.greenColor())
        
        fourNumbers.makeRoundButton(1.2, radius: 5, color: UIColor.yellowColor())
        
        fiveNumbers.makeRoundButton(1.2, radius: 5, color: UIColor.redColor())
        
        continue1.makeRoundButton(1.2, radius: 15, color: UIColor.blueColor())
        
        continue2.makeRoundButton(1.2, radius: 15, color: UIColor.blueColor())
        
        continue3.makeRoundButton(1.2, radius: 15, color: UIColor.blueColor())
        
        let score=Score()
        
        maxScore.text = "Max Score: \(score.max)"
        
        toggleSound.on = SoundConfig().isOn()
        
        threeNumbers.enabled = score.max >= 0
        continue1.hidden = score.last <= 0 || score.last >= 100
        
        fourNumbers.enabled = score.max >= 100
        continue2.hidden = score.last <= 100 || score.last >= 235
        
        fiveNumbers.enabled = score.max >= 235
        continue3.hidden = score.last <= 235 || score.last >= 235 + 129
        
    }
    
    func gameCenter(onSucceed:()->()) {
        
        let localPlayer: GKLocalPlayer = GKLocalPlayer.localPlayer()
        
        if localPlayer.authenticated {
            
            onSucceed()
            
        } else {
            
            localPlayer.authenticateHandler = {(ViewController, error) -> Void in
                
                // 1 Show login if player is not logged in
                if((ViewController) != nil) {
                    
                    self.presentViewController(ViewController!, animated: true, completion: nil)
                    
                }
                    
                    // 2 Player is already euthenticated & logged in, load game center
                else if (localPlayer.authenticated) {
                    
                    // Get the default leaderboard ID
                    localPlayer.loadDefaultLeaderboardIdentifierWithCompletionHandler({ (leaderboardIdentifer: String?, error: NSError?) -> Void in
                        
                        if error != nil {
                            
                            print(error)
                            
                        } else {
                            
                            onSucceed()
                            
                        }
                    })
                    
                    
                } else {
                    
                    // 3 Game center is not enabled on the users device
                    print("Local player could not be authenticated, disabling game center")
                    print(error)
                }
                
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let score=Score()
        
        let levelController = segue.destinationViewController as! LevelController
        
        levelController.soundEnabled = SoundConfig().isOn()
        
        switch segue.identifier! {
        case "3Numbers":
            levelController.level = 1
            levelController.scorePoint = 0
            levelController.index = 0
        case "4Numbers":
            levelController.level = 2
            levelController.scorePoint = 100
            levelController.index = 0
        case "5Numbers":
            levelController.level = 3
            levelController.scorePoint = 235
            levelController.index = 0
        case "continue1":
            levelController.level = 1
            levelController.scorePoint = score.last
            levelController.index = score.last
        case "continue2":
            levelController.level = 2
            levelController.scorePoint = score.last
            levelController.index = score.last - 100
        default:
            levelController.level = 3
            levelController.scorePoint = score.last
            levelController.index = score.last - 100 - 135
        }
        
    }
    
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController) {
        
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func showLeaderboard(sender: AnyObject) {
        
        gameCenter({ () -> () in
            
            let leaderboardID = "PKemIQ"
            let sScore = GKScore(leaderboardIdentifier: leaderboardID)
            sScore.value = Int64(Score().max)
            
            //let localPlayer: GKLocalPlayer = GKLocalPlayer.localPlayer()
            
            let gcVC: GKGameCenterViewController = GKGameCenterViewController()
            gcVC.gameCenterDelegate = self
            gcVC.viewState = GKGameCenterViewControllerState.Leaderboards
            gcVC.leaderboardIdentifier = leaderboardID
            self.presentViewController(gcVC, animated: true, completion: nil)
            
            GKScore.reportScores([sScore], withCompletionHandler: { (error: NSError?) -> Void in
                
                if error != nil {
                    //println(error.localizedDescription)
                }
                
            })
            
            
        })
        
    }
    
}

