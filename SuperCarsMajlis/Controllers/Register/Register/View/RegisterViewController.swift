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
    @IBOutlet var btnModel      : UIButton!
    @IBOutlet var btnBrand      : UIButton!
    @IBOutlet var txtFullName   : UITextField!
    @IBOutlet var txtEmail      : UITextField!
    @IBOutlet var txtCountryCode: UITextField!
    @IBOutlet var txtPhone      : UITextField!
    @IBOutlet var txtBrand      : UITextField!
    @IBOutlet var txtModel      : UITextField!
    var selectedBrandId         : String        = ""
    var selectedModelId         : String        = ""
    //end
    
    
    /*
     MARK: - UIViewController Life Cycle
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        // Do any additional setup after loading the view.
    }
    
    /*
     MARK: - Set Up View
     */
    func setup(){
        self.txtBrand.setRightPaddingPoints(20)
        self.txtModel.setRightPaddingPoints(20)
        self.txtBrand.isUserInteractionEnabled = false
        self.txtModel.isUserInteractionEnabled = false
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
        else if(self.txtPhone.text == ""){
            error = (false, "Please enter phone number")
        }
        else if(self.txtPhone.text!.count < 7) || (self.txtPhone.text!.count > 12){
            error = (false, "Please enter valid phone number")
        }
        else if(self.txtBrand.text == ""){
            error = (false, "Please select brand")
        }
        else if(self.txtModel.text == ""){
            error = (false, "Please select model")
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
    
    @IBAction func btnModelTapped(_ sender: Any) {
        self.view.endEditing(true)
        if self.selectedBrandId == ""{
            AlertViewController.openAlertView(title: "Error", message: "Please select Brand!", buttons: ["OK"])
        }else{
            PickerViewController.openPickerView(type: .model, title: "Model", lastSelectedValue: self.txtModel.text!, lastSelectedIndex: self.selectedBrandId) { (value, index) in
                self.txtModel.text = value
                self.selectedModelId = String(index!)
            }
        }
    }
    
    @IBAction func btnBrandTapped(_ sender: Any) {
        self.view.endEditing(true)
        PickerViewController.openPickerView(type: .brand, title: "Brand", lastSelectedValue: self.txtBrand.text!) { (value, index) in
            self.txtBrand.text = value
            self.selectedBrandId = "\(String(describing: index!))"
            self.txtModel.text = ""
        }
    }
    
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
