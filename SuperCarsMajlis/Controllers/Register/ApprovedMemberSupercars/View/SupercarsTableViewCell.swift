//
//  SupercarsTableViewCell.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 01/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit
import SDWebImage

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
    @IBOutlet weak var imgUploadCar          : UIImageView!
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
        if let isFrontImageEdit = model.isCarRegistraionFrontImageEdit{
            if isFrontImageEdit == false{
                if let frontImage = model.carRegistraionFrontImageURL{
                    self.btnUploadFront.sd_imageIndicator = SDWebImageActivityIndicator.white
                    self.btnUploadFront.sd_setBackgroundImage(with: URL(string: frontImage), for: .normal, completed: nil)
                    self.btnCrossFront.isHidden = false
                }else{
                    self.btnUploadFront.setBackgroundImage(UIImage(named: ""), for: .normal)
                    self.btnCrossFront.isHidden = true
                }
            }else{
                if let frontImage = model.carRegistraionFrontImage{
                    self.btnUploadFront.setBackgroundImage(frontImage, for: .normal)
                    self.btnCrossFront.isHidden = false
                }else{
                    self.btnUploadFront.setBackgroundImage(UIImage(named: ""), for: .normal)
                    self.btnCrossFront.isHidden = true
                }
            }
        }else{
            if let frontImage = model.carRegistraionFrontImage{
                self.btnUploadFront.setBackgroundImage(frontImage, for: .normal)
                self.btnCrossFront.isHidden = false
            }else{
                self.btnUploadFront.setBackgroundImage(UIImage(named: ""), for: .normal)
                self.btnCrossFront.isHidden = true
            }
        }

        //BACK IMAGE
        if let isBackImageEdit = model.isCarRegistraionBackImageEdit{
            if isBackImageEdit == false{
                if let backImage = model.carRegistraionBackImageURL{
                    self.btnUploadBack.sd_imageIndicator = SDWebImageActivityIndicator.white
                    self.btnUploadBack.sd_setBackgroundImage(with: URL(string: backImage), for: .normal, completed: nil)
                    self.btnCrossBack.isHidden = false
                }else{
                    self.btnUploadBack.setBackgroundImage(UIImage(named: ""), for: .normal)
                    self.btnCrossBack.isHidden = true
                }
            }else{
                if let backImage = model.carRegistraionBackImage{
                    self.btnUploadBack.setBackgroundImage(backImage, for: .normal)
                    self.btnCrossBack.isHidden = false
                }else{
                    self.btnUploadBack.setBackgroundImage(UIImage(named: ""), for: .normal)
                    self.btnCrossBack.isHidden = true
                }
            }
        }else{
            if let backImage = model.carRegistraionBackImage{
                self.btnUploadBack.setBackgroundImage(backImage, for: .normal)
                self.btnCrossBack.isHidden = false
            }else{
                self.btnUploadBack.setBackgroundImage(UIImage(named: ""), for: .normal)
                self.btnCrossBack.isHidden = true
            }
        }
        
        //CAR IMAGE
        if let isCarImageEdit = model.isCarImageEdit{
            if isCarImageEdit == false{
                if let carImage = model.carImageURL{
                    self.imgUploadCar.sd_imageIndicator = SDWebImageActivityIndicator.white
                    self.imgUploadCar.sd_setImage(with: URL(string: carImage), completed: nil)
                    self.btnCrossCar.isHidden = false
                }else{
                    self.imgUploadCar.image = UIImage(named: "")
                    self.btnCrossCar.isHidden = true
                }
            }else{
               if let carImage = model.carImage{
                   self.imgUploadCar.image = carImage
                   self.btnCrossCar.isHidden = false
               }else{
                   self.imgUploadCar.image = UIImage(named: "")
                   self.btnCrossCar.isHidden = true
               }
            }
        }else{
            if let carImage = model.carImage{
                self.imgUploadCar.image = carImage
                self.btnCrossCar.isHidden = false
            }else{
                self.imgUploadCar.image = UIImage(named: "")
                self.btnCrossCar.isHidden = true
            }
        }
        
        
    }
}
