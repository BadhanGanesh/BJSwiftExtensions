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
