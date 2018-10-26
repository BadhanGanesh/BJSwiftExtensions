//
//  UIViewExtensions.swift
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

@objc enum UIViewPinPosition:Int {
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
    
    /**
     
     Pins the view to the specified position in its superview.
     
     - Parameter position: The position you want to pin the view to its superview. See above for possible values.
     - Parameter view: The reference view that you want the calling view to pin to. Supply `nil` to pin to the super view instead, in case of Objective-C.
     
     ```
     //Example Usage
     
     //This pins `myView` to top left position of its super view.
     self.myView.pinTo(.topLeft)
     
     //This pins `myView` to top left position of the supplied view ignoring super view.
     self.myView.pinTo(.topLeft, in: self.view!)
     ```
     
     Use one of the below values for the `UIViewPinPosition`:
     
     * topLeft
     * topMiddle
     * topRight
     * middleRight
     * bottomRight
     * bottomMiddle
     * bottomLeft
     * middleLeft
     * middle
     
     - Author: Badhan Ganesh
     
     */
    
    @objc func pinTo(_ position:UIViewPinPosition, in view:UIView? = nil) {

        guard let superview = view ?? superview else { return }
        
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
    
    /**
     Centers the view in its superview.
     - Author: Badhan Ganesh
     */
    @objc func centerInSuperiew() {
        guard let superview = self.superview else { return }
        var newFrame = self.frame
        newFrame.origin.x = superview.bounds.midX - self.bounds.midX
        newFrame.origin.y = superview.bounds.midY - self.bounds.midY
        self.frame = newFrame
    }
    
    /**
     Centers the view along Y-axis in its superview.
     - Author: Badhan Ganesh
     */
    @objc func centerYInSuperiew() {
        guard let superview = self.superview else { return }
        var newFrame = self.frame
        newFrame.origin.y = superview.bounds.midY - self.bounds.midY
        self.frame = newFrame
    }
    
    /**
     Centers the view along X-axis in its superview.
     - Author: Badhan Ganesh
     */
    @objc func centerXInSuperview() {
        guard let superview = self.superview else { return }
        var newFrame = self.frame
        newFrame.origin.x = superview.bounds.midX - self.bounds.midX
        self.frame = newFrame
    }
    
    /**
     
     Adds soft shadow to view by default in Swift. You have to supply radius and opacity values in case of Objective-C.
     
     You need to make the `view.layer.masksToBounds` to `false` for it to work.
     
     - Parameter radius: The blur radius (in points) used to render the layer’s shadow.
     - Parameter opacity: The opacity of the layer’s shadow.
     
     - Author: Badhan Ganesh
     
     */
    @objc func addShadow(withRadius radius:CGFloat = 25, opacity:Float = 0.3) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = .init(width: -2, height: 2)
    }
    
    /**
     You know what it does!
     - Author: Badhan Ganesh
     */
    @objc func roundCorners(amount:CGFloat, borderWidthAmount:CGFloat = 0, borderColor:UIColor = .clear) {
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        self.layer.cornerRadius = amount
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidthAmount
    }
    
    /**
     
     This method, even though works for any UIView, is actually applicable to `UILabel`, `UITextView`, `UITextField` and basically any `UIView` descendant that has `text` property to it.
     
     ```
     //Example usages
     
     let textField = UITextField()
     textField.text = "Texttyyy"
     
     let textview1 = UITextView()
     textview1.text = nil
     
     let textview2 = UITextView()
     textview2.text = "Textview text"
     
     let view = UIView()
     
     print(textField.getText() as Any)   /* Optional("Texttyyy") */
     print(textView1.getText() as Any)   /* nil */
     print(textView2.getText() as Any)   /* Optional("Textview text") */
     print(view.getText() as Any)        /* nil */
     ```
     
     - Returns: An optional string value from the `text` property.
     
     - Author: Badhan Ganesh
     
     */
    @objc func getText() -> String? {
        return self.responds(to: #selector(getter: UILabel.text)) ?
            self.perform(#selector(getter: UILabel.text))?.takeUnretainedValue() as? String : nil
    }
    
}
