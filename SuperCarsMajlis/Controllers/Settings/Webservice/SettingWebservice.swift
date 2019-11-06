//
//  SettingWebservice.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 17/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import Foundation

extension SettingsViewController{
    
    func callGetUserDetailAPI(){
        FunctionConstants.getInstance().showLoader(message: "Loading", view: self)
        let urlPath = kBaseURL + kGetUserAPI
        
        Network.shared.request(urlPath: urlPath, methods: .get, authType: .auth) { (response, message, statusCode, status) in
            FunctionConstants.getInstance().hideLoader(view: self)
            if status == .Success{
                do {
                    let responseModel = try JSONDecoder().decode(ApprovedMemberDetailModel.self, from: response?.data ?? Data())
                    if let userDetails = responseModel.users{
                        if let list = userDetails.list{
                            if list.count > 0{
                                self.userModel = list[0]
                                self.lblUserName.text = list[0].name ?? ""
                                self.lblUserId.text = "SCM00" + "\(list[0].id ?? 0)"
                                let expiry =  list[0].expiry ?? ""
                                let registration = list[0].created ?? ""
                                let startDate = registration.toDate()
                                let expirtDate = expiry.toDate(withFormat: "yyyy-MM-dd")
                                let strStartDate = convertDateFormater(date: startDate ?? Date(), format: "MMM dd, YYYY")
                                if expiry.contains("000"){
                                    self.lblDuration.text = "Member since " + strStartDate
                                }else{
                                    let strExpiryDate = convertDateFormater(date: expirtDate ?? Date(), format: "MMM dd, YYYY")
                                    self.lblDuration.text = strStartDate + " - " + strExpiryDate
                                }
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
}

extension String{
    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss")-> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }
}


func convertDateFormater(date: Date, format: String? = "yyyy-MM-dd") -> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    let date = dateFormatter.string(from: date)
    return date
}
