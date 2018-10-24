//
//  ViewController.swift
//  swiftextensions
//
//  Created by Badhan Ganesh on 10/10/18.
//  Copyright © 2018 BadhanGanesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cornerRadiusAmount = (self.view.viewWithTag(100)?.bounds.midX)!
        self.view.viewWithTag(100)?.setCornerRadius(cornerRadiusAmount,
                                                    borderWidthAmount: 0,
                                                    borderColor: .clear)
    }
    
    @IBAction func pinButtonTouched(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.75,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseOut,
                       animations: {
                        self.view.viewWithTag(100)?.pinTo(UIViewPinPosition(rawValue: sender.tag)!)
        },
                       completion: nil)
    }
    
}

