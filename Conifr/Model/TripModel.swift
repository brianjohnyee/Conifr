//
//  TripModel.swift
//  Conifr
//
//  Created by Sid Verma on 2/6/18.
//  Copyright © 2018 Sid Verma. All rights reserved.
//

import Foundation
import CoreLocation

class Trip {
    
    //MARK: Properties
    
    var tripID: String
    var totalDistance: Double
    var totalC02Emission: Double
    var modesOfTransportation: [String]
    var legs: [Leg]
    var startTime: Double
    var endTime: Double
    var startLocation: CLLocationCoordinate2D
    var endLocation: CLLocationCoordinate2D
    
    
    //MARK: Initialization
    
    init?(tripID: String, totalDistance: Double, totalC02Emission:Double, modeOfTransportation: [String],legs: [Leg],  startTime: Double, endTime: Double, startLocation: CLLocationCoordinate2D, endLocation: CLLocationCoordinate2D) {
        
        //Initialization should fail if distance is less than zero or total C02 emission is less than 0 or mode of transportation is empty or start/end time is less than or equal to zero
        if tripID == "", totalDistance < 0 || totalC02Emission < 0 || modeOfTransportation.isEmpty || startTime <= 0 || endTime <= 0 || legs.isEmpty {
            return nil
        }
        
        self.tripID = tripID
        self.totalDistance = totalDistance
        self.totalC02Emission = totalC02Emission
        self.modesOfTransportation = modeOfTransportation
        self.legs = legs
        self.startTime = startTime
        self.endTime = endTime
        self.startLocation = startLocation
        self.endLocation = endLocation
    }
    
}
