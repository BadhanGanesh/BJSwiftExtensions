//
//  UIViewExtensions.swift
//  swiftextensions
//
//  Created by Badhan Ganesh on 10/10/18.
//  Copyright © 2018 BadhanGanesh. All rights reserved.
//

import UIKit

extension UIView {
    
    func centerXIn(_ view:UIView) {
        var newFrame = self.frame
        newFrame.origin.x = (view.frame.size.width / 2) - (self.frame.size.width / 2)
        self.frame = newFrame
    }
    
    func centerYIn(_ view:UIView) {
        var newFrame = self.frame
        newFrame.origin.y = (view.frame.size.height / 2) - (self.frame.size.height / 2)
        self.frame = newFrame
    }
    
    func centerIn(_ view:UIView) {
        var newFrame = self.frame
        newFrame.origin.x = (view.frame.size.width / 2) - (self.frame.size.width / 2)
        newFrame.origin.y = (view.frame.size.height / 2) - (self.frame.size.height / 2)
        self.frame = newFrame
    }
    
    func setCornerRadius(_ amount:CGFloat, borderWidthAmount:CGFloat, borderColor:UIColor) {
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        self.layer.cornerRadius = amount
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidthAmount
    }
    
}
