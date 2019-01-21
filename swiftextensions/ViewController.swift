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
        self.view.viewWithTag(100)?.roundCorners(amount: (self.view.viewWithTag(100)?.bounds.midX)!)
    }
    
    @IBAction func pinButtonTouched(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.view.viewWithTag(100)?.pinTo(UIViewPinPosition(rawValue: sender.tag)!)
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
}

