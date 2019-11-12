//
//  DocumentViewController.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 01/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit
import Photos
import SDWebImage

/*
 MARK: - Enum Document Open From
 */
enum DocumentOpenType{
    case register
    case sideMenu
    case partiallyRegister
}
//end

class DocumentViewController: UIViewController {
    
    /*
     MARK: - Properties
     */
    @IBOutlet weak var sideMenuHeaderView: UIView!
    @IBOutlet weak var registerHeaderView: UIView!
    @IBOutlet var btnBack                : UIButton!
    @IBOutlet var btnSubmit              : UIButton!
    
    @IBOutlet var btnEmiratesFront       : UIButton!
    @IBOutlet var btnEmiratesBack        : UIButton!
    @IBOutlet var btnEmiratesFrontCross  : UIButton!
    @IBOutlet var btnEmiratesBackCross   : UIButton!
    
    @IBOutlet var btnDriversFront        : UIButton!
    @IBOutlet var btnDriversBack         : UIButton!
    @IBOutlet var btnDriversFrontCross   : UIButton!
    @IBOutlet var btnDriversBackCross    : UIButton!
    
    var arrayOfDocs                      : [Docs]!
    var arrayOfLicense                   : [Licenses]!
    
    var emiratesFront_Id                 : String                   = ""
    var emiratesBack_Id                  : String                   = ""
    var driverFront_Id                   : String                   = ""
    var driverBack_Id                    : String                   = ""
    
    var isEmiratesFrontEdit              : Bool                     = false
    var isEmiratesBackEdit               : Bool                     = false
    var isDriverFrontEdit                : Bool                     = false
    var isDriverBackEdit                 : Bool                     = false
    
    var uploadDocArray                   : [UIImage]                = []
    var uploadLicenseArray               : [UIImage]                = []
    
    var deleteDocArray                   : [String]                 = []
    var deleteLicenseArray               : [String]                 = []
    
    var imagePicker                      : UIImagePickerController   = UIImagePickerController()
    var openFrom                         : DocumentOpenType!
    //end
    
