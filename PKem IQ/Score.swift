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
        
        let dirs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let dir = dirs[0] //documents directory
        let filePath = dir.path + "/" + file;
        
        if let data = try? Data(contentsOf: URL(fileURLWithPath: filePath), options:NSData.ReadingOptions.alwaysMapped) {
                
            //var str = NSString(data: data, encoding: NSUTF8StringEncoding)
            let scoreJSON = JSON(data:data)
                
            max = scoreJSON[0].intValue
            last = scoreJSON[1].intValue
                
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
        
        let dirs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let dir = dirs[0] //documents directory
        let filePath = dir.path + "/" + file;
        
        let str = scoreJSON.description
        let data = str.data(using: String.Encoding.utf8)!
        try? data.write(to: URL(fileURLWithPath: filePath), options: [.atomic])

    }
    
}
