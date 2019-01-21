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
     
     Pins the view to the specified position in its superview using autolayout constraints. NOTE: If you already have added any constraints that are conflicting, they will be deactivated and removed.
     
     - Parameter position: The position you want to pin the view to its superview. See above for possible values.
     
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
    @objc func pinTo(_ position:UIViewPinPosition) {
        
        guard let superview = self.superview else { return }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        ///////////////////////////////////////////////////////////
        ////////Add width and height constraints from frame////////
        ///////////////////////////////////////////////////////////
        
        let width = self.bounds.width
        let height = self.bounds.height
        
        if self.bounds.size != .zero {
            if self.constraints.isEmpty {
                self.addConstraints([self.widthAnchor.constraint(equalToConstant: width),
                                     self.heightAnchor.constraint(equalToConstant: height)])
            }
        }
        
        for constraint in superview.constraints {
            
            ///////////////////////////////////////////////////////
            ////////Remove possible conflicting constraints////////
            ///////////////////////////////////////////////////////
            
            if constraint.firstAttribute != .width && constraint.firstAttribute != .height {
                if let firstItem = constraint.firstItem as? UIView, firstItem == self {
                    superview.removeConstraint(constraint)
                }
            }
            
            ////////////////////////////////////////////
            ////////Remove old added constraints////////
            ////////////////////////////////////////////
            
            if constraint.identifier?.contains("BJConstraint") ?? false {
                constraint.isActive = false
                superview.removeConstraint(constraint)
            }
            
        }
        
        let centerXConstraint = self.centerXAnchor.constraint(equalTo: superview.centerXAnchor)
        centerXConstraint.identifier = "BJConstraintCenterX"
        
        let centerYConstraint = self.centerYAnchor.constraint(equalTo: superview.centerYAnchor)
        centerYConstraint.identifier = "BJConstraintCenterY"
        
        let leadingConstraint = self.leadingAnchor.constraint(equalTo: superview.leadingAnchor)
        leadingConstraint.identifier = "BJConstraintLeading"
        
        let trailingConstraint = self.trailingAnchor.constraint(equalTo: superview.trailingAnchor)
        trailingConstraint.identifier = "BJConstraintTrailing"
        
        let topConstraint = self.topAnchor.constraint(equalTo: superview.topAnchor)
        topConstraint.identifier = "BJConstraintTop"
        
        let bottomConstraint = self.bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        bottomConstraint.identifier = "BJConstraintBottom"
        
        switch position {
        case .topLeft:
            superview.addConstraints([leadingConstraint, topConstraint])
            break
        case .topMiddle:
            superview.addConstraints([centerXConstraint, topConstraint])
            break
        case .topRight:
            superview.addConstraints([trailingConstraint, topConstraint])
            break
        case .middleLeft:
            superview.addConstraints([centerYConstraint, leadingConstraint])
            break
        case .bottomLeft:
            superview.addConstraints([bottomConstraint, leadingConstraint])
            break
        case .bottomMiddle:
            superview.addConstraints([bottomConstraint, centerXConstraint])
            break
        case .bottomRight:
            superview.addConstraints([bottomConstraint, trailingConstraint])
            break
        case .middleRight:
            superview.addConstraints([centerYConstraint, trailingConstraint])
            break
        case .middle:
            superview.addConstraints([centerYConstraint, centerXConstraint])
            break
        }
        
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
