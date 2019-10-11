//
//  DocumentViewController.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 01/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit
import Photos

/*
 MARK: - Enum Document Open From
 */
enum DocumentOpenType{
    case register
    case sideMenu
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
    @IBOutlet var btnDriversBack        : UIButton!
    @IBOutlet var btnDriversFrontCross   : UIButton!
    @IBOutlet var btnDriversBackCross    : UIButton!
    
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
        if self.openFrom == .register{
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
        if self.openFrom == .register{
            AlertViewController.openAlertView(title: "Sucess", message: "You are now a member of SuperCars Majlis.", buttons: ["Continue"]) { (index) in
                let vc = Constants.homeStoryboard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else{
            AlertViewController.openAlertView(title: "Sucess", message: "Documents Saved Successfully.", buttons: ["Ok"]) { (index) in
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func btnEmiratesFrontTapped(_ sender: Any) {
        ImagePicker.openImagePicker { (image) in
            self.btnEmiratesFront.setBackgroundImage(image, for: .normal)
            self.btnEmiratesFrontCross.isHidden = false
        }
    }
    
    @IBAction func btnEmiratesBackTapped(_ sender: Any) {
        ImagePicker.openImagePicker { (image) in
            self.btnEmiratesBack.setBackgroundImage(image, for: .normal)
            self.btnEmiratesBackCross.isHidden = false
        }
    }
    
    @IBAction func btnDriversFrontTapped(_ sender: Any) {
        ImagePicker.openImagePicker { (image) in
            self.btnDriversFront.setBackgroundImage(image, for: .normal)
            self.btnDriversFrontCross.isHidden = false
        }
    }
    
    @IBAction func btnDriversBackTapped(_ sender: Any) {
        ImagePicker.openImagePicker { (image) in
            self.btnDriversBack.setBackgroundImage(image, for: .normal)
            self.btnDriversBackCross.isHidden = false
        }
    }
    
    @IBAction func btnEmiratesFrontCrossTapped(_ sender: Any) {
        self.btnEmiratesFront.setBackgroundImage(nil, for: .normal)
        self.btnEmiratesFrontCross.isHidden = true
    }
    
    @IBAction func btnEmiratesBackCrossTapped(_ sender: Any) {
        self.btnEmiratesBack.setBackgroundImage(nil, for: .normal)
        self.btnEmiratesBackCross.isHidden = true

    }
    
    @IBAction func btnDriversFrontCrossTapped(_ sender: Any) {
        self.btnDriversFront.setBackgroundImage(nil, for: .normal)
        self.btnDriversFrontCross.isHidden = true
    }
    
    @IBAction func btnDriversBackCrossTapped(_ sender: Any) {
        self.btnDriversBack.setBackgroundImage(nil, for: .normal)
        self.btnDriversBackCross.isHidden = true
    }
    
}
