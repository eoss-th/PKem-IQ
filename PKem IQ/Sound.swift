//
//  Sound.swift
//  PKem IQ
//
//  Created by Wisarut Srisawet on 10/9/58.
//  Copyright (c) พ.ศ. 2558 EOSS-TH. All rights reserved.
//

import Foundation
import AVFoundation
import SwiftyJSON

class Sound {
    
    let enabled:Bool
    
    let dropSound = URL(fileURLWithPath: Bundle.main.path(forResource: "drop", ofType: "wav")!)
    let wrongSound = URL(fileURLWithPath: Bundle.main.path(forResource: "wrong", ofType: "wav")!)
    let tickSound = URL(fileURLWithPath: Bundle.main.path(forResource: "tick", ofType: "wav")!)
    
    let dropSoundPlayer:AVAudioPlayer!
    let wrongSoundPlayer:AVAudioPlayer!
    let tickSoundPlayer:AVAudioPlayer!
    
    init(enabled:Bool) {
        
        self.enabled = enabled
        
        dropSoundPlayer = try? AVAudioPlayer(contentsOf: dropSound)
        dropSoundPlayer.prepareToPlay()
        
        wrongSoundPlayer = try? AVAudioPlayer(contentsOf: wrongSound)
        wrongSoundPlayer.prepareToPlay()
        
        tickSoundPlayer = try? AVAudioPlayer(contentsOf: tickSound)
        tickSoundPlayer.prepareToPlay()
    }
    
    func playDrop() {
        if enabled {
            dropSoundPlayer.play()
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
    
    func toggle(_ enabled:Bool) {
        
        let soundJSON = [enabled]
        let dirs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let dir = dirs[0] //documents directory
        let filePath = dir.path + "/" + file;
            
        let str = soundJSON.description
        let data = str.data(using: String.Encoding.utf8)!
        try! data.write(to: URL(fileURLWithPath: filePath), options: [.atomic])

    }
    
    func isOn()->Bool {
        
        let dirs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let dir = dirs[0] //documents directory
        let filePath = dir.path + "/" + file;
        
        if let data = try? Data(contentsOf: URL(fileURLWithPath: filePath), options:NSData.ReadingOptions.alwaysMapped) {
                
            //var str = NSString(data: data, encoding: NSUTF8StringEncoding)
            let soundJSON = JSON(data:data)
            return soundJSON[0].boolValue
        }
        
        return false
    }
}
