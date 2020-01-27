//
//  RegisterApprovedMemberWebservice.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 16/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import Foundation

/*
 MARK: - Webservice Calls
 */
extension RegisterApprovedMemberViewController{
    
    func callGetUserAPI(){
        FunctionConstants.getInstance().showLoader(message: "Loading", view: self)
        
        let urlPath = kBaseURL + kGetUserAPI + self.userId
        
        Network.shared.request(urlPath: urlPath, methods: .get, authType: .auth) { (response, message, statusCode, status) in
            FunctionConstants.getInstance().hideLoader(view: self)
            if status == .Success{
                do {
                    let responseModel = try JSONDecoder().decode(ApprovedMemberDetailModel.self, from: response?.data ?? Data())
                    if let userDetails = responseModel.users{
                        if let list = userDetails.list{
                            if list.count > 0{
                                self.userModel = list[0]
                                self.txtFullName.text = list[0].name ?? ""
                                self.txtEmail.text = list[0].email ?? ""
                                let phone = list[0].phone ?? ""
//                                self.txtPhone.text = String(phone.dropFirst(5))
                                self.txtPhone.text = phone
                                self.userId = "\(list[0].id ?? 0)"
                            }else{}
                        }else{}
                    }else{}
                } catch let error {
                    AlertViewController.openAlertView(title: "Error", message: error.localizedDescription, buttons: ["OK"])
                }
            }else{
                AlertViewController.openAlertView(title: "Error", message: message!, buttons: ["OK"])
            }
        }
    }
    
    func callUpdateUserDetailAPI(userId: String){
        FunctionConstants.getInstance().showLoader(message: "Loading", view: self)
        let urlPath = kBaseURL + kGetUserAPI + userId
        
        let requestDict = ["name"      : self.txtFullName.text!,
                           "email"     : self.txtEmail.text!,
                           "phone"     : self.phone,
                           "password"  : self.txtPassword.text!
            ] as [String : Any]
        
        Network.shared.request(urlPath: urlPath, methods: .put, authType: .auth, params: requestDict as [String : AnyObject]) { (response, message, statusCode, status) in
            FunctionConstants.getInstance().hideLoader(view: self)
            if status == .Success{
                do {
                    let responseModel = try JSONDecoder().decode(RegisterModel.self, from: response?.data ?? Data())
                    setAccessTokenModel(model: responseModel)
                    
                    let vc = Constants.registerStoryboard.instantiateViewController(withIdentifier: "ApprovedMemberSupercarsViewController") as! ApprovedMemberSupercarsViewController
                    vc.userModel = self.userModel
                    vc.isOpenFrom = .approvedRegister
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                } catch let error {
                    AlertViewController.openAlertView(title: "Error", message: error.localizedDescription, buttons: ["OK"])
                }
            }else{
                AlertViewController.openAlertView(title: "Error", message: message!, buttons: ["OK"])
            }
        }
    }
}
