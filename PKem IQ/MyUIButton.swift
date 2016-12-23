//
//  MyUIButton.swift
//  PKem IQ
//
//  Created by EOSS-TH on 9/2/2558 BE.
//  Copyright (c) 2558 EOSS-TH. All rights reserved.
//

import UIKit

extension UILabel {
    
    public func makeRoundLabel(width: CGFloat, radius:CGFloat, color:UIColor) {
        self.textColor = color
        self.layer.borderColor = color.CGColor
        self.layer.borderWidth = width
        self.layer.cornerRadius = radius
    }
}

extension UIButton {
    
    override public var enabled:Bool {
        didSet {
            if enabled {
                self.alpha = 1.0
            } else {
                self.alpha = 0.5
            }
        }
    }
    
    public func makeRoundButton(width: CGFloat, radius:CGFloat, color:UIColor) {
        self.setTitleColor(color, forState: UIControlState.Normal)
        self.layer.borderColor = color.CGColor
        self.layer.borderWidth = width
        self.layer.cornerRadius = radius
    }
    
    public func animateHide() {
        
        UIView.animateWithDuration(1.0,
            delay: 0,
            usingSpringWithDamping: 0.2,
            initialSpringVelocity: 6.0,
            options: UIViewAnimationOptions.AllowUserInteraction,
            animations: {
                self.transform = CGAffineTransformMakeScale(0.005, 0.005)
            }, completion: nil)
        
    }
    
    public func animateRestart() {
        self.transform = CGAffineTransformMakeScale(0, 0)
        
        UIView.animateWithDuration(1.0,
            delay: 0,
            usingSpringWithDamping: 0.2,
            initialSpringVelocity: 6.0,
            options: UIViewAnimationOptions.AllowUserInteraction,
            animations: {
                self.transform = CGAffineTransformMakeScale(1, 1)
            }, completion: nil)
    }
    
    public func animateRestore() {
        
        UIView.animateWithDuration(1.0,
            delay: 0,
            usingSpringWithDamping: 0.2,
            initialSpringVelocity: 6.0,
            options: UIViewAnimationOptions.AllowUserInteraction,
            animations: {
                self.transform = CGAffineTransformMakeScale(1, 1)
            }, completion: ({finished in
                if (finished) {
                }
            }))
        
    }
    
}