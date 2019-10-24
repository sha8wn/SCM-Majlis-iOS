//
//  DocumentWebservice.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 17/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import Foundation

extension DocumentViewController{
    func callUpdateDocumentAPI(user_Id: String, licensesArray: [Any], docsArray: [Any], licenseDeleteArray: [Any], docsDeleteArray: [Any]){
        
        FunctionConstants.getInstance().showLoader(message: "Loading", view: self)
        let urlPath = kBaseURL + kGetDocumentAPI + user_Id + "/"
        
        let requestDict = ["docs_add"      : docsArray,
                           "licenses_add"  : licensesArray,
                           "licenses_del"  : licenseDeleteArray,
                           "docs_del"      : docsDeleteArray
            ] as [String : Any]
        
        Network.shared.request(urlPath: urlPath, methods: .put, authType: .auth, params: requestDict as [String : AnyObject]) { (response, message, statusCode, status) in
            FunctionConstants.getInstance().hideLoader(view: self)
            if status == .Success{
                
                if self.openFrom == .register{
                    setUserState(state: .home)
                }
                
                AlertViewController.openAlertView(title: "Sucess", message: "You are now a member of SuperCars Majlis.", buttons: ["Continue"]) { (index) in
                    
                    self.navigationController?.popViewController(animated: true)
                    //let vc = Constants.homeStoryboard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                    //self.navigationController?.pushViewController(vc, animated: true)
                }
                
                //                do {
                //                    let responseModel = try JSONDecoder().decode(SuperCars_Model.self, from: response?.data ?? Data())
                //
                //                    self.dispatchGroup.leave()
                //                } catch let error {
                //                    AlertViewController.openAlertView(title: "Error", message: error.localizedDescription, buttons: ["OK"])
                //                }
            }else{
                AlertViewController.openAlertView(title: "Error", message: message!, buttons: ["OK"])
            }
        }
        
    }
    
}
