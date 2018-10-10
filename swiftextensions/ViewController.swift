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
    }

    @IBAction func pinButtonTouched(_ sender: UIButton) {
        self.view.viewWithTag(100)?.pinTo(UIViewPinPosition(rawValue: sender.tag)!)
    }
    
}

