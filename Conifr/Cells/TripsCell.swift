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
        self.contentView.layer.cornerRadius = 8.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }

}
