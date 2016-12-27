//
//  Level1Controller.swift
//  PKem IQ
//
//  Created by EOSS-TH on 9/1/2558 BE.
//  Copyright (c) 2558 EOSS-TH. All rights reserved.
//

import UIKit
import GoogleMobileAds

class GameController : UIViewController {

    @IBOutlet weak var question: UIButton!
    @IBOutlet weak var score: UIButton!
    
    @IBOutlet weak var result: UILabel!
    
    @IBOutlet weak var time: UIButton!
    @IBOutlet weak var num1: UIButton!
    @IBOutlet weak var num2: UIButton!
    @IBOutlet weak var num3: UIButton!
    @IBOutlet weak var num4: UIButton!
    @IBOutlet weak var num5: UIButton!
    @IBOutlet weak var plus: UIButton!
    @IBOutlet weak var minus: UIButton!
    @IBOutlet weak var mul: UIButton!
    @IBOutlet weak var div: UIButton!

    var interstitial: GADInterstitial!

    let game = Game()
    
    var myPushed: Array<UIButton>=[]
    
    var timer = Timer()
    var timeCounter:Int = 0
    
    var soundEnabled: Bool = false
    
    var sound:Sound!
    
    fileprivate func createAndLoadInterstitial() {
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-2408994207086484/5722695057")
        let request = GADRequest()
        // Request test ads on devices you specify. Your test device ID is printed to the console when
        // an ad request is made.
        //request.testDevices = [ kGADSimulatorID, "6cb23b70086e37bbf7c42b9e466ed480" ]
        interstitial.load(request)
    }
    
