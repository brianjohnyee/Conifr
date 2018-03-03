//
//  AdddTripCollectionVC.swift
//  Conifr
//
//  Created by Sid Verma on 2/28/18.
//  Copyright © 2018 Sid Verma. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import MapKit

class AdddTripCollectionVC: UICollectionViewController, UICollectionViewDelegateFlowLayout, MKMapViewDelegate {
    
    @IBOutlet weak var addTripCollectionView: UICollectionView!
    
    private let reuseIdentifier = "addTrip"
    var numberOfItemsInSection = Int()
    var legs = [Leg]()
    var coord = [CLLocationCoordinate2D]()
    var distance = [Double]()
    var distances = Double()
    
    override func viewDidLoad() {
        //
        //Register cells to be reused
        self.addTripCollectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "addTrip")
        self.addTripCollectionView!.register(UINib(nibName: "AddTripCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        self.addTripCollectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "addLeg")
        self.addTripCollectionView!.register(UINib(nibName: "AddLegCell", bundle: nil), forCellWithReuseIdentifier: "addLeg")
        
        numberOfItemsInSection = 2
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Add Trip"
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped(sender:)))
        doneButton.tintColor = UIColor(red:86/255.0, green:86/255.0, blue:86/255.0,  alpha:1)
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = doneButton
    }
    
    @objc func doneButtonTapped(sender: UIBarButtonItem){
        //Push data to db
        if let uid = UserDefaults.standard.value(forKey: "uid"){
            let refToUser = Database.database().reference().child("users").child("uid")
            let tripKey = Database.database().reference().child("trips").childByAutoId().key
            
            for i in 0...numberOfItemsInSection-1 {
                //Read points of data
                var legKey = Database.database().reference().child("legs").childByAutoId().key
                
                
                
            }
            
            if numberOfItemsInSection - 1 > 1 {
                //The start and end point don't reside in the same leg
                
            }
            //Sets trip to child
            refToUser.child("trips").child(tripKey).setValue(true)
        }
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    //Collection View Data Source & Delegate Conformation
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //
        
        return numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == numberOfItemsInSection - 1 {
            
            return CGSize(width: self.addTripCollectionView.frame.width - 30, height: 50)
            
        } else {
            
            return CGSize(width: self.addTripCollectionView.frame.width - 30, height: self.addTripCollectionView.frame.height - 125)
            
        }
        
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        //Last cell
        if indexPath.item == numberOfItemsInSection - 1 {
            
            let addLegCell = collectionView.dequeueReusableCell(withReuseIdentifier: "addLeg", for: indexPath)
            
            addLegCell.layer.cornerRadius = 12
            
            
            
            //collectionView.cellForItem(at: indexPath)?.contentView.bounds.size.height = 50
            
            return addLegCell
            
        } else {
            
            let addInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AddTripCell
            
            //addInfoCell.startPoint
            
            //addInfoCell.endPoint
            
            addInfoCell.mapView?.delegate = self
            var donzo = 0
            while donzo == 0 {
            if(addInfoCell.count > 1){
            let sourceCoordinates = addInfoCell.coord[addInfoCell.count - 2]
            let destCoordinates = addInfoCell.coord[addInfoCell.count - 1]
            // mapkit placemarks
            let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinates)
            let destPlacemark = MKPlacemark(coordinate: destCoordinates)
            let test1 = CLLocation(latitude: sourceCoordinates.latitude,longitude: sourceCoordinates.longitude)
            let test2 = CLLocation(latitude: destCoordinates.latitude, longitude: destCoordinates.longitude)
            var dist : CLLocationDistance = test1.distance(from: test2)
            
            self.distance.append(dist / 1609.34)
            
           /* print("trip distance = \(addInfoCell.distance[addInfoCell.count - 2]) m")
            distances += (distance[addInfoCell.count-2])
            print("total distance = \(distances)")*/
            
            // source item important for getting directions 11
            let sourceItem = MKMapItem(placemark: sourcePlacemark)
            let destItem = MKMapItem(placemark: destPlacemark)
            
            let directionRequest = MKDirectionsRequest()
            directionRequest.source = sourceItem
            directionRequest.destination = destItem
            directionRequest.transportType = .any
            // EOIWNGEOIGNROREG
            
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
                addInfoCell.mapView?.add(route.polyline,level: .aboveRoads)
                let rekt  = route.polyline.boundingMapRect
                //self.mapkitview.setRegion(MKCoordinateRegionForMapRect(rekt), animated: true)
                
                
            })
            }
                donzo = 1
            }
            return addInfoCell
            
        }

    }
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay)-> MKOverlayRenderer{
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 2.0
        
        return renderer
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == numberOfItemsInSection - 1 {
            
            numberOfItemsInSection+=1
            self.addTripCollectionView.reloadData()
            
        }
        
        
    }
    
    
    
    
}
