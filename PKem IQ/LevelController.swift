//
//  Level1Controller.swift
//  PKem IQ
//
//  Created by EOSS-TH on 9/1/2558 BE.
//  Copyright (c) 2558 EOSS-TH. All rights reserved.
//

import UIKit
import iAd

class LevelController : UIViewController {
    
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
    
    var levelJSON: JSON!
    var index: Int = 0
    var scorePoint: Int = 0
    var level: Int = 0
    var myPushed: Array<UIButton>=[]
    
    var timer = NSTimer()
    var timeCounter:Int = 0
    
    var soundEnabled: Bool = false
    
    var sound:Sound!
    
    @IBAction func plus(sender: UIButton) {
        onPushed(sender)
    }
    @IBAction func minus(sender: UIButton) {
        onPushed(sender)
    }
    @IBAction func mul(sender: UIButton) {
        onPushed(sender)
    }
    @IBAction func div(sender: UIButton) {
        onPushed(sender)
    }
    @IBAction func num1(sender: UIButton) {
        onPushed(sender)
    }
    @IBAction func num2(sender: UIButton) {
        onPushed(sender)
    }
    @IBAction func num3(sender: UIButton) {
        onPushed(sender)
    }
    @IBAction func num4(sender: UIButton) {
        onPushed(sender)
    }
    @IBAction func num5(sender: UIButton) {
        onPushed(sender)
    }
    @IBAction func backspace(sender: UISwipeGestureRecognizer) {
        if (myPushed.count>0) {
            
            sound.playBack()
            
            self.myPushed[self.myPushed.count-1].animateRestore()
            
            myPushed.removeAtIndex(myPushed.count-1)
            
            updateAnswer()
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.canDisplayBannerAds = true
        
        self.sound = Sound(enabled: soundEnabled)
        
        answer.layer.borderColor = UIColor.greenColor().CGColor
        answer.textColor = UIColor.greenColor()
        
        score.makeRoundLabel(1.2, radius: 15, color: UIColor.yellowColor())
        answer.makeRoundLabel(2, radius: 30, color: UIColor.greenColor())
        
        menu.makeRoundButton(1.2, radius: 15, color: UIColor.redColor())
        plus.makeRoundButton(1.2, radius: 5, color: UIColor.whiteColor())
        minus.makeRoundButton(1.2, radius: 5, color: UIColor.whiteColor())
        mul.makeRoundButton(1.2, radius: 5, color: UIColor.whiteColor())
        div.makeRoundButton(1.2, radius: 5, color: UIColor.whiteColor())
        num1.makeRoundButton(1.2, radius: 25, color: UIColor.orangeColor())
        num2.makeRoundButton(1.2, radius: 25, color: UIColor.cyanColor())
        num3.makeRoundButton(1.2, radius: 25, color: UIColor.magentaColor())
        num4.makeRoundButton(1.2, radius: 25, color: UIColor.brownColor())
        num5.makeRoundButton(1.2, radius: 25, color: UIColor.purpleColor())
        
        
        let filePath = NSBundle.mainBundle().pathForResource("level\(level)",ofType:"json")
        
        if let data = try? NSData(contentsOfFile:filePath!, options:NSDataReadingOptions.DataReadingMappedAlways) {
            
            levelJSON = JSON(data:data)
            
            next()
        }
        
    }
    
    func updateCounter() {
        
        if timeCounter<=10 && timeCounter > 0 {
            sound.playTick()
        }
        
        if timeCounter==0 {
            sound.playWrong()
        }
        
        if timeCounter<0 {
            performSegueWithIdentifier("menu", sender: nil)
            return
        }
        
        menu.setTitle("\(timeCounter--)", forState: UIControlState.Normal)
        
    }
    
    func next() {
        
        //Level Up!
        if (index>=levelJSON.count) {
            
            performSegueWithIdentifier("menu", sender: nil)
            
            return
        }
        
        sound.playNext()
        timer.invalidate()
        timeCounter = 90
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
        
        myPushed = []
        
        score.text = String(scorePoint)
        answer.text = levelJSON[index]["result"].number?.stringValue
        
        let answers = levelJSON[index]["answers"]
        let answersIndex = Int(arc4random_uniform(UInt32(answers.count)))
        
        if level==1 {
            
            num1.hidden = false
            num2.hidden = false
            num3.hidden = false
            num4.hidden = true
            num5.hidden = true
            plus.hidden = false
            minus.hidden = false
            mul.hidden = false
            div.hidden = false
            
            var choices = [0,2,4]
            var chIndex: Int
            
            chIndex = Int(arc4random_uniform(UInt32(choices.count)))
            num1.setTitle(answers[answersIndex][choices[chIndex]].string, forState: UIControlState.Normal)
            choices.removeAtIndex(chIndex)
            
            chIndex = Int(arc4random_uniform(UInt32(choices.count)))
            num2.setTitle(answers[answersIndex][choices[chIndex]].string, forState: UIControlState.Normal)
            choices.removeAtIndex(chIndex)
            
            num3.setTitle(answers[answersIndex][choices[0]].string, forState: UIControlState.Normal)
            
            num1.animateRestart()
            num2.animateRestart()
            num3.animateRestart()
            
        } else if level==2 {
            
            num1.hidden = false
            num2.hidden = false
            num3.hidden = false
            num4.hidden = false
            num5.hidden = true
            plus.hidden = false
            minus.hidden = false
            mul.hidden = false
            div.hidden = false
            
            var choices = [0,2,4,6]
            var chIndex: Int
            
            chIndex = Int(arc4random_uniform(UInt32(choices.count)))
            num1.setTitle(answers[answersIndex][choices[chIndex]].string, forState: UIControlState.Normal)
            choices.removeAtIndex(chIndex)
            
            chIndex = Int(arc4random_uniform(UInt32(choices.count)))
            num2.setTitle(answers[answersIndex][choices[chIndex]].string, forState: UIControlState.Normal)
            choices.removeAtIndex(chIndex)
            
            chIndex = Int(arc4random_uniform(UInt32(choices.count)))
            num3.setTitle(answers[answersIndex][choices[chIndex]].string, forState: UIControlState.Normal)
            choices.removeAtIndex(chIndex)
            
            num4.setTitle(answers[answersIndex][choices[0]].string, forState: UIControlState.Normal)
            
            num1.animateRestart()
            num2.animateRestart()
            num3.animateRestart()
            num4.animateRestart()
            
        } else if level==3 {
    
            num1.hidden = false
            num2.hidden = false
            num3.hidden = false
            num4.hidden = false
            num5.hidden = false
            plus.hidden = false
            minus.hidden = false
            mul.hidden = false
            div.hidden = false
    
            var choices = [0,2,4,6,8]
            var chIndex: Int
    
            chIndex = Int(arc4random_uniform(UInt32(choices.count)))
            num1.setTitle(answers[answersIndex][choices[chIndex]].string, forState: UIControlState.Normal)
            choices.removeAtIndex(chIndex)
    
            chIndex = Int(arc4random_uniform(UInt32(choices.count)))
            num2.setTitle(answers[answersIndex][choices[chIndex]].string, forState: UIControlState.Normal)
            choices.removeAtIndex(chIndex)
    
            chIndex = Int(arc4random_uniform(UInt32(choices.count)))
            num3.setTitle(answers[answersIndex][choices[chIndex]].string, forState: UIControlState.Normal)
            choices.removeAtIndex(chIndex)
    
            chIndex = Int(arc4random_uniform(UInt32(choices.count)))
            num4.setTitle(answers[answersIndex][choices[chIndex]].string, forState: UIControlState.Normal)
            choices.removeAtIndex(chIndex)
            
            num5.setTitle(answers[answersIndex][choices[0]].string, forState: UIControlState.Normal)
    
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

    func onPushed(button: UIButton) {
        
        sound.playDrop()
        button.animateHide()
        myPushed.append(button)
        
        updateAnswer()
    }
    
    func updateAnswer() {
        
        result.text = ""
        result.textColor = UIColor.blueColor()
        
        for c: UIButton in myPushed {
            result.text = result.text! + " " + c.titleLabel!.text!
        }
        
        if (level==1 && myPushed.count==5) ||
            (level==2 && myPushed.count==7) ||
            (level==3 && myPushed.count==9) {
            
            let answers = levelJSON[index]["answers"]
            
            var match:Bool
            for var i=0; i<answers.count; i++ {
                let corrects = answers[i]
                
                match = true
                for var j=0; j<corrects.count; j++ {
                    if (corrects[j].string != myPushed[j].titleLabel!.text!) {
                        match = false;
                        break;
                    }
                }
                
                if (match) {
                    
                    updateScore()
                    next()
                    return
                    
                }
                
            }
            
            sound.playWrong()
            //Invalid Result
            result.textColor = UIColor.redColor()
            plus.enabled = false
            minus.enabled = false
            mul.enabled = false
            div.enabled = false
            return
            
        }
        
        let isForNum = myPushed.count % 2 == 0
        let isForOpt = myPushed.count % 2 != 0
        num1.enabled = isForNum
        num2.enabled = isForNum
        num3.enabled = isForNum
        num4.enabled = isForNum
        num5.enabled = isForNum
        
        plus.enabled = isForOpt
        minus.enabled = isForOpt
        mul.enabled = isForOpt
        div.enabled = isForOpt
    }
    
    func updateScore() {
        
        let newScore = Score(newScore: ++scorePoint)
        score.text = String(newScore.last)
        
        index++
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func swipeRight(sender: AnyObject) {
        performSegueWithIdentifier("menu", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        timer.invalidate()
        
        let viewController = segue.destinationViewController as! ViewController
        
        viewController.interstitialPresentationPolicy = ADInterstitialPresentationPolicy.Automatic
    }
}