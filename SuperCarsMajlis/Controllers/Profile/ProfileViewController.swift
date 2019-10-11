//
//  ProfileViewController.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 09/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    /*
     MARK: - Properties
     */
    @IBOutlet weak var picBGView: UIView!
    @IBOutlet var btnBack       : UIButton!
    @IBOutlet var btnSubmit     : UIButton!
    @IBOutlet var btnProfilePic : UIButton!
    @IBOutlet var txtFullName   : UITextField!
    @IBOutlet var txtEmail      : UITextField!
    @IBOutlet var txtCountryCode: UITextField!
    @IBOutlet var txtPhone      : UITextField!
    //end
    
    /*
     MARK: - UIViewController Life Cycle
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        // Do any additional setup after loading the view.
    }
    //end
    
    /*
     MARK: - Set Up View
    */
    func setUpView(){
        //Backgroung Color
        self.picBGView.backgroundColor = UIColor.gradient(from: UIColor(red:56.0/255.0, green:56.0/255.0 ,blue:67.0/255.0 , alpha:1.0), to: UIColor(red:39.0/255.0, green:39.0/255.0 ,blue:47.0/255.0 , alpha:1.0), withHeight: Int(self.picBGView.frame.height))
    }
    //end
    
    /*
     MARK: - Validate Form
     */
    private func getValidate() -> (Bool, String){
        var error : (Bool, String) = (false, "")
        if(self.txtFullName.text == ""){
            error = (false, "Please enter full name")
        }
        else if(self.txtEmail.text == ""){
            error = (false, "Please enter email address")
        }
        else if(FunctionConstants.getInstance().isValidEmail(email: self.txtEmail.text ?? "") == false){
            error = (false, "Please enter valid email address")
        }
        else if(self.txtPhone.text == ""){
            error = (false, "Please enter phone number")
        }
        else if(self.txtPhone.text!.count < 10){
            error = (false, "Please enter valid phone number")
        }
        else{
            error = (true, "")
        }
        return error
    }
    
    
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
    
    @IBAction func btnProfilePicTapped(_ sender: Any) {
        ImagePicker.openImagePicker { (image) in
            self.btnProfilePic.setBackgroundImage(image, for: .normal)
        }
    }
    
    @IBAction func btnSumbitTapped(_ sender: Any) {
        let (isValidate, errorMessage) = self.getValidate()
        if isValidate{
            AlertViewController.openAlertView(title: "Success", message: "Profile Updated Successfully!", buttons: ["OK"])
        }else{
            AlertViewController.openAlertView(title: "Error", message: errorMessage, buttons: ["OK"])
        }
    }
}
