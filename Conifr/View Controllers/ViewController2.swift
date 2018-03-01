//
//  ViewController.swift
//  Conifr
//
//  Created by Chantelle Mak on 2/19/18.
//  Copyright © 2018 Sid Verma. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
     var list = ["Name", "Email", "College", "Clear Data", "About", "Contact Us", "Legal"]
    var listDesc = ["Name", "user@ucsc.edu", "Rachel Carson College", "Clear Data", "About Conifr", "Conact us @", "Legal"]
    override func viewDidLoad() {
        super.viewDidLoad()

//        titleLabel.text = list[AnyString]
//        descLabel.text = listDesc[AnyString]
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
