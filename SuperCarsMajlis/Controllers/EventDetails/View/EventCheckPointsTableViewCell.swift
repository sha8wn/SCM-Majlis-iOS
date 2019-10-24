//
//  EventCheckPointsTableViewCell.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 10/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit

class EventCheckPointsTableViewCell: UITableViewCell {

    @IBOutlet weak var btnCheckIn: UIButton!
    @IBOutlet weak var btnDirection: UIButton!
    @IBOutlet weak var lblDirection: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var checkInView: UIView!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var lblTitle      : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
