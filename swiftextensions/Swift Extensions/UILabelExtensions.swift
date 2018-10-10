//
//  UILabelExtensions.swift
//  swiftextensions
//
//  Created by Badhan Ganesh on 10/10/18.
//  Copyright © 2018 BadhanGanesh. All rights reserved.
//

import UIKit

extension UILabel {
    
    func normalizeFont(multiplier primaryMultiplier:Double? = nil) {
        
        let deviceScaleFactor = UIScreen.main.scale
        let isiPad = UIDevice.current.userInterfaceIdiom == .pad
        let deviceWidth:Double = Double(UIScreen.main.bounds.width)
        let deviceHeight:Double = Double(UIScreen.main.bounds.height)
        
        let secondaryMultiplier = deviceScaleFactor == 1.0 ? 0.35 : deviceScaleFactor == 2.0 ? 0.55 : 0.7
        let finalMultiplier:CGFloat = CGFloat(primaryMultiplier ?? deviceWidth/deviceHeight + (isiPad ? 0.8 : secondaryMultiplier))
        
        let newFont = UIFont.init(name: self.font.fontName, size: self.font.pointSize * finalMultiplier)
        
        self.font = newFont
    }
    
}
