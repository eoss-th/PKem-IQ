//
//  Sound.swift
//  PKem IQ
//
//  Created by Wisarut Srisawet on 10/9/58.
//  Copyright (c) พ.ศ. 2558 EOSS-TH. All rights reserved.
//

import Foundation
import AVFoundation

class Sound {
    
    let enabled:Bool
    
    let dropSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("drop", ofType: "wav")!)
    let backSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("back", ofType: "wav")!)
    let nextSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("next", ofType: "wav")!)
    let wrongSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("wrong", ofType: "wav")!)
    let tickSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("tick", ofType: "wav")!)
    
    let dropSoundPlayer:AVAudioPlayer!
    let backSoundPlayer:AVAudioPlayer!
    let nextSoundPlayer:AVAudioPlayer!
    let wrongSoundPlayer:AVAudioPlayer!
    let tickSoundPlayer:AVAudioPlayer!
    
    init(enabled:Bool) {
        
        self.enabled = enabled
        
        dropSoundPlayer = try? AVAudioPlayer(contentsOfURL: dropSound)
        dropSoundPlayer.prepareToPlay()
        
        backSoundPlayer = try? AVAudioPlayer(contentsOfURL: backSound)
        backSoundPlayer.prepareToPlay()
        
        nextSoundPlayer = try? AVAudioPlayer(contentsOfURL: nextSound)
        nextSoundPlayer.prepareToPlay()
        
        wrongSoundPlayer = try? AVAudioPlayer(contentsOfURL: wrongSound)
        wrongSoundPlayer.prepareToPlay()
        
        tickSoundPlayer = try? AVAudioPlayer(contentsOfURL: tickSound)
        tickSoundPlayer.prepareToPlay()
    }
    
    func playDrop() {
        if enabled {
            dropSoundPlayer.play()
        }
    }
    
    func playBack() {
        if enabled {
            backSoundPlayer.play()
        }
    }
    
    func playNext() {
        if enabled {
            nextSoundPlayer.play()
        }
    }
    
    func playWrong() {
        if enabled {
            wrongSoundPlayer.play()
        }
    }
    
    func playTick() {
        if enabled {
            tickSoundPlayer.play()
        }
    }
}

class SoundConfig {
    
    let file = "sound.json"
    
    func toggle(enabled:Bool) {
        
        let soundJSON = [enabled]
        if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) {
            
            let dir = dirs[0] //documents directory
            
            let filePath = dir + file;
            
            let str = soundJSON.description
            let data = str.dataUsingEncoding(NSUTF8StringEncoding)!
            data.writeToFile(filePath, atomically: true)
            
        }
        
    }
    
    func isOn()->Bool {
        
        if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) {
            
            let dir = dirs[0] //documents directory
            
            let filePath = dir + file;
            
            if let data = try? NSData(contentsOfFile:filePath, options:NSDataReadingOptions.DataReadingMappedAlways) {
                
                //var str = NSString(data: data, encoding: NSUTF8StringEncoding)
                let soundJSON = JSON(data:data)
                
                return soundJSON[0].boolValue
            }
        }
        
        return false
    }
}