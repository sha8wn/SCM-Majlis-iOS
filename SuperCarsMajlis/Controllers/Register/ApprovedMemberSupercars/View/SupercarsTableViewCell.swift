//
//  SupercarsTableViewCell.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 01/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit

/*
MARK: - Enum Supercars Cell Type
*/
enum SupercarsCellType{
    case register
    case edit
}
//end

class SupercarsTableViewCell: UITableViewCell {
    /*
     MARK: - Properties
     */
    @IBOutlet weak var btnCrossFront         : UIButton!
    @IBOutlet weak var btnCrossBack          : UIButton!
    @IBOutlet weak var btnCrossCar           : UIButton!
    @IBOutlet weak var btnUploadFront        : UIButton!
    @IBOutlet weak var btnUploadBack         : UIButton!
    @IBOutlet weak var btnUploadCar          : UIButton!
    @IBOutlet weak var deleteheightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnDelete             : UIButton!
    @IBOutlet weak var btnColor              : UIButton!
    @IBOutlet weak var txtColor              : UITextField!
    @IBOutlet weak var btnModel              : UIButton!
    @IBOutlet weak var txtModel              : UITextField!
    @IBOutlet weak var btnBrand              : UIButton!
    @IBOutlet weak var txtBrand              : UITextField!
    //end
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.txtBrand.isUserInteractionEnabled = false
        self.txtModel.isUserInteractionEnabled = false
        self.txtColor.isUserInteractionEnabled = false
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell(index: Int, type: SupercarsCellType, model: SupercarsModel){
        //MODEL
        if let model = model.model{
            self.txtModel.text = model
        }else{
            self.txtModel.text = ""
        }
        //BRAND
        if let brand = model.brand{
            self.txtBrand.text = brand
        }else{
            self.txtBrand.text = ""
        }
        //COLOR
        if let color = model.color{
            self.txtColor.text = color
        }else{
            self.txtColor.text = ""
        }
        //FRONT IMAGE
        if let frontImage = model.carRegistraionFrontImage{
            self.btnUploadFront.setBackgroundImage(frontImage, for: .normal)
            self.btnCrossFront.isHidden = false
        }else{
            self.btnUploadFront.setBackgroundImage(UIImage(named: ""), for: .normal)
            self.btnCrossFront.isHidden = true
        }
        //BACK IMAGE
        if let backImage = model.carRegistraionBackImage{
            self.btnUploadBack.setBackgroundImage(backImage, for: .normal)
            self.btnCrossBack.isHidden = false
        }else{
            self.btnUploadBack.setBackgroundImage(UIImage(named: ""), for: .normal)
            self.btnCrossBack.isHidden = true
        }
        //CAR IMAGE
        if let carImage = model.carImage{
            self.btnUploadCar.setBackgroundImage(carImage, for: .normal)
            self.btnCrossCar.isHidden = false
        }else{
            self.btnUploadCar.setBackgroundImage(UIImage(named: ""), for: .normal)
            self.btnCrossCar.isHidden = true
        }
        
        //SETUP DELETE BUTTON
        if index == 0{
            self.btnDelete.isHidden = true
            self.deleteheightConstraint.constant = 0
        }else{
            self.btnDelete.isHidden = false
            self.deleteheightConstraint.constant = 50
        }
    }
}
