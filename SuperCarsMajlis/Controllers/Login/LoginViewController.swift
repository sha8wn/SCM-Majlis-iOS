//
//  LoginViewController.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 29/09/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    /*
     MARK: - Properties
     */
    @IBOutlet var btnBack               : UIButton!
    @IBOutlet var btnLogin              : UIButton!
    @IBOutlet var btnForgot             : UIButton!
    @IBOutlet var btnShowHidePassword   : UIButton!
    @IBOutlet var txtEmail              : UITextField!
    @IBOutlet var txtPassword           : UITextField!
    var isShowPassword                  : Bool          = false
    //end
    
    /*
    MARK: - UIViewController Life Cycle
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        // Do any additional setup after loading the view.
    }
    //end
    
    /*
     MARK: - Set Up View
     */
    func setup(){
        self.txtPassword.setRightPaddingPoints(30)
    }
    //end
    
    //MARK: - Validate Form
    private func getValidate() -> (Bool, String){
        var error : (Bool, String) = (false, "")
        if(self.txtEmail.text == ""){
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
    
    @IBAction func btnLoginTapped(_ sender: Any) {

        let vc = Constants.homeStoryboard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
//        let (isValidate, errorMessage) = self.getValidate()
//        if isValidate{
//            let vc = Constants.homeStoryboard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
//            self.navigationController?.pushViewController(vc, animated: true)
//        }else{
//            AlertViewController.openAlertView(title: "Error", message: errorMessage, buttons: ["OK"])
//        }
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
    
    @IBAction func btnForgotPasswordTapped(_ sender: Any) {
        let viewController = Constants.loginAndSignupStoryboard.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        self.navigationController?.pushViewController( viewController, animated: true)
    }
    
}
