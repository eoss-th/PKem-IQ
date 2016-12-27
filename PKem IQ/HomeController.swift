//
//  ViewController.swift
//  PKem IQ
//
//  Created by EOSS-TH on 9/1/2558 BE.
//  Copyright (c) 2558 EOSS-TH. All rights reserved.
//

import UIKit
import GameKit

class HomeController: UIViewController, GKGameCenterControllerDelegate {

    @IBOutlet weak var leaderBoard: UIButton!
    @IBOutlet weak var maxScore: UILabel!
    @IBOutlet weak var threeNumbers: UIButton!
    @IBOutlet weak var fourNumbers: UIButton!
    @IBOutlet weak var fiveNumbers: UIButton!
    @IBOutlet weak var continue1: UIButton!
    @IBOutlet weak var continue2: UIButton!
    @IBOutlet weak var continue3: UIButton!
    
    @IBOutlet weak var toggleSound: UISwitch!
    
    var localPlayer: GKLocalPlayer?
    
    @IBAction func toggleSound(_ sender: UISwitch) {
        SoundConfig().toggle(sender.isOn)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localPlayer = GKLocalPlayer.localPlayer()
        
        // Do any additional setup after loading the view, typically from a nib.
        leaderBoard.makeRoundButton(1.2, radius: 5, color: UIColor.white)
        
        threeNumbers.makeRoundButton(1.2, radius: 5, color: UIColor.white)
        
        fourNumbers.makeRoundButton(1.2, radius: 5, color: UIColor.white)
        
        fiveNumbers.makeRoundButton(1.2, radius: 5, color: UIColor.white)
        
        continue1.makeRoundButton(1.2, radius: 15, color: UIColor.white)
        
        continue2.makeRoundButton(1.2, radius: 15, color: UIColor.white)
        
        continue3.makeRoundButton(1.2, radius: 15, color: UIColor.white)
        
        let score=Score()
        
        maxScore.text = "Max Score: \(score.max)"
        
        toggleSound.isOn = SoundConfig().isOn()
        
        threeNumbers.isEnabled = score.max >= 0
        continue1.isHidden = score.last <= 0 || score.last >= 100
        
        fourNumbers.isEnabled = score.max >= 100
        continue2.isHidden = score.last <= 100 || score.last >= 235
        
        fiveNumbers.isEnabled = score.max >= 235
        continue3.isHidden = score.last <= 235 || score.last >= 235 + 129
        
    }
    
    func gameCenter(_ sender:UIButton, onSucceed:@escaping ()->()) {
        
        if localPlayer!.isAuthenticated {
            
            onSucceed()
            
        } else {
            
            localPlayer!.authenticateHandler = {(ViewController, error) -> Void in
                
                // 1 Show login if player is not logged in
                if (ViewController) != nil {
                    
                    self.present(ViewController!, animated: true, completion: nil)
                    
                }
                    
                    // 2 Player is already euthenticated & logged in, load game center
                else if self.localPlayer!.isAuthenticated {
                    
                    // Get the default leaderboard ID
                    self.localPlayer!.loadDefaultLeaderboardIdentifier(completionHandler: { (leaderboardIdentifer: String?, error: Error?) -> Void in
                        
                        if error != nil {
                            
                            print(error ?? "")
                            
                        } else {
                            
                            onSucceed()
                            
                        }
                    })
                    
                    
                } else {
                    
                    // 3 Game center is not enabled on the users device
                    print("Local player could not be authenticated, disabling game center")
                    print(error ?? "")
                }
                
                sender.setTitle("World Ranking", for: UIControlState())
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let gameController = segue.destination as! GameController
        gameController.soundEnabled = SoundConfig().isOn()
        
        switch segue.identifier! {
        case "3Numbers":
            gameController.game.newLevel(0)
        case "4Numbers":
            gameController.game.newLevel(1)
        case "5Numbers":
            gameController.game.newLevel(2)
        case "continue1":
            gameController.game.continueLevel(0)
        case "continue2":
            gameController.game.continueLevel(1)
        default:
            gameController.game.continueLevel(2)
        }
        
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func showGameCenter(_ sender: UIButton) {
        
        sender.setTitle("Loading...", for: UIControlState())
        
        gameCenter(sender, onSucceed: { () -> () in
            
            let leaderboardID = "PKemIQ"
            let sScore = GKScore(leaderboardIdentifier: leaderboardID)
            sScore.value = Int64(Score().max)
            
            let gcVC: GKGameCenterViewController = GKGameCenterViewController()
            gcVC.gameCenterDelegate = self
            gcVC.viewState = GKGameCenterViewControllerState.leaderboards
            gcVC.leaderboardIdentifier = leaderboardID
            self.present(gcVC, animated: true, completion: {
                sender.setTitle("World Ranking", for: UIControlState())
            })
            
            GKScore.report([sScore], withCompletionHandler: { (error: Error?) -> Void in
                
                if error != nil {
                }
                
                sender.setTitle("World Ranking", for: UIControlState())
            })
            
        })
    }
    
}

