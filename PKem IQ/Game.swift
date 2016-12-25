//
//  Level.swift
//  PKem IQ
//
//  Created by Enterprise Open Source Solution on 12/23/2559 BE.
//  Copyright © 2559 EOSS-TH. All rights reserved.
//

import Foundation

class Game {
    
    var levels = [JSON]()
    var shuffleLevels = [JSON]()
    
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
                shuffleLevels.append(JSON(data:data))
                
            }
            
        }
    }
    
    func shuffle(_ l:Int) {
        
        let level = levels[l]
        var  i = 0
        var randomNumbers = [Int]()
        while randomNumbers.count < level.count {
            
            let numbersIndex = Int(arc4random_uniform(UInt32(level.count)))
            
            if randomNumbers.contains(numbersIndex) {
                continue
            }
            
            randomNumbers.append(numbersIndex)
            shuffleLevels[l][i] = level[numbersIndex]
            i = i + 1
        }
        
    }
    
    func newLevel(_ l:Int) {
        
        shuffle(l)
        
        currentLevel = l
        index = 0
        scorePoint = 0
        for j in 0..<currentLevel {
            scorePoint = scorePoint + shuffleLevels[j].count
        }
        
    }
    
    func continueLevel(_ l:Int) {
        
        shuffle(l)
        
        currentLevel = l
        scorePoint = score.last
        index = scorePoint

        for j in 0..<currentLevel {
            index = index - shuffleLevels[j].count
        }
        
    }
    
    func answers() -> JSON {
        return shuffleLevels[currentLevel][index]["answers"]
    }
    
    func answer() -> String {
        return (shuffleLevels[currentLevel][index]["result"].number?.stringValue)!
    }
    
    func isClearedLevel()->Bool {
        return index >= shuffleLevels[currentLevel].count
    }
    
    func isCorrected(_ playerAnswers:[String])->Bool {
        
        let answers = shuffleLevels[currentLevel][index]["answers"]
        
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
