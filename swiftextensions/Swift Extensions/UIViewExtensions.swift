//
//  UIViewExtensions.swift
//  swiftextensions
//
//  Created by Badhan Ganesh on 10/10/18.
//  Copyright © 2018 BadhanGanesh. All rights reserved.
//

import UIKit

enum UIViewPinPosition:Int {
    case topLeft = 0,
    topMiddle,
    topRight,
    middleRight,
    bottomRight,
    bottomMiddle,
    bottomLeft,
    middleLeft,
    middle
}

extension UIView {
    
    ////////////////////////////////////////////////////////////////
    //MARK:-
    //MARK:View Positioning
    //MARK:-
    ////////////////////////////////////////////////////////////////
    
    func centerXInSuperview() {
        guard let superview = self.superview else { return }
        var newFrame = self.frame
        newFrame.origin.x = superview.bounds.midX - self.bounds.midX
        self.frame = newFrame
    }
    
    func centerYInSuperiew() {
        guard let superview = self.superview else { return }
        var newFrame = self.frame
        newFrame.origin.y = superview.bounds.midY - self.bounds.midY
        self.frame = newFrame
    }
    
    func centerInSuperiew() {
        guard let superview = self.superview else { return }
        var newFrame = self.frame
        newFrame.origin.x = superview.bounds.midX - self.bounds.midX
        newFrame.origin.y = superview.bounds.midY - self.bounds.midY
        self.frame = newFrame
    }
    
    func pinTo(_ position:UIViewPinPosition) {
        
        guard let superview = self.superview else { return }
        
        var newFrame = self.frame
        
        switch position {
        case .topLeft:
            newFrame.origin = .zero
            self.frame = newFrame
            break
        case .topMiddle:
            newFrame.origin.x = superview.bounds.midX - self.bounds.midX
            newFrame.origin.y = 0
            self.frame = newFrame
            break
        case .topRight:
            newFrame.origin.x = superview.bounds.width - self.bounds.width
            newFrame.origin.y = 0
            self.frame = newFrame
            break
        case .middleLeft:
            newFrame.origin.x = 0
            newFrame.origin.y = superview.bounds.midY - self.bounds.midY
            self.frame = newFrame
            break
        case .bottomLeft:
            newFrame.origin.x = 0
            newFrame.origin.y = superview.bounds.height - self.bounds.height
            self.frame = newFrame
            break
        case .bottomMiddle:
            newFrame.origin.x = superview.bounds.midX - self.bounds.midX
            newFrame.origin.y = superview.bounds.height - self.bounds.height
            self.frame = newFrame
            break
        case .bottomRight:
            newFrame.origin.x = superview.bounds.width - self.bounds.width
            newFrame.origin.y = superview.bounds.height - self.bounds.height
            self.frame = newFrame
            break
        case .middleRight:
            newFrame.origin.x = superview.bounds.width - self.bounds.width
            newFrame.origin.y = superview.bounds.midY - self.bounds.midY
            self.frame = newFrame
            break
        case .middle:
            self.centerInSuperiew()
            break
        }
    }
    
    ////////////////////////////////////////////////////////////////
    //MARK:-
    //MARK:View Styling
    //MARK:-
    ////////////////////////////////////////////////////////////////
    
    func setCornerRadius(_ amount:CGFloat, borderWidthAmount:CGFloat, borderColor:UIColor) {
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        self.layer.cornerRadius = amount
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidthAmount
    }

    func addShadow(withRadius radius:CGFloat = 25, opacity:Float = 0.3) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = .init(width: -2, height: 2)
    }
    
}
