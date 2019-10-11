//
//  EventDescTableViewCell.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 10/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit

class EventDescTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle      : UILabel!
    @IBOutlet weak var lblDesc       : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
