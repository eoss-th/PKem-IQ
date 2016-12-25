//
//  Level1Controller.swift
//  PKem IQ
//
//  Created by EOSS-TH on 9/1/2558 BE.
//  Copyright (c) 2558 EOSS-TH. All rights reserved.
//

import UIKit

class GameController : UIViewController {
    
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var answer: UILabel!
    
    @IBOutlet weak var menu: UIButton!
    @IBOutlet weak var num1: UIButton!
    @IBOutlet weak var num2: UIButton!
    @IBOutlet weak var num3: UIButton!
    @IBOutlet weak var num4: UIButton!
    @IBOutlet weak var num5: UIButton!
    @IBOutlet weak var plus: UIButton!
    @IBOutlet weak var minus: UIButton!
    @IBOutlet weak var mul: UIButton!
    @IBOutlet weak var div: UIButton!
    
    let game = Game()
    
    var myPushed: Array<UIButton>=[]
    
    var timer = Timer()
    var timeCounter:Int = 0
    
    var soundEnabled: Bool = false
    
    var sound:Sound!
    
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
        
        answer.layer.borderColor = UIColor.green.cgColor
        answer.textColor = UIColor.green
        
        score.makeRoundLabel(1.2, radius: 15, color: UIColor.yellow)
        answer.makeRoundLabel(2, radius: 30, color: UIColor.green)
        
        menu.makeRoundButton(1.2, radius: 15, color: UIColor.red)
        plus.makeRoundButton(1.2, radius: 5, color: UIColor.white)
        minus.makeRoundButton(1.2, radius: 5, color: UIColor.white)
        mul.makeRoundButton(1.2, radius: 5, color: UIColor.white)
        div.makeRoundButton(1.2, radius: 5, color: UIColor.white)
        num1.makeRoundButton(1.2, radius: 25, color: UIColor.orange)
        num2.makeRoundButton(1.2, radius: 25, color: UIColor.cyan)
        num3.makeRoundButton(1.2, radius: 25, color: UIColor.magenta)
        num4.makeRoundButton(1.2, radius: 25, color: UIColor.brown)
        num5.makeRoundButton(1.2, radius: 25, color: UIColor.purple)
        
        next()
        
    }
    
    func updateCounter() {
        
        if timeCounter<=10 && timeCounter > 0 {
            sound.playTick()
        }
        
        if timeCounter==0 {
            sound.playWrong()
        }
        
        if timeCounter<0 {
            performSegue(withIdentifier: "menu", sender: nil)
            return
        }
        
        menu.setTitle("\(timeCounter)", for: UIControlState())
        timeCounter = timeCounter - 1
        
        updateAnswer()
    }
    
    func next() {
        
        timer.invalidate()
        
        //Level Up!
        if (game.isClearedLevel()) {
            
            print ("Fuck!!!!!")
            
            performSegue(withIdentifier: "menu", sender: nil)
            
            return
        }
        
        timeCounter = 90
        
        timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
        myPushed = []
        
        score.text = String(game.scorePoint)
        answer.text = game.answer()
        
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
        result.textColor = UIColor.blue
        
        for c: UIButton in myPushed {
            result.text = result.text! + " " + c.titleLabel!.text!
        }
        
        if (game.currentLevel==0 && myPushed.count==5) ||
            (game.currentLevel==1 && myPushed.count==7) ||
            (game.currentLevel==2 && myPushed.count==9) || true {
            
            var playerAnswers = [String]()
            for i in 0 ..< myPushed.count {
                playerAnswers.append(myPushed[i].titleLabel!.text!)
            }
            
            if (/*game.isCorrected(playerAnswers)*/ true) {
                
                game.next()
                next()
                
                return
                
            } else {
                
                sound.playWrong()
                //Invalid Result
                result.textColor = UIColor.red
                plus.isEnabled = false
                minus.isEnabled = false
                mul.isEnabled = false
                div.isEnabled = false
                return
                
            }
            
            
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
}
