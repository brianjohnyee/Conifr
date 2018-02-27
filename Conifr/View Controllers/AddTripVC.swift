//
//  AddTripVC.swift
//  Conifr
//
//  Created by Kenji Mah on 2/27/18.
//  Copyright © 2018 Sid Verma. All rights reserved.
//

import UIKit
import MapKit

class AddTripVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var address: UITextField!
    
    let locationManager = CLLocationManager()
    @IBOutlet weak var mapkitview: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapkitview.delegate = self
        mapkitview.showsScale = true // can display other things just need to cahnge shows""
        mapkitview.showsPointsOfInterest = true // shows if we are close to destination
        mapkitview.showsUserLocation = true // user location start of trip
        // privacy 500
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            // can just accuracy from best to 100 meters, 10 meters, but best if accurate since getting directions
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    var count = 0
    var coord = [CLLocationCoordinate2D]()
    @IBAction func userInput(_ sender: Any) {
        count += 1
        
        print (count)
        
        //let address1 = " 140 Front St, Santa Cruz, CA 95060 "
        //var address1 = ""
        let address1 = address.text!
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
            let annotation = MKPointAnnotation()
            annotation.coordinate = self.coord[self.count - 1]
            self.mapkitview.addAnnotation(annotation)
            if(self.count >= 2){
                let sourceCoordinates = self.coord[self.count - 2]
                let destCoordinates = self.coord[self.count - 1]
                // mapkit placemarks
                // assume these are the ends of trips to show on the map. dont know why it is ! 10:52
                let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinates)
                let destPlacemark = MKPlacemark(coordinate: destCoordinates)
                
                // source item important for getting directions 11
                let sourceItem = MKMapItem(placemark: sourcePlacemark)
                let destItem = MKMapItem(placemark: destPlacemark)
                
                let directionRequest = MKDirectionsRequest()
                directionRequest.source = sourceItem
                directionRequest.destination = destItem
                directionRequest.transportType = .any
                // EOIWNGEOIGNROREG
                
                
                // 14 minutes no clue what just happened
                let directions = MKDirections(request: directionRequest)
                directions.calculate(completionHandler: {
                    response, error in
                    guard let response = response else {
                        if let error = error{
                            print("sometihng went wrong")
                        }
                        return
                    }
                    
                    let route = response.routes[0]
                    self.mapkitview.add(route.polyline,level: .aboveRoads)
                    let rekt  = route.polyline.boundingMapRect
                    self.mapkitview.setRegion(MKCoordinateRegionForMapRect(rekt), animated: true)
                    
                    
                })
            }
        }
        //  }
        

    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay)-> MKOverlayRenderer{
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 2.0
        
        return renderer
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
