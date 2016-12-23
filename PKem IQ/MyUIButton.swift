//
//  MyUIButton.swift
//  PKem IQ
//
//  Created by EOSS-TH on 9/2/2558 BE.
//  Copyright (c) 2558 EOSS-TH. All rights reserved.
//

import UIKit

extension UILabel {
    
    public func makeRoundLabel(_ width: CGFloat, radius:CGFloat, color:UIColor) {
        self.textColor = color
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
        self.layer.cornerRadius = radius
    }
}

extension UIButton {
    
    override open var isEnabled:Bool {
        didSet {
            if isEnabled {
                self.alpha = 1.0
            } else {
                self.alpha = 0.5
            }
        }
    }
    
    public func makeRoundButton(_ width: CGFloat, radius:CGFloat, color:UIColor) {
        self.setTitleColor(color, for: UIControlState())
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
        self.layer.cornerRadius = radius
    }
    
    public func animateHide() {
        
        UIView.animate(withDuration: 1.0,
            delay: 0,
            usingSpringWithDamping: 0.2,
            initialSpringVelocity: 6.0,
            options: UIViewAnimationOptions.allowUserInteraction,
            animations: {
                self.transform = CGAffineTransform(scaleX: 0.005, y: 0.005)
            }, completion: nil)
        
    }
    
    public func animateRestart() {
        self.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        UIView.animate(withDuration: 1.0,
            delay: 0,
            usingSpringWithDamping: 0.2,
            initialSpringVelocity: 6.0,
            options: UIViewAnimationOptions.allowUserInteraction,
            animations: {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
    }
    
    public func animateRestore() {
        
        UIView.animate(withDuration: 1.0,
            delay: 0,
            usingSpringWithDamping: 0.2,
            initialSpringVelocity: 6.0,
            options: UIViewAnimationOptions.allowUserInteraction,
            animations: {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: ({finished in
                if (finished) {
                }
            }))
        
    }
    
}
