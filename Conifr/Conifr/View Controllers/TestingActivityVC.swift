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
import SwiftNotes


//API KEY FOR ARCKIT: 3ca710a0adf94482af9837f1361bf882

class TestingActivityVC: UIViewController,CLLocationManagerDelegate {
    //CLLocationManager Property
    var locationManager: CLLocationManager!
    let cmMotionActivityManager = CMMotionActivityManager()
    let loco = LocomotionManager.highlander
    
    //Outlets for all labels
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var coreMotionPermissionLabel: UILabel!
    @IBOutlet weak var haveLocationPermissionLabel: UILabel!
    @IBOutlet weak var haveBackgroundPermissionLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    
    //MARK - View Controller Initializated and brought to front
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self

        getLocation()
        setUpLocomotion()
        
        
        }

    //Sets up all needed parameters for ArcKit
    func setUpLocomotion() {
         ArcKitService.apiKey = "3ca710a0adf94482af9837f1361bf882"
        
        // decide which Core Motion features to include
        loco.recordPedometerEvents = true
        loco.recordAccelerometerEvents = true
        loco.recordCoreMotionActivityTypeEvents = true
        
        // decide whether to use "sleep mode" to allow for all day recording - NEEDED FOR LOW BATTERY USAGE!!
        loco.useLowPowerSleepModeWhileStationary = true
        
        startLocomotionRecording()
        
    }
    
    //Handles locomotion recording
    func startLocomotionRecording(){
        
        // start recording
        loco.startRecording()
        
        //Set all labels to a starting value
        self.activityLabel.text = self.loco.locomotionSample().coreMotionActivityType.map{$0.rawValue}
        self.coreMotionPermissionLabel.text = "HAVE CORE MOTION PERMISSION:" + String(self.loco.haveBackgroundLocationPermission)
        self.haveLocationPermissionLabel.text = "HAVE LOCATION PERMISSION:" + String(self.loco.haveLocationPermission)
        self.haveBackgroundPermissionLabel.text = "HAVE BACKGROUND PERMISSION:" + String(self.loco.haveBackgroundLocationPermission)
        
        //Detects changes in Locomotion Samples
        when(loco, does: .locomotionSampleUpdated) { _ in
            //Optional Chaining to unwrap rawLocation
            if let location = self.loco.rawLocation as? CLLocation {
               
                //Creating strings from lat/long data
                var latitudeText:String = "\(self.loco.locomotionSample().location?.coordinate.latitude)"
                var longText:String = "\(self.loco.locomotionSample().location?.coordinate.longitude)"
                
                //Setting label text for lat & long
                self.latLabel.text = "LAT: " + latitudeText
                self.longLabel.text = "LONG: " + longText
                //Setting label text for Motion Activity by mapping first value (most confidence)
                self.activityLabel.text = self.loco.locomotionSample().coreMotionActivityType.map { $0.rawValue }
                
            }
            
        }
        
    }
    
    //Gets authorization status (user provided)
    func getLocation() {
        
        let status = CLLocationManager.authorizationStatus()
        
        handleLocationAuthorizationStatus(status: status)
    }
    
    //Switch for handling all authorization status' (exhaustive)
    func handleLocationAuthorizationStatus(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            setUpLocomotion()
        case .authorizedWhenInUse:
            statusDeniedAlert()
        case .denied:
            statusDeniedAlert()
        case .restricted:
            showAlert(title: "Access to Location Services is Restricted", message: "Parental Controls or a system administrator may be limiting your access to location services. Ask them to.")
        }
    }
    
    //Helper function for showing alerts
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    //Shows alert when user has denied/not accepted proper location permission
    func statusDeniedAlert() {
        let alertController = UIAlertController(title: "Background Location Access Disabled", message: "In order to measure you carbon emission, please open this app's settings and set location access to 'Always'.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Open Settings", style: .`default`, handler: { action in
            if #available(iOS 10.0, *) {
                let settingsURL = URL(string: UIApplicationOpenSettingsURLString)!
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            } else {
                if let url = NSURL(string:UIApplicationOpenSettingsURLString) {
                    UIApplication.shared.openURL(url as URL)
                }
            }
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    //Handles changes in Location Authorization status
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handleLocationAuthorizationStatus(status: status)
    }
    
    //Handles location changes (GPS - not Motion chip)
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last {
            print("My coordinates are: \(currentLocation.coordinate.latitude), \(currentLocation.coordinate.longitude)")
            locationManager.stopUpdatingLocation()
        }
    }
    
    //Handles Location Access Failure
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showAlert(title: "Location Access Failure", message: "App could not access locations. Loation services may be unavailable or are turned off. Error code: \(error)")
    }
    

}
