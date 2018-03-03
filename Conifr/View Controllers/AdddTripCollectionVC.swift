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
    var count = 0
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
            
            return addInfoCell
            
        }

    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == numberOfItemsInSection - 1 {
            
            numberOfItemsInSection+=1
            self.addTripCollectionView.reloadData()
            
        }
        
        
    }
    
    
    
    
}
