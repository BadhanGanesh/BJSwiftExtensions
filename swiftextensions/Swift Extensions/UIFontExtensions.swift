//
//  UIFontExtensions.swift
//  swiftextensions
//
//  Created by BadhanGanesh on 17/10/18.
//  Copyright © 2018 BadhanGanesh. All rights reserved.
//

import UIKit

extension UIFont {
    
    /**
     * A handy function which normalizes the font size for all the devices. If you call this method on a `UILabel`, the text will appear in the same size visually across different devices so you don't have to worry about setting different font sizes for devices like **iPhone 4s, iPhone 5, iPhone 8 plus, X's, and iPad's**.
     
     * When initially setting font for the label (either in Interface Builder or in code), always set for the smallest-sized device, iPhone SE. This method works by scaling the font size by multiplying it with a multiplier value. Since it is a inceremental scaling, you have to set the font size for the smallest device, so that they scale properly throughout all bigger deivces.
     
     * - Author: Badhan Ganesh
     
     * - Returns: The normalized font.
     */
    
    @objc func normalized() -> UIFont {
        
        //////////////////////////////////////////////////////////
        //////Required constants for multiplier calculationn//////
        //////////////////////////////////////////////////////////
        
        let deviceScaleFactor = UIScreen.main.scale
        let isiPad = UIDevice.current.userInterfaceIdiom == .pad
        let deviceWidth:Double = Double(UIScreen.main.bounds.width)
        let deviceHeight:Double = Double(UIScreen.main.bounds.height)
        let aspectRatio = deviceWidth/deviceHeight
        
        /////////////////////////////////////
        //////Decide primary multiplier//////
        /////////////////////////////////////
        
        var primaryMultiplier = 0.0
        
        switch deviceScaleFactor {
        case 1:
            primaryMultiplier = 0.2
            break
        case 2:
            primaryMultiplier = 0.4
            break
        default:
            primaryMultiplier = 0.7
            break
        }
        
        //////////////////////////////////////
        //////Calculate final multiplier//////
        //////////////////////////////////////
        
        let finalMultiplier = aspectRatio + (isiPad ? 1.0 : primaryMultiplier)
        
        return self.withSize(self.pointSize * CGFloat(finalMultiplier))
    }
    
}
