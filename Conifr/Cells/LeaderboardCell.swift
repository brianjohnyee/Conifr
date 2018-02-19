//
//  LeaderboardCell.swift
//  Conifr
//
//  Created by Kenji Maolo Mah on 2/17/18.
//  Copyright © 2018 Sid Verma. All rights reserved.
//

import UIKit

class LeaderboardCell: UICollectionViewCell {

    @IBOutlet weak var Avatar: UIImageView!
    @IBOutlet weak var Score: UILabel!
    @IBOutlet weak var Name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 12
        Avatar.layer.cornerRadius = 20
        // Initialization code
    }

}
