//
//  FeedbackWebservice.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 10/12/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import Foundation

extension FeedbackViewController{
    
    func callFeedbackAPI(subject: String, message: String){
        FunctionConstants.getInstance().showLoader(message: "Loading", view: self)
        let urlPath = kBaseURL + kFeedbackAPI
        
        let requestDict = ["text"      : message,
                           "subject"   : subject
            ] as [String : Any]
        
        print(requestDict)
        
        Network.shared.request(urlPath: urlPath, methods: .post, authType: .auth, params: requestDict as [String : AnyObject]) { (response, message, statusCode, status) in
            FunctionConstants.getInstance().hideLoader(view: self)
            if status == .Success{
                AlertViewController.openAlertView(title: "Success", message: "Feedback sent successfully.", buttons: ["Ok"]) { (index) in
                    self.navigationController?.popViewController(animated: true)
                }
            }else{
                AlertViewController.openAlertView(title: "Error", message: message ?? "Something Went Wrong!, Try Again Later.", buttons: ["OK"])
            }
        }
    }
}
