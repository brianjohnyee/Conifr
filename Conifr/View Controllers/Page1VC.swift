//
//  Page1.swift
//  Conifr
//
//  Created by Sid Verma on 2/9/18.
//  Copyright © 2018 Sid Verma. All rights reserved.
//

import Foundation

import UIKit

class Page1VC: UIViewController {
    
    @IBOutlet var conifrLogo: UIImageView!
    @IBOutlet var conifrImage: UIImageView!
    @IBOutlet var swipeUp: UISwipeGestureRecognizer!
    @IBOutlet var bringingCarbonIV: UIImageView!
    
    override func viewDidLoad() {
       
    }
    @IBAction func swipeUp(_ sender: Any) {
        print("Swipe Up Detect")
    }
}
