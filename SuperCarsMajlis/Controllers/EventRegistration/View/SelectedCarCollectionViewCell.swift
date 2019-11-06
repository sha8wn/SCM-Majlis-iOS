//
//  SelectedCarCollectionViewCell.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 10/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit

class SelectedCarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bgView      : UIView!
    @IBOutlet weak var imgCar      : UIImageView!
    @IBOutlet weak var lblCarName  : UILabel!
    @IBOutlet weak var lblCarModel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
