//
//  RegisterWebservice.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 11/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import Foundation

/*
 MARK: - Webservice Calls
 */
extension RegisterViewController{
    
    func callRegisterAPi(){
        FunctionConstants.getInstance().showLoader(message: "Loading", view: self)
        let urlPath = kBaseURL + kUserRegisterAPI
        
        let requestDict = ["name"      : self.txtFullName.text!,
                           "email"     : self.txtEmail.text!,
                           "phone"     : self.phone,
                           "uid"       : "\(Constants.kAppDelegate.kdeviceFCMToken!)",
        ] as [String : Any]

        Network.shared.request(urlPath: urlPath, methods: .post, authType: .basic, params: requestDict as [String : AnyObject]) { (response, message, statusCode, status) in
            FunctionConstants.getInstance().hideLoader(view: self)
            if status == .Success{
                do {
                    let responseModel = try JSONDecoder().decode(RegisterModel.self, from: response?.data ?? Data())
                    setAccessTokenModel(model: responseModel)
                    setUserState(state: .pastEvent)
                    let vc = Constants.registerStoryboard.instantiateViewController(withIdentifier: "ApprovedMemberSupercarsViewController") as! ApprovedMemberSupercarsViewController
                    vc.isOpenFrom = .partiallyRegister
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
