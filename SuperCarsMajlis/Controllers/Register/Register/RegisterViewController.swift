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
        else if(self.txtPhone.text!.count < 10){
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
        PickerViewController.openPickerView(dataArray: ["1", "2", "3", "4", "5", "6", "7"], title: "Model", lastSelectedValue: self.txtModel.text!) { (value, index) in
            print(value)
            self.txtModel.text = value
        }
    }
    
    @IBAction func btnBrandTapped(_ sender: Any) {
        self.view.endEditing(true)
        PickerViewController.openPickerView(dataArray: ["1", "2", "3", "4", "5", "6", "7"], title: "Brand", lastSelectedValue: self.txtBrand.text!) { (value, index) in
            print(value)
            self.txtBrand.text = value
        }
        
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSumbitTapped(_ sender: Any) {
        let vc = Constants.registerStoryboard.instantiateViewController(withIdentifier: "RegisterApprovedMemberViewController") as! RegisterApprovedMemberViewController
        self.navigationController?.pushViewController(vc, animated: true)
//        let (isValidate, errorMessage) = self.getValidate()
//        if isValidate{
//            let vc = Constants.registerStoryboard.instantiateViewController(withIdentifier: "RegisterApprovedMemberViewController") as! RegisterApprovedMemberViewController
//            self.navigationController?.pushViewController(vc, animated: true)
//        }else{
//            AlertViewController.openAlertView(title: "Error", message: errorMessage, buttons: ["OK"])
//        }
    }
    
}

/*
MARK: - UITextFieldDelegate
*/
extension RegisterViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {

    }
}
