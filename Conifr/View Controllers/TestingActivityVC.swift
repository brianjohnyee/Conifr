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
    @IBOutlet weak var gpsActivityLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var confidenceLabel: UILabel!
    
    
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
        loco.dynamicallyAdjustDesiredAccuracy = true
        //Sleep at 300 seconds of waiting after user is stationary
        loco.sleepAfterStationaryDuration = 300
        //Wake up every 120 seconds (2 minutes) to check if user is moving or not
        loco.sleepCycleDuration = 120
        
        startLocomotionRecording()
        
        
    }
    
    //Handles locomotion recording
    func startLocomotionRecording(){
        
        // start recording
        loco.startRecording()
        
        //Set all labels to a starting value
        //self.activityLabel.text = self.loco.locomotionSample().coreMotionActivityType.map{$0.rawValue}
        self.coreMotionPermissionLabel.text = "HAVE CORE MOTION PERMISSION:" + String(self.loco.haveBackgroundLocationPermission)
        self.haveLocationPermissionLabel.text = "HAVE LOCATION PERMISSION:" + String(self.loco.haveLocationPermission)
        self.haveBackgroundPermissionLabel.text = "HAVE BACKGROUND PERMISSION:" + String(self.loco.haveBackgroundLocationPermission)
        
        
        
        //Detects changes in Locomotion Samples
        when(loco, does: .locomotionSampleUpdated) { _ in
            //Optional Chaining to unwrap rawLocation
            if let location = self.loco.rawLocation as? CLLocation {
               
                var locationSample = self.loco.locomotionSample()
               // print(locationSample.location)
                //print(locationSample.location?.speed)
                
                //Creating strings from lat/long data
                var latitudeText:String = "\(locationSample.location?.coordinate.latitude)"
                var longText:String = "\(locationSample.location?.coordinate.longitude)"
                
                //Setting label text for lat & long
                self.latLabel.text = "LAT: " + latitudeText
                self.longLabel.text = "LONG: " + longText
                
                
                //Setting label text for Motion Activity by mapping first value (most confidence)
                self.timeLabel.text = "\(locationSample.date)"
                

                switch locationSample.movingState {
                case .moving:
                    self.gpsActivityLabel.text = "Moving"
                case .stationary:
                    self.gpsActivityLabel.text = "Stationary"
                case .uncertain:
                    self.gpsActivityLabel.text = "Uncertain"
                }
                
                //Use ML Classifier to get more specifc motion activity
                let classifier = ActivityTypeClassifier(coordinate: location.coordinate)
                
                if let classifier = classifier as? ActivityTypeClassifier {
                    
                     self.classifyWithConfidence(classifier: classifier, locoSample: locationSample)
                    
                } else {
                    
                    //Handle error
                    
                }
                
                
                //User is driving and moving
                if locationSample.coreMotionActivityType == CoreMotionActivityTypeName.automotive && locationSample.movingState == .moving {
                    
                    self.startOdometer(locationSample: locationSample)
                }
                
                //User is walking and moving
                if locationSample.coreMotionActivityType == CoreMotionActivityTypeName.walking && locationSample.movingState == .moving {
                    
                    
                }
                
            }
            
        }
        
    }
    
    //Gets authorization status (user provided)
    private func getLocation() {
        
        let status = CLLocationManager.authorizationStatus()
        
        handleLocationAuthorizationStatus(status: status)
    }
    
    public func classifyWithConfidence(classifier: ActivityTypeClassifier,locoSample: LocomotionSample) -> ActivityTypeName {
        
        // classify a locomotion sample
        let results = classifier.classify(locoSample)
        
        // get the best match activity type
        let bestMatch = results.first
        print(bestMatch?.name)
        
       // print(results.array)
        if results.first?.name == ActivityTypeName.transport {
            //print(bestMatch)
        } else if results.first?.name == ActivityTypeName.cycling {
            //print(bestMatch)
        }
        
        // print the best match type's name ("walking", "car", etc)
        //print(bestMatch?.name)
        self.activityLabel.text = (bestMatch?.name).map { $0.rawValue }
        
    
        self.confidenceLabel.text = "w/confidence:" + "\(bestMatch?.score)"
        
        
        
        return bestMatch!.name
        
        //Gets value with most confidence
        if let mostConfident = results.first {
            
            var confidence = mostConfident.score
            var gpsMotion = locoSample.movingState
            
            
            //Create Name, Confidence, GPS Motion and Time Dictionaryy
            //var coupledMotionDataDictionary = Dictionary<String, Any>
            
            //Metadata to attach key-value with timestamp
            //var metadata =
            
            
            
            //Create confidence Array
            var confidenceArray = [Double]()
            
            //FIX: FORCE UNWRAPPING
            confidenceArray.append(confidence)
            
            if gpsMotion == .moving && mostConfident.name != .stationary {
                //I am in some motion
            } else if gpsMotion == .uncertain {
                //Idk but ignore this data
            } else if gpsMotion == .stationary && mostConfident.name == .stationary {
                //I am completely stationary (this is my trip ending condition
                //if (i have been completely stationary for most than 10 minutes) {
                    // end the trip and the leg
                    // push data to be validated
                //}
            }
        }
    }
    
    
    public func pedometer(locationSample: LocomotionSample) {
        
    }
    
    public func startOdometer(locationSample: LocomotionSample){
        
        
        
    }
    
    //=
    
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
    
    
    //Begin Haversine Formula
    
    ///////////////////////////////////////////////////////////////////////
    ///  This function converts decimal degrees to radians              ///
    ///////////////////////////////////////////////////////////////////////
    func deg2rad(deg:Double) -> Double {
        return deg * M_PI / 180
    }
    
    ///////////////////////////////////////////////////////////////////////
    ///  This function converts radians to decimal degrees              ///
    ///////////////////////////////////////////////////////////////////////
    func rad2deg(rad:Double) -> Double {
        return rad * 180.0 / M_PI
    }
    
    func distance(lat1:Double, lon1:Double, lat2:Double, lon2:Double, unit:String) -> Double {
        let theta = lon1 - lon2
        var dist = sin(deg2rad(deg: lat1)) * sin(deg2rad(deg: lat2)) + cos(deg2rad(deg: lat1)) * cos(deg2rad(deg: lat2)) * cos(deg2rad(deg: theta))
        dist = acos(dist)
        dist = rad2deg(rad: dist)
        dist = dist * 60 * 1.1515
        if (unit == "K") {
            dist = dist * 1.609344
        }
        else if (unit == "N") {
            dist = dist * 0.8684
        }
        return dist
    }

    
    //End Haversine Formula
    
    
}
