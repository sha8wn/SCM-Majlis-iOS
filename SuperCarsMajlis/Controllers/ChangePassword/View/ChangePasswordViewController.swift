//
//  ChangePasswordViewController.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 09/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    /*
     MARK: - Properties
    */
    @IBOutlet weak var btnSave              : UIButton!
    @IBOutlet weak var btnBack              : UIButton!
    @IBOutlet var btnShowHideCPassword      : UIButton!
    @IBOutlet var btnShowHideNPassword      : UIButton!
    @IBOutlet var btnShowHideRNPassword     : UIButton!
    @IBOutlet weak var txtCurrentPassword   : UITextField!
    @IBOutlet weak var txtNewPassword       : UITextField!
    @IBOutlet weak var txtReNewPassword     : UITextField!
    var isShowPasswordCP                    : Bool          = false
    var isShowPasswordNP                    : Bool          = false
    var isShowPasswordRNP                   : Bool          = false
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
        self.txtCurrentPassword.setRightPaddingPoints(30)
        self.txtNewPassword.setRightPaddingPoints(30)
        self.txtReNewPassword.setRightPaddingPoints(30)
    }
    //end

    //MARK: - Validate Form
    private func getValidate() -> (Bool, String){
        var error : (Bool, String) = (false, "")
        if(self.txtCurrentPassword.text == ""){
            error = (false, "Please enter current password.")
        }else if(self.txtCurrentPassword.text!.count < 6){
            error = (false, "Password should be atleast 6 digits.")
        }else if(self.txtNewPassword.text == ""){
            error = (false, "Please enter new password")
        }else if(self.txtReNewPassword.text!.count < 6){
            error = (false, "Password should be atleast 6 digits.")
        }else if(self.txtReNewPassword.text == ""){
            error = (false, "Please enter repeat password")
        }else if(self.txtCurrentPassword.text!.count < 6){
            error = (false, "Password should be atleast 6 digits.")
        }else if (self.txtNewPassword.text != self.txtReNewPassword.text){
            error = (false, "New Password and Repeat New Password should be same")
        }else{
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

    @IBAction func btnShowHideCPasswordTapped(_ sender: Any) {
        if self.isShowPasswordNP{
            self.isShowPasswordNP = false
            self.txtCurrentPassword.isSecureTextEntry = true
            self.btnShowHideCPassword.setImage(UIImage(named: "ic_Eye"), for: .normal)
        }else{
            self.isShowPasswordNP = true
            self.txtCurrentPassword.isSecureTextEntry = false
            self.btnShowHideCPassword.setImage(UIImage(named: "ic_Eye_Cross"), for: .normal)
        }
    }
    
    @IBAction func btnShowHideNPasswordTapped(_ sender: Any) {
        if self.isShowPasswordNP{
            self.isShowPasswordNP = false
            self.txtNewPassword.isSecureTextEntry = true
            self.btnShowHideNPassword.setImage(UIImage(named: "ic_Eye"), for: .normal)
        }else{
            self.isShowPasswordNP = true
            self.txtNewPassword.isSecureTextEntry = false
            self.btnShowHideNPassword.setImage(UIImage(named: "ic_Eye_Cross"), for: .normal)
        }
    }
    
    @IBAction func btnShowHideRNPasswordTapped(_ sender: Any) {
        if self.isShowPasswordRNP{
            self.isShowPasswordRNP = false
            self.txtReNewPassword.isSecureTextEntry = true
            self.btnShowHideRNPassword.setImage(UIImage(named: "ic_Eye"), for: .normal)
        }else{
            self.isShowPasswordRNP = true
            self.txtReNewPassword.isSecureTextEntry = false
            self.btnShowHideRNPassword.setImage(UIImage(named: "ic_Eye_Cross"), for: .normal)
        }
    }
    
    @IBAction func btnSumbitTapped(_ sender: Any) {
        let (isValidate, errorMessage) = self.getValidate()
        if isValidate{
            self.callChangePasswordAPI()
        }else{
            AlertViewController.openAlertView(title: "Error", message: errorMessage, buttons: ["OK"])
        }
    }
}
