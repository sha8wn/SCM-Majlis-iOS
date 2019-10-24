//
//  ProfileWebservice.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 17/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import Foundation

extension ProfileViewController{
    func callUpdateUserDetailAPI(userId: String, image: String){
        FunctionConstants.getInstance().showLoader(message: "Loading", view: self)
        let urlPath = kBaseURL + kGetUserAPI + userId
        
        let requestDict = ["name"      : self.txtFullName.text!,
                           "email"     : self.txtEmail.text!,
                           "phone"     : String(format: "00971%@", self.txtPhone.text!),
                           "img_add"   : image
            ] as [String : Any]
        
        Network.shared.request(urlPath: urlPath, methods: .put, authType: .auth, params: requestDict as [String : AnyObject]) { (response, message, statusCode, status) in
            FunctionConstants.getInstance().hideLoader(view: self)
            if status == .Success{
                AlertViewController.openAlertView(title: "Success", message: "Profile Updated Successfully!", buttons: ["OK"]) { (index) in
                    self.navigationController?.popViewController(animated: true)
                }
            }else{
                AlertViewController.openAlertView(title: "Error", message: message!, buttons: ["OK"])
            }
        }
    }
}

