//
//  UILabelExtensions.swift
//  swiftextensions
//  Created by Badhan Ganesh on 10/10/18.
//

// This code is distributed under the terms and conditions of the MIT license.

// Copyright © 2018 Badhan Ganesh
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


import UIKit

extension UILabel {
    
    /**
     
     A handy function which normalizes the font size for all the devices. If you call this method on a `UILabel`, the text will appear in the same size visually across different devices so you don't have to worry about setting different font sizes for devices like **iPhone 4s, iPhone 5, iPhone 8 plus, X's, and iPad's**.
     
     When initially setting font for the label (either in Interface Builder or in code), always set for the smallest-sized device, iPhone SE. This method works by scaling the font size by multiplying it with a multiplier value. Since it is an incremental scaling, you have to set the font size for the smallest device, so that the size scales properly throughout all bigger deivces.
     
     - Author: Badhan Ganesh
     
     */
    
    @objc func normalizeFont() {
        
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
        
        let newFont = UIFont.init(name: self.font.fontName, size: self.font.pointSize * CGFloat(finalMultiplier))
        
        self.font = newFont
    }
    
}
