//
//  TripsCell.swift
//  
//
//  Created by Sid Verma on 2/6/18.
//

import UIKit
import MapKit

class TripsCell: UICollectionViewCell {
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var dist: UILabel!
    @IBOutlet var img: UIImageView!
    @IBOutlet weak var mode: UILabel!
    @IBOutlet var tripMap: MKMapView!    /*
     func displayContent(image: UIImage, title: String){
        dateTime.text = title
        dist.text = title
        mode.text = title
    }
*/
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 12
        self.backgroundColor = UIColor.white
    }
}
