//
//  RegisterApprovedMemberViewController.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 30/09/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit

class RegisterApprovedMemberViewController: UIViewController {
    
    /*
     MARK: - Properties
     */
    @IBOutlet var btnBack             : UIButton!
    @IBOutlet var btnNext             : UIButton!
    @IBOutlet var btnShowHidePassword : UIButton!
    @IBOutlet var txtFullName         : UITextField!
    @IBOutlet var txtEmail            : UITextField!
    @IBOutlet var txtPhone            : UITextField!
    @IBOutlet var txtPassword         : UITextField!
    @IBOutlet var btnPhoneInfo        : UIButton!
    var phone                         : String        = ""
    var userModel                     : ApprovedUsersList!
    var userId                        : String        = ""
    var isShowPassword                : Bool          = false
    
    //end
    
    
    /*
     MARK: - UIViewController Life Cycle
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.callGetUserAPI()
        // Do any additional setup after loading the view.
    }
    //end
    
    /*
     MARK: - Set Up View
     */
    func setup(){
        self.txtPassword.setRightPaddingPoints(20)
    }
    //end
    
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
        else if(self.txtPassword.text == ""){
            error = (false, "Please enter password")
        }
        else if(self.txtPassword.text!.count < 5){
            error = (false, "Please enter valid password")
        }
//        else if (self.txtPhone.text == ""){
//            error = (false, "Please enter valid phone number")
//        }
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
    
    @IBAction func btnNextTapped(_ sender: Any) {
        let (isValidate, errorMessage) = self.getValidate()
        if isValidate{
            if self.txtPhone.text != ""{
                self.phone = String(format: "%@", self.txtPhone.text!)
            }else{
                self.phone = ""
            }
            self.callUpdateUserDetailAPI(userId: self.userId)
        }else{
            AlertViewController.openAlertView(title: "Error", message: errorMessage, buttons: ["OK"])
        }
    }
    
    @IBAction func btnShowHideTapped(_ sender: Any) {
        if self.isShowPassword{
            self.isShowPassword = false
            self.txtPassword.isSecureTextEntry = true
            self.btnShowHidePassword.setImage(UIImage(named: "ic_Eye"), for: .normal)
        }else{
            self.isShowPassword = true
            self.txtPassword.isSecureTextEntry = false
            self.btnShowHidePassword.setImage(UIImage(named: "ic_Eye_Cross"), for: .normal)
        }
    }
    
    @IBAction func btnPhoneInfoTapped(_ sender: Any){
        AlertViewController.openAlertView(title: "Phone Number", message: "Providing a phone number is not mandatory, however, it will reduce the time taken for us to verify and approve your application.", buttons: ["OK"])
    }
}

extension RegisterApprovedMemberViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let newLength = (textField.text?.count)! + string.count - range.length
        if textField == self.txtPhone{
            let allowedCharactersWithPlus = "+0123456789"
            let allowedCharactersWithoutPlus = "0123456789"
            var allowedCharacterSet = CharacterSet()
            if newLength > 1{
                allowedCharacterSet = CharacterSet(charactersIn: allowedCharactersWithoutPlus)
            }else{
                allowedCharacterSet = CharacterSet(charactersIn: allowedCharactersWithPlus)
               
            }
            let typedCharacterSet = CharacterSet(charactersIn: string)
            let alphabet = allowedCharacterSet.isSuperset(of: typedCharacterSet)
            if alphabet == false{
                return false
            }else{
                return true
            }
        }
        return true
    }
}
