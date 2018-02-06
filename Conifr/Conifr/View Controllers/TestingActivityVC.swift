//
//  TestingActivityVC.swift
//  Conifr
//
//  Created by Sid Verma on 2/6/18.
//  Copyright © 2018 Sid Verma. All rights reserved.
//

import UIKit
import ArcKit
import CoreLocation
import CoreMotion

//API KEY FOR ARCKIT: 3ca710a0adf94482af9837f1361bf882

class TestingActivityVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // the recording manager singleton
        let loco = LocomotionManager.highlander
        
        
        // decide which Core Motion features to include
        loco.recordPedometerEvents = true
        loco.recordAccelerometerEvents = true
        loco.recordCoreMotionActivityTypeEvents = true
        
        // decide whether to use "sleep mode" to allow for all day recording
        loco.useLowPowerSleepModeWhileStationary = true

        // start recording
        loco.startRecording()
        /*
        when(loco, does: .movingStateChanged) { _ in
            if loco.movingState == .moving {
                print("started moving")
            }
            
            if loco.movingState == .stationary {
                print("stopped moving")
            }
         */
        
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
