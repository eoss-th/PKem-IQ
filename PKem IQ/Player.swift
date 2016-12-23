//
//  Level.swift
//  PKem IQ
//
//  Created by Enterprise Open Source Solution on 12/23/2559 BE.
//  Copyright © 2559 EOSS-TH. All rights reserved.
//

import Foundation
import SwiftyJSON

class Player {
    
    var levels = [JSON]()
    var playerLevels = [JSON]()
    
    var index: Int = 0
    
    var scorePoint: Int = 0
    
    var currentLevel: Int = 0
    
    var score=Score()
    
    init () {
        
        //Load all levels from bundle
        for level in 1...3 {
            
            let filePath = Bundle.main.path(forResource: "level\(level)",ofType:"json")
            
            if let data = try? Data(contentsOf: URL(fileURLWithPath: filePath!), options:NSData.ReadingOptions.alwaysMapped) {
                
                levels.append(JSON(data:data))
                playerLevels.append(JSON(data:data))
                
            }
            
        }
    }
    
    func newLevel(_ l:Int) {
        let level = levels[l]
        
        //Shuffle!
        var  i = 0
        var randomNumbers = [Int]()
        while randomNumbers.count < level.count {
            
            let numbersIndex = Int(arc4random_uniform(UInt32(level.count)))
            
            if randomNumbers.contains(numbersIndex) {
                continue
            }
            
            randomNumbers.append(numbersIndex)
            playerLevels[l][i] = level[numbersIndex]
            i = i + 1
        }
        
        currentLevel = l
        index = 0
        scorePoint = 0
        for j in 0..<currentLevel {
            scorePoint = scorePoint + playerLevels[j].count
        }
        
    }
    
    func continueLevel(_ l:Int) {
        
        currentLevel = l
        scorePoint = score.last
        index = scorePoint

        for j in 0..<currentLevel {
            index = index - playerLevels[j].count
        }
        
    }
    
    func answers() -> JSON {
        return playerLevels[currentLevel][index]["answers"]
    }
    
    func answer() -> String {
        return (playerLevels[currentLevel][index]["result"].number?.stringValue)!
    }
    
    func isClearedLevel()->Bool {
        return index >= playerLevels[currentLevel].count
    }
    
    func isCorrected(_ playerAnswers:[String])->Bool {
        
        let answers = playerLevels[currentLevel][index]["answers"]
        
        var match:Bool
        
        for i in 0 ..< answers.count {
            let corrects = answers[i]
            
            match = true
            for j in 0 ..< corrects.count {
                if (corrects[j].string != playerAnswers[j]) {
                    match = false;
                    break;
                }
            }
            
            if match {
                return true
            }
        }
        
        return false
    }
    
    func next() {
        
        scorePoint = scorePoint + 1
        score = Score(newScore: scorePoint)
        
        index += 1
        
    }
    
    
}
