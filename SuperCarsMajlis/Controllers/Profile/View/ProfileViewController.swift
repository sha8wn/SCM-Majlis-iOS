//
//  ProfileViewController.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 09/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit
import SDWebImage

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
    @IBOutlet var txtPhone      : UITextField!
    var model                   : ApprovedUsersList!
    var phone                   : String                = ""
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
        
        //Data
        self.txtFullName.text = self.model.name ?? ""
        self.txtEmail.text = self.model.email ?? ""
        let phone = self.model.phone ?? ""
//        self.txtPhone.text = String(phone.dropFirst(5))
        self.txtPhone.text = phone
        
        self.btnProfilePic.sd_imageIndicator = SDWebImageActivityIndicator.white
        self.btnProfilePic.sd_setBackgroundImage(with: URL(string: self.model.img ?? ""), for: .normal, completed: nil)
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
    
    @IBAction func btnProfilePicTapped(_ sender: Any) {
        ImagePicker.openImagePicker { (image) in
            self.btnProfilePic.setBackgroundImage(image, for: .normal)
        }
    }
    
    @IBAction func btnSumbitTapped(_ sender: Any) {
        let (isValidate, errorMessage) = self.getValidate()
        if isValidate{
            var pic: String = ""
            if let profilePic = self.btnProfilePic.backgroundImage(for: .normal){
                let profilePicData: Data =  profilePic.jpegData(compressionQuality: 0.25)!
                pic = profilePicData.base64EncodedString()
            }
            if self.txtPhone.text != ""{
                self.phone = String(format: "%@", self.txtPhone.text!)
            }else{
                self.phone = ""
            }
            self.callUpdateUserDetailAPI(userId: "\(self.model.id!)" , image: pic)
        }else{
            AlertViewController.openAlertView(title: "Error", message: errorMessage, buttons: ["OK"])
        }
    }
}

extension ProfileViewController: UITextFieldDelegate{
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
