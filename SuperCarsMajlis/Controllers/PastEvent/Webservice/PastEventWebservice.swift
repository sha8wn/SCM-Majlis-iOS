//
//  PastEventWebservice.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 11/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import Foundation

/*
 MARK: - Webservice Calls
 */
extension PastEventViewController{
    
    func getPastEventAPI(page: Int){
        FunctionConstants.getInstance().showLoader(message: "Loading", view: self)
        let urlPath = kBaseURL + kPastEventListAPI + "?n=" + "\(page)" + "&limit=10"
        Network.shared.request(urlPath: urlPath, methods: .get, authType: .basic) { (response, message, statusCode, status) in
            FunctionConstants.getInstance().hideLoader(view: self)
            if status == .Success{
                do {
                    let responseModel = try JSONDecoder().decode(PastEventListModel.self, from: response?.data ?? Data())
                    if let pastEvent = responseModel.past_events{
                        if let list = pastEvent.list{
                            if list.count > 0{
                                self.lbl_NoData.isHidden = true
                                if let count = pastEvent.num_rows{
                                    self.totalRecord = Int(count) ?? 0
                                }else{
                                    self.totalRecord = 0
                                }
                                self.dataArray = self.dataArray + list
                                self.tableView.reloadData()
                            }else{
                                self.lbl_NoData.isHidden = false
                            }
                        }else{
                            self.lbl_NoData.isHidden = false
                        }
                    }else{
                        self.lbl_NoData.isHidden = false
                    }
                } catch let error {
                    AlertViewController.openAlertView(title: "Error", message: error.localizedDescription, buttons: ["OK"])
                }
            }else{
                AlertViewController.openAlertView(title: "Error", message: message ?? "Something Went Wrong!, Try Again Later.", buttons: ["OK"])
            }
            
        }
    }
}
