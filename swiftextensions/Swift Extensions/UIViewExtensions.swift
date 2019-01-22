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
     
     Pins the view to the specified position in its superview using autolayout constraints. **NOTE:** If you already have added any constraints that are conflicting for the constraints going to be added for the supplied `position`, they will be deactivated and removed.
     
     - Parameter position: The position you want to pin the view to its superview. See above for possible values.
     - Parameter shouldRespectSafeArea: Pass `true` to take the superview's safe area layout guide into account when pinning. Default is `false`. **NOTE:** This parameter will be ignored for iOS versions below 11.0.
     
     ```
     //Example Usage
     
     //This pins `myView` to top left of its super view.
     self.myView.pinTo(.topLeft)
     
     //This pins `myView` to top right of its super view respecting its safe area layout guide.
     self.myView.pinTo(.topRight, shouldRespectSafeArea:true)
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
    @objc func pinTo(_ position:UIViewPinPosition, shouldRespectSafeArea:Bool = false) {
        
        guard let superview = self.superview else { return }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        var shouldConsiderSafeArea = shouldRespectSafeArea
        if #available(iOS 11.0, *) { } else { shouldConsiderSafeArea = false }
        
        ///////////////////////////////////////////////////////////////////
        ////////Add width and height constraints from view's bounds////////
        ///////////////////////////////////////////////////////////////////
        
        if self.bounds.size != .zero {
            if self.constraints.isEmpty {
                self.addConstraints([self.widthAnchor.constraint(equalToConstant: self.bounds.width),
                                     self.heightAnchor.constraint(equalToConstant: self.bounds.height)])
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
            
            if constraint.identifier?.contains("\(self.pointerString)") ?? false {
                constraint.isActive = false
                superview.removeConstraint(constraint)
            }
            
        }
        
        ///////////////////////////////////////////////////////
        ////////Use Safe Area for iOS 11 and above only////////
        ///////////////////////////////////////////////////////
        
        var safeAreaLeadingAnchor:NSLayoutXAxisAnchor?
        var safeAreaTrailingAnchor:NSLayoutXAxisAnchor?
        var safeAreaTopAnchor:NSLayoutYAxisAnchor?
        var safeAreaBottomAnchor:NSLayoutYAxisAnchor?
        
        if #available(iOS 11.0, *) {
            safeAreaLeadingAnchor = superview.safeAreaLayoutGuide.leadingAnchor
            safeAreaTrailingAnchor = superview.safeAreaLayoutGuide.trailingAnchor
            safeAreaTopAnchor = superview.safeAreaLayoutGuide.topAnchor
            safeAreaBottomAnchor = superview.safeAreaLayoutGuide.bottomAnchor
        }
        
        ///////////////////////////////////////////////
        ////////Prepare constraints to be added////////
        ///////////////////////////////////////////////
        
        let centerXConstraint = self.centerXAnchor.constraint(equalTo: superview.centerXAnchor)
        centerXConstraint.identifier = "BJConstraintCenterX - \(self.pointerString)"
        
        let centerYConstraint = self.centerYAnchor.constraint(equalTo: superview.centerYAnchor)
        centerYConstraint.identifier = "BJConstraintCenterY - \(self.pointerString)"
        
        let leadingConstraint = self.leadingAnchor.constraint(equalTo: shouldConsiderSafeArea ? safeAreaLeadingAnchor! : superview.leadingAnchor)
        leadingConstraint.identifier = "BJConstraintLeading - \(self.pointerString)"
        
        let trailingConstraint = self.trailingAnchor.constraint(equalTo: shouldConsiderSafeArea ? safeAreaTrailingAnchor! : superview.trailingAnchor)
        trailingConstraint.identifier = "BJConstraintTrailing - \(self.pointerString)"
        
        let topConstraint = self.topAnchor.constraint(equalTo: shouldConsiderSafeArea ? safeAreaTopAnchor! : superview.topAnchor)
        topConstraint.identifier = "BJConstraintTop - \(self.pointerString)"
        
        let bottomConstraint = self.bottomAnchor.constraint(equalTo: shouldConsiderSafeArea ? safeAreaBottomAnchor! : superview.bottomAnchor)
        bottomConstraint.identifier = "BJConstraintBottom - \(self.pointerString)"
        
        ////////////////////////////////////////
        ////////Add relevant constraints////////
        ////////////////////////////////////////
        
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
        
        CATransaction.flush()
        
    }
    
    /**
     
     Adds soft shadow to view.
     
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

/**
 * Neat little extension to get the memory address of a variable, from this SO answer:
 * https://stackoverflow.com/a/41067053/5912335
 */
public extension NSObject {
    public var pointerString: String {
        return String(format: "%p", self)
    }
}
