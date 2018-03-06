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
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var startPoint: UITextField!
    @IBOutlet weak var endPoint: UITextField!
    @IBOutlet weak var modeOfTransportation: UITextField!
    @IBOutlet weak var startTime: UITextField!
    @IBOutlet weak var endTime: UITextField!
    @IBOutlet weak var mapView: MKMapView?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 12
    }
    
    
    
}
