//
//  AddTripCell.swift
//  Conifr
//
//  Created by Sid Verma on 2/28/18.
//  Copyright © 2018 Sid Verma. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import ActionSheetPicker_3_0

class AddTripCell: UICollectionViewCell {
    
    var count = 0
    var coord = [CLLocationCoordinate2D]()
    var anno = MKPointAnnotation()
    var anno1 = MKPointAnnotation()
    var distance = [Double]()
    var pin1 = 0
    var pin2 = 0
    var names = String()
    var modeOfTrans = String()
    var start = String()
    var end = String()
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var startPoint: UITextField!
    @IBOutlet weak var endPoint: UITextField!
    @IBOutlet weak var modeOfTransportation: UITextField!
    @IBOutlet weak var startTime: UITextField!
    @IBOutlet weak var endTime: UITextField!
    @IBOutlet weak var mapView: MKMapView?
    
    @IBAction func names(_ sender: Any) {
        print("pls \(anno.coordinate.latitude)")
        names = name.text!
    }
    
    @IBAction func modeOfTrans(_ sender: Any) {
        modeOfTrans = modeOfTransportation.text!
    }
    
    @IBAction func starting(_ sender: Any) {
        start = startTime.text!
    }
    
    @IBAction func ending(_ sender: Any) {
        end = endTime.text!
    }
    
    @IBAction func pins(_ sender: Any) {
        if (pin1 == 1){
            self.mapView?.removeAnnotation(anno)
        }
        count += 1
        pin1 = 1
        print (count)
            
        //let address1 = " 140 Front St, Santa Cruz, CA 95060 "
        //var address1 = ""
        let address1 = self.startPoint.text!
        var geocoder = CLGeocoder()
        geocoder.geocodeAddressString( address1){
            placemarks, error in
            let placemark = placemarks?.first
            //            print(placemark?.locality)
            //            if placemark?.locality == "Santa Cruz" {
            let lat = placemark?.location?.coordinate.latitude
            let lon = placemark?.location?.coordinate.longitude
            print("Lat: \(lat), Lon: \(lon)")
            //coord[self.count] = CLLocationCoordinate2DMake(lat!, lon!)
            self.coord.append(CLLocationCoordinate2DMake(lat!, lon!))
            self.anno.coordinate = self.coord[self.count - 1]
            self.mapView?.addAnnotation(self.anno)
        }
    //  }
    }
    
    
    @IBAction func endAdd(_ sender: Any) {
        if (pin1 == 1){
            self.mapView?.removeAnnotation(anno1)
        }
        count += 1
        pin2 = 1
        print ("Poo Poo: \(count)")
        
        //let address1 = " 140 Front St, Santa Cruz, CA 95060 "
        //var address1 = ""
        let address1 = self.endPoint.text!
        var geocoder = CLGeocoder()
        geocoder.geocodeAddressString( address1){
            placemarks, error in
            let placemark = placemarks?.first
            //            print(placemark?.locality)
            //            if placemark?.locality == "Santa Cruz" {
            let lat = placemark?.location?.coordinate.latitude
            let lon = placemark?.location?.coordinate.longitude
            print("Lat: \(lat), Lon: \(lon)")
            //coord[self.count] = CLLocationCoordinate2DMake(lat!, lon!)
            self.coord.append(CLLocationCoordinate2DMake(lat!, lon!))
            self.anno1.coordinate = self.coord[self.count - 1]
            self.mapView?.addAnnotation(self.anno1)
        }
        //  }
       // timer = 1
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 12
    }
    
    
    
}
