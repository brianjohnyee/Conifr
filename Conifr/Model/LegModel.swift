//
//  LegModel.swift
//  
//
//  Created by Sid Verma on 2/6/18.
//

import Foundation
import CoreLocation

class Leg {
    
    //MARK: Properties
    
    var legID: String
    var totalDistance: Double
    var totalC02Emission: Double
    var modeOfTransportation: String
    var startTime: Double
    var endTime: Double
    var startLocation: CLLocationCoordinate2D
    var endLocation: CLLocationCoordinate2D
    
    
    //MARK: Initialization
    
    init?(legID: String, totalDistance: Double, totalC02Emission:Double, modeOfTransportation: String, startTime: Double, endTime: Double, startLocation: CLLocationCoordinate2D, endLocation: CLLocationCoordinate2D) {
        
        //Initialization should fail if distance is less than zero or total C02 emission is less than 0 or mode of transportation is empty or start/end time is less than or equal to zero
        if legID == "" ,totalDistance < 0 || totalC02Emission < 0 || modeOfTransportation == "" || startTime <= 0 || endTime <= 0 {
            return nil
        }

        self.legID = legID
        self.totalDistance = totalDistance
        self.totalC02Emission = totalC02Emission
        self.modeOfTransportation = modeOfTransportation
        self.startTime = startTime
        self.endTime = endTime
        self.startLocation = startLocation
        self.endLocation = endLocation
    }
    
}
