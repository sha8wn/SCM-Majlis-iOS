//
//  RegisterViewController.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 27/09/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    /*
     MARK: - Properties
     */
    @IBOutlet var btnBack       : UIButton!
    @IBOutlet var btnSubmit     : UIButton!
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
        print(Constants.kAppDelegate.kdeviceFCMToken!)
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - Validate Form
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
        else if(self.txtPhone.text!.count < 7) || (self.txtPhone.text!.count > 12){
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
    
    @IBAction func btnSumbitTapped(_ sender: Any) {
        let (isValidate, errorMessage) = self.getValidate()
        if isValidate{
            self.callRegisterAPi()
        }else{
            AlertViewController.openAlertView(title: "Error", message: errorMessage, buttons: ["OK"])
        }
    }
    
}

/*
MARK: - UITextFieldDelegate
*/
extension RegisterViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {

    }
}