    @IBAction func plus(_ sender: UIButton) {
        onPushed(sender)
    }
    @IBAction func minus(_ sender: UIButton) {
        onPushed(sender)
    }
    @IBAction func mul(_ sender: UIButton) {
        onPushed(sender)
    }
    @IBAction func div(_ sender: UIButton) {
        onPushed(sender)
    }
    @IBAction func num1(_ sender: UIButton) {
        onPushed(sender)
    }
    @IBAction func num2(_ sender: UIButton) {
        onPushed(sender)
    }
    @IBAction func num3(_ sender: UIButton) {
        onPushed(sender)
    }
    @IBAction func num4(_ sender: UIButton) {
        onPushed(sender)
    }
    @IBAction func num5(_ sender: UIButton) {
        onPushed(sender)
    }
    @IBAction func backspace(_ sender: UISwipeGestureRecognizer) {
        if (myPushed.count>0) {
            
            self.myPushed[self.myPushed.count-1].animateRestore()
            
            myPushed.remove(at: myPushed.count-1)
            
            updateAnswer()
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.sound = Sound(enabled: soundEnabled)
        
        score.makeRoundButton(1.2, radius: 15, color: UIColor.white)
        question.makeRoundButton(2, radius: 30, color: UIColor.white)
        time.makeRoundButton(1.2, radius: 15, color: UIColor.white)
        plus.makeRoundButton(1.2, radius: 5, color: UIColor.white)
        minus.makeRoundButton(1.2, radius: 5, color: UIColor.white)
        mul.makeRoundButton(1.2, radius: 5, color: UIColor.white)
        div.makeRoundButton(1.2, radius: 5, color: UIColor.white)
        num1.makeRoundButton(1.2, radius: 25, color: UIColor.white)
        num2.makeRoundButton(1.2, radius: 25, color: UIColor.white)
        num3.makeRoundButton(1.2, radius: 25, color: UIColor.white)
        num4.makeRoundButton(1.2, radius: 25, color: UIColor.white)
        num5.makeRoundButton(1.2, radius: 25, color: UIColor.white)
        
        next()
        
    }
    
    func updateCounter() {
        
        if timeCounter<=10 && timeCounter > 0 {
            sound.playTick()
        }
        
        if timeCounter > 0 {
            
            if result.textColor == UIColor.red && timeCounter % 5 == 0 {
                toast("Swipe Left to Undo")
            }
            
            if result.text == "" && timeCounter % 10 == 0 {
                toast("Press a Number!")
            }
            
        } else {
            toast("Game Over!")
        }
        
        if timeCounter==0 {
            sound.playWrong()
        }
        
        if timeCounter<0 {
            performSegue(withIdentifier: "menu", sender: nil)
            return
        }
        
        time.setTitle("\(timeCounter)", for: UIControlState())
        timeCounter = timeCounter - 1
        
        //updateAnswer()
    }
    
    func next() {
        
        createAndLoadInterstitial()
        timer.invalidate()
        
        //Level Up!
        if game.isClearedLevel() {
            
            performSegue(withIdentifier: "menu", sender: nil)
            
            return
        }
        
        timeCounter = 90
        
        timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
        myPushed = []
        
        score.setTitle(String(game.scorePoint), for: UIControlState())
        question.setTitle(game.answer(), for: UIControlState())
        
        let answers = game.answers()
        let answersIndex = Int(arc4random_uniform(UInt32(answers.count)))
        
        if game.currentLevel==0 {
            
            num1.isHidden = false
            num2.isHidden = false
            num3.isHidden = false
            num4.isHidden = true
            num5.isHidden = true
            plus.isHidden = false
            minus.isHidden = false
            mul.isHidden = false
            div.isHidden = false
            
            var choices = [0,2,4]
            var chIndex: Int
            
            chIndex = Int(arc4random_uniform(UInt32(choices.count)))
            num1.setTitle(answers[answersIndex][choices[chIndex]].string, for: UIControlState())
            choices.remove(at: chIndex)
            
            chIndex = Int(arc4random_uniform(UInt32(choices.count)))
            num2.setTitle(answers[answersIndex][choices[chIndex]].string, for: UIControlState())
            choices.remove(at: chIndex)
            
            num3.setTitle(answers[answersIndex][choices[0]].string, for: UIControlState())
            
            num1.animateRestart()
            num2.animateRestart()
            num3.animateRestart()
            
        } else if game.currentLevel==1 {
            
            num1.isHidden = false
            num2.isHidden = false
            num3.isHidden = false
            num4.isHidden = false
            num5.isHidden = true
            plus.isHidden = false
            minus.isHidden = false
            mul.isHidden = false
            div.isHidden = false
            
            var choices = [0,2,4,6]
            var chIndex: Int
            
            chIndex = Int(arc4random_uniform(UInt32(choices.count)))
            num1.setTitle(answers[answersIndex][choices[chIndex]].string, for: UIControlState())
            choices.remove(at: chIndex)
            
            chIndex = Int(arc4random_uniform(UInt32(choices.count)))
            num2.setTitle(answers[answersIndex][choices[chIndex]].string, for: UIControlState())
            choices.remove(at: chIndex)
            
            chIndex = Int(arc4random_uniform(UInt32(choices.count)))
            num3.setTitle(answers[answersIndex][choices[chIndex]].string, for: UIControlState())
            choices.remove(at: chIndex)
            
            num4.setTitle(answers[answersIndex][choices[0]].string, for: UIControlState())
            
            num1.animateRestart()
            num2.animateRestart()
            num3.animateRestart()
            num4.animateRestart()
            
        } else if game.currentLevel==2 {
    
            num1.isHidden = false
            num2.isHidden = false
            num3.isHidden = false
            num4.isHidden = false
            num5.isHidden = false
            plus.isHidden = false
            minus.isHidden = false
            mul.isHidden = false
            div.isHidden = false
    
            var choices = [0,2,4,6,8]
            var chIndex: Int
    
            chIndex = Int(arc4random_uniform(UInt32(choices.count)))
            num1.setTitle(answers[answersIndex][choices[chIndex]].string, for: UIControlState())
            choices.remove(at: chIndex)
    
            chIndex = Int(arc4random_uniform(UInt32(choices.count)))
            num2.setTitle(answers[answersIndex][choices[chIndex]].string, for: UIControlState())
            choices.remove(at: chIndex)
    
            chIndex = Int(arc4random_uniform(UInt32(choices.count)))
            num3.setTitle(answers[answersIndex][choices[chIndex]].string, for: UIControlState())
            choices.remove(at: chIndex)
    
            chIndex = Int(arc4random_uniform(UInt32(choices.count)))
            num4.setTitle(answers[answersIndex][choices[chIndex]].string, for: UIControlState())
            choices.remove(at: chIndex)
            
            num5.setTitle(answers[answersIndex][choices[0]].string, for: UIControlState())
    
            num1.animateRestart()
            num2.animateRestart()
            num3.animateRestart()
            num4.animateRestart()
            num5.animateRestart()
    
        }
        
        plus.animateRestart()
        minus.animateRestart()
        mul.animateRestart()
        div.animateRestart()
    
        updateAnswer()
    }

    func onPushed(_ button: UIButton) {
        
        sound.playDrop()
        button.animateHide()
        myPushed.append(button)
        
        updateAnswer()
    }
    
    func updateAnswer() {
        
        result.text = ""
        result.textColor = UIColor.white
        
        var playerAnswers = [String]()
        
        for c: UIButton in myPushed {
            playerAnswers.append(c.titleLabel!.text!)
            
            result.text = result.text! + " " + c.titleLabel!.text!
            
            if playerAnswers.count > 1 &&
                playerAnswers.count % 2 != 0 &&
                playerAnswers.count < game.playerAnswersCompletedCount() {
                
                result.text = "[" + result.text! + " ]"
                
            }
        }
        
        if game.isCompleted(playerAnswers) {
            
            if game.isCorrected(playerAnswers) {
                
                if interstitial.isReady {
                    interstitial.present(fromRootViewController: self)
                }
                
                game.next()
                next()
                            
            } else {
                
                sound.playWrong()
                //Invalid Result
                result.textColor = UIColor.red
                plus.isEnabled = false
                minus.isEnabled = false
                mul.isEnabled = false
                div.isEnabled = false
                
            }
            
            return
        }
        
        let isForNum = myPushed.count % 2 == 0
        let isForOpt = myPushed.count % 2 != 0
        num1.isEnabled = isForNum
        num2.isEnabled = isForNum
        num3.isEnabled = isForNum
        num4.isEnabled = isForNum
        num5.isEnabled = isForNum
        
        plus.isEnabled = isForOpt
        minus.isEnabled = isForOpt
        mul.isEnabled = isForOpt
        div.isEnabled = isForOpt
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func swipeRight(_ sender: AnyObject) {
        performSegue(withIdentifier: "menu", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        timer.invalidate()
        
    }
    
    func toast(_ text:String) {
        
        let toastLabel = UILabel(frame: CGRect(x:self.view.frame.size.width/2 - 150, y:self.view.frame.size.height/3 + 20, width:300, height:35))
        
        toastLabel.text = text
        toastLabel.textColor = UIColor.white
        toastLabel.font = UIFont(name: "Sunshiney", size: 25)
        toastLabel.textAlignment = NSTextAlignment.center;
        //toastLabel.backgroundColor = UIColor.red
        //toastLabel.layer.cornerRadius = 10;
        toastLabel.alpha = 1.0
        toastLabel.clipsToBounds  =  true
        
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 3.0, delay: 0.1, options: UIViewAnimationOptions.curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {
            (finished: Bool) in
            toastLabel.removeFromSuperview()
        })
    }
}
