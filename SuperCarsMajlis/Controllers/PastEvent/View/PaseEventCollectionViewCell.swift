//
//  PaseEventCollectionViewCell.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 26/09/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit

class PaseEventCollectionViewCell: UICollectionViewCell {

    /*
     MARK: - Properties
     */
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblNoOfGoing: UILabel!
    @IBOutlet weak var lblEventTitle: UILabel!
    @IBOutlet weak var lblDateAndTime: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblSepratorDate: UILabel!
    @IBOutlet weak var imgViewLocation: UIImageView!
    @IBOutlet weak var imgViewPeople: UIImageView!
    //end
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