    /*
     MARK: - UIViewController Life Cycle
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        // Do any additional setup after loading the view.
    }
    //end
    
    /*
     MARK: - UIViewController Life Cycle
     */
    func setUp(){
        //Setup Header
        if self.openFrom == .register || self.openFrom == .partiallyRegister{
            self.sideMenuHeaderView.isHidden = true
            self.btnSubmit.setTitle("Finish", for: .normal)
        }else{
            self.registerHeaderView.isHidden = true
            self.btnSubmit.setTitle("Save", for: .normal)
        }
        
        //Setup Cross Button
        self.btnEmiratesFrontCross.isHidden = true
        self.btnEmiratesBackCross.isHidden = true
        self.btnDriversFrontCross.isHidden = true
        self.btnDriversBackCross.isHidden = true
        
        //Set Data
        if self.openFrom == .sideMenu{
            if self.arrayOfDocs.count > 0{
                for i in 0..<self.arrayOfDocs.count{
                    let model = self.arrayOfDocs[i]
                    if i == 0{
                        if let frontImage = model.img{
                            self.btnEmiratesFront.sd_imageIndicator = SDWebImageActivityIndicator.white
                            self.btnEmiratesFront.sd_setBackgroundImage(with: URL(string: frontImage), for: .normal, completed: nil)
                            self.emiratesFront_Id = "\(model.n!)"
                            self.isEmiratesFrontEdit = false
                            self.btnEmiratesFrontCross.isHidden = false
                        }else{
                            self.btnEmiratesFront.setBackgroundImage(UIImage(named: ""), for: .normal)
                            self.btnEmiratesFrontCross.isHidden = true
                        }
                    }else if i == 1{
                        if let backImage = model.img{
                            self.btnEmiratesBack.sd_imageIndicator = SDWebImageActivityIndicator.white
                            self.btnEmiratesBack.sd_setBackgroundImage(with: URL(string: backImage), for: .normal, completed: nil)
                            self.isEmiratesBackEdit = false
                            self.emiratesBack_Id = "\(model.n!)"
                            self.btnEmiratesBackCross.isHidden = false
                        }else{
                            self.btnEmiratesBack.setBackgroundImage(UIImage(named: ""), for: .normal)
                            self.btnEmiratesBackCross.isHidden = true
                        }
                    }else{
                        
                    }
                }
            }
            
            if self.arrayOfLicense.count > 0{
                for i in 0..<self.arrayOfLicense.count
                {
                    let model = self.arrayOfLicense[i]
                    if i == 0{
                        if let frontImage = model.img{
                            self.btnDriversFront.sd_imageIndicator = SDWebImageActivityIndicator.white
                            self.btnDriversFront.sd_setBackgroundImage(with: URL(string: frontImage), for: .normal, completed: nil)
                            self.driverFront_Id = "\(model.n!)"
                            self.btnDriversFrontCross.isHidden = false
                            self.isDriverFrontEdit = false
                        }else{
                            self.btnDriversFront.setBackgroundImage(UIImage(named: ""), for: .normal)
                            self.btnDriversFrontCross.isHidden = true
                        }
                    }else if i == 1{
                        if let backImage = model.img{
                            self.btnDriversBack.sd_imageIndicator = SDWebImageActivityIndicator.white
                            self.btnDriversBack.sd_setBackgroundImage(with: URL(string: backImage), for: .normal, completed: nil)
                            self.driverBack_Id = "\(model.n!)"
                            self.btnDriversBackCross.isHidden = false
                            self.isDriverBackEdit = false
                        }else{
                            self.btnDriversBack.setBackgroundImage(UIImage(named: ""), for: .normal)
                            self.btnDriversBackCross.isHidden = true
                        }
                    }else{
                        
                    }
                }
            }
        }else{
            
        }
    }
    //end
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSubmitTapped(_ sender: Any) {
        var docsImageArray: [String] = []
        //Docs Image
        
        if self.uploadDocArray.count > 0{
            for image in self.uploadDocArray{
                let ImageData: Data =  image.jpegData(compressionQuality: 0.25)!
                docsImageArray.append(ImageData.base64EncodedString())
            }
        }
        
        var licensesImageArray: [String] = []
        //Docs Image
        
        if self.uploadLicenseArray.count > 0{
            for image in self.uploadLicenseArray{
                let ImageData: Data =  image.jpegData(compressionQuality: 0.25)!
                licensesImageArray.append(ImageData.base64EncodedString())
            }
        }
        
        if self.openFrom == .register{
            if self.btnEmiratesFront.currentBackgroundImage == nil && self.btnEmiratesBack.currentBackgroundImage == nil && self.btnDriversFront.currentBackgroundImage == nil && self.btnDriversBack.currentBackgroundImage == nil{
                AlertViewController.openAlertView(title: "Success", message: "You are now a member of SuperCars Majlis.", buttons: ["Continue"]) { (index) in
                    let vc = Constants.homeStoryboard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }else{
                var accessTokenModel: RegisterModel!
                if getAccessTokenModel() != nil{
                    accessTokenModel = getAccessTokenModel()
                }
                self.callUpdateDocumentAPI(user_Id: String(accessTokenModel.user!.id!), licensesArray: licensesImageArray, docsArray: docsImageArray, licenseDeleteArray: self.deleteLicenseArray, docsDeleteArray: self.deleteDocArray)
            }
        }else if self.openFrom == .partiallyRegister{
            
            if licensesImageArray.count > 0 && docsImageArray.count > 0{
                var accessTokenModel: RegisterModel!
                if getAccessTokenModel() != nil{
                    accessTokenModel = getAccessTokenModel()
                }
                self.callUpdateDocumentAPI(user_Id: String(accessTokenModel.user!.id!), licensesArray: licensesImageArray, docsArray: docsImageArray, licenseDeleteArray: self.deleteLicenseArray, docsDeleteArray: self.deleteDocArray)
            }else{
                if docsImageArray.count == 0{
                    AlertViewController.openAlertView(title: "Error", message: "Please upload emirates id", buttons: ["OK"])
                }else if licensesImageArray.count == 0{
                    AlertViewController.openAlertView(title: "Error", message: "Please upload drivers license", buttons: ["OK"])
                }else{
                    
                }
//                AlertViewController.openAlertView(title: "Error", message: "Please upload emirates id and drivers license", buttons: ["OK"])
            }
        }else{
            var accessTokenModel: RegisterModel!
            if getAccessTokenModel() != nil{
                accessTokenModel = getAccessTokenModel()
            }
            DispatchQueue.main.async {
                self.callUpdateDocumentAPI(user_Id: String(accessTokenModel.user!.id!), licensesArray: licensesImageArray, docsArray: docsImageArray, licenseDeleteArray: self.deleteLicenseArray, docsDeleteArray: self.deleteDocArray)
            }
        }
    }
    
    @IBAction func btnEmiratesFrontTapped(_ sender: Any) {
        if self.btnEmiratesFront.currentBackgroundImage == nil{
            ImagePicker.openImagePicker { (image) in
                self.btnEmiratesFront.setBackgroundImage(image, for: .normal)
                self.btnEmiratesFrontCross.isHidden = false
                self.isEmiratesFrontEdit = true
                self.uploadDocArray.append(image)
            }
        }
    }
    
    @IBAction func btnEmiratesBackTapped(_ sender: Any) {
        if self.btnEmiratesBack.currentBackgroundImage == nil{
            ImagePicker.openImagePicker { (image) in
                self.btnEmiratesBack.setBackgroundImage(image, for: .normal)
                self.btnEmiratesBackCross.isHidden = false
                self.isEmiratesBackEdit = true
                self.uploadDocArray.append(image)
            }
        }
    }
    
    @IBAction func btnDriversFrontTapped(_ sender: Any) {
        if self.btnDriversFront.currentBackgroundImage == nil{
            ImagePicker.openImagePicker { (image) in
                self.btnDriversFront.setBackgroundImage(image, for: .normal)
                self.btnDriversFrontCross.isHidden = false
                self.isDriverFrontEdit = true
                self.uploadLicenseArray.append(image)
            }
        }
    }
    
    @IBAction func btnDriversBackTapped(_ sender: Any) {
        if self.btnDriversBack.currentBackgroundImage == nil{
            ImagePicker.openImagePicker { (image) in
                self.btnDriversBack.setBackgroundImage(image, for: .normal)
                self.btnDriversBackCross.isHidden = false
                self.isDriverBackEdit = true
                self.uploadLicenseArray.append(image)
            }
        }
    }
    
    @IBAction func btnEmiratesFrontCrossTapped(_ sender: Any) {
        self.btnEmiratesFront.setBackgroundImage(nil, for: .normal)
        self.btnEmiratesFrontCross.isHidden = true
        if self.emiratesFront_Id != ""{
            var array: [String] = []
            array.append(self.emiratesFront_Id)
            self.deleteDocArray = self.deleteDocArray + array
            self.emiratesFront_Id = ""
        }
    }
    
    @IBAction func btnEmiratesBackCrossTapped(_ sender: Any) {
        self.btnEmiratesBack.setBackgroundImage(nil, for: .normal)
        self.btnEmiratesBackCross.isHidden = true
        if self.emiratesBack_Id != ""{
            var array: [String] = []
            array.append(self.emiratesBack_Id)
            self.deleteDocArray = self.deleteDocArray + array
            self.emiratesBack_Id = ""
        }
    }
    
    @IBAction func btnDriversFrontCrossTapped(_ sender: Any) {
        self.btnDriversFront.setBackgroundImage(nil, for: .normal)
        self.btnDriversFrontCross.isHidden = true
        if self.driverFront_Id != ""{
            var array: [String] = []
            array.append(self.driverFront_Id)
            self.deleteLicenseArray = self.deleteLicenseArray + array
            self.driverFront_Id = ""
        }
    }
    
    @IBAction func btnDriversBackCrossTapped(_ sender: Any) {
        self.btnDriversBack.setBackgroundImage(nil, for: .normal)
        self.btnDriversBackCross.isHidden = true
        if self.driverBack_Id != ""{
            var array: [String] = []
            array.append(self.driverBack_Id)
            self.deleteLicenseArray = self.deleteLicenseArray + array
            self.driverBack_Id = ""
        }
    }
}

