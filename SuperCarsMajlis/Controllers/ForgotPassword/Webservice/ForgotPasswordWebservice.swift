//
//  ForgotPasswordWebservice.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 17/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import Foundation

extension ForgotPasswordViewController{
    
    func callForgotPasswordAPI(){
        FunctionConstants.getInstance().showLoader(message: "Loading", view: self)
        let urlPath = kBaseURL + kForgotPasswordAPI
        
        let requestDict = ["email"     : self.txtEmail.text!
            ] as [String : Any]
        
        Network.shared.request(urlPath: urlPath, methods: .post, authType: .basic, params: requestDict as [String : AnyObject]) { (response, message, statusCode, status) in
            FunctionConstants.getInstance().hideLoader(view: self)
            if status == .Success{
                AlertViewController.openAlertView(title: "Success", message: "Reset Password Link send to your email address.", buttons: ["OK"]) { (index) in
                    self.navigationController?.popViewController(animated: true)
                }
            }else{
                AlertViewController.openAlertView(title: "Error", message: message!, buttons: ["OK"])
            }
        }
    }
}
