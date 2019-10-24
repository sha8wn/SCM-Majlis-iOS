//
//  LoginWebservice.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 17/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import Foundation

extension LoginViewController{
    func callLoginAPI(){
        FunctionConstants.getInstance().showLoader(message: "Loading", view: self)
        let urlPath = kBaseURL + kLoginAPI
        
        let requestDict = ["email"     : self.txtEmail.text!,
                           "password"  : self.txtPassword.text!,
                           "uid"       : "q213"
            ] as [String : Any]
        
        Network.shared.request(urlPath: urlPath, methods: .post, authType: .basic, params: requestDict as [String : AnyObject]) { (response, message, statusCode, status) in
            FunctionConstants.getInstance().hideLoader(view: self)
            if status == .Success{
                do {
                    let responseModel = try JSONDecoder().decode(RegisterModel.self, from: response?.data ?? Data())
                    setAccessTokenModel(model: responseModel)
                    setUserState(state: .home)
                    let vc = Constants.homeStoryboard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
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
