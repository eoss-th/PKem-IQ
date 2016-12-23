//
//  Score.swift
//  PKem IQ
//
//  Created by EOSS-TH on 9/4/2558 BE.
//  Copyright (c) 2558 EOSS-TH. All rights reserved.
//

import Foundation

class Score {
    
    var max:Int = 0
    var last:Int = 0
    
    init() {
        
        let file = "score.json"
        
        if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) {
            
            let dir = dirs[0] //documents directory
            
            let filePath = dir + file
            
            if let data = try? NSData(contentsOfFile:filePath, options:NSDataReadingOptions.DataReadingMappedAlways) {
                
                //var str = NSString(data: data, encoding: NSUTF8StringEncoding)
                let scoreJSON = JSON(data:data)
                
                max = scoreJSON[0].intValue
                last = scoreJSON[1].intValue
                
            }
        }
        
        
    }
    
    convenience init(newScore score:Int) {
        
        self.init()
        
        if score > last {
            
            last = score
            
        }
        
        if last > max {
            
            max = last
            
        }
        
        let scoreJSON = [max, last]
        
        let file = "score.json"
        
        if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) {
            
            let dir = dirs[0] //documents directory
            
            let filePath = dir + file
            
            let str = scoreJSON.description
            let data = str.dataUsingEncoding(NSUTF8StringEncoding)!
            data.writeToFile(filePath, atomically: true)
            
        }
        
    }
    
}