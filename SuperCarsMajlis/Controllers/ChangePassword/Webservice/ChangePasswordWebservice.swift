//
//  ChangePasswordWebservice.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 17/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import Foundation

extension ChangePasswordViewController{
    
    func callChangePasswordAPI(){
        FunctionConstants.getInstance().showLoader(message: "Loading", view: self)
        let urlPath = kBaseURL + kChangePasswordAPI
        
        let requestDict = ["password"      : self.txtNewPassword.text!
            ] as [String : Any]
        
        Network.shared.request(urlPath: urlPath, methods: .post, authType: .auth, params: requestDict as [String : AnyObject]) { (response, message, statusCode, status) in
            FunctionConstants.getInstance().hideLoader(view: self)
            if status == .Success{
                var accessTokenModel: RegisterModel!
                if getAccessTokenModel() != nil{
                    accessTokenModel = getAccessTokenModel()
                }
                if let resJson = response?.result.value as? NSDictionary{
                    let token = resJson.value(forKey: "token") as! String
                    accessTokenModel.token = token
                    setAccessTokenModel(model: accessTokenModel)
                }
                AlertViewController.openAlertView(title: "Success", message: "Password Updated Successfully!", buttons: ["OK"]) { (index) in
                    self.navigationController?.popViewController(animated: true)
                }
            }else{
                AlertViewController.openAlertView(title: "Error", message: message!, buttons: ["OK"])
            }
        }
    }
    
    
}
