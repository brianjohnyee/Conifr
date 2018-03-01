//
//  StatsCell.swift
//  Conifr
//
//  Created by Kenji Mah on 2/19/18.
//  Copyright © 2018 Sid Verma. All rights reserved.
//

import UIKit
import MapKit

class StatsCell: UICollectionViewCell {

    @IBOutlet var date: UILabel!
    @IBOutlet var image: UIImageView!
    @IBOutlet var statsDist: UILabel!
    @IBOutlet var modeExt: UILabel!
    @IBOutlet var natAvg: UILabel!
    @IBOutlet var statsMap: MKMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 12
        // Initialization code
    }

}
