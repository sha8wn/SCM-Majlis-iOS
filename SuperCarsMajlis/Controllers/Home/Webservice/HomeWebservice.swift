//
//  HomeWebservice.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 23/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import Foundation
import UIKit

extension HomeViewController{
    
    func callGetEventListAPi(page: Int){
        FunctionConstants.getInstance().showLoader(message: "Loading", view: self)
        let urlPath = kBaseURL + kEventListAPI + "?n=" + "\(page)" + "&limit=10&type=1" 
        
        Network.shared.request(urlPath: urlPath, methods: .get, authType: .auth) { (response, message, statusCode, status) in
            FunctionConstants.getInstance().hideLoader(view: self)
            if status == .Success{
                do {
                    let responseModel = try JSONDecoder().decode(HomeModel.self, from: response?.data ?? Data())
                    
                    if let event = responseModel.events{
                        if let list = event.list{
                            if list.count > 0{
                                self.lbl_NoData.isHidden = true
                                if let count = event.num_rows{
                                    self.totalRecord = Int(count)
                                }else{
                                    self.totalRecord = 0
                                }
                                self.dataArray = self.dataArray + list
                                
                                var type: HomeType = .pastEvent
                                if self.dataArray.count > 0{
                                    for i in 0..<self.dataArray.count{
                                        let model = self.dataArray[i]
                                        if model.reservation ?? 0 > 0 && (model.status ?? "").lowercased() == "live"{
                                            type = .checkIn
                                            break
                                        }
                                    }
                                }
                                
                                self.lblHeaderSideTitle.text = "PAST EVENTS"
                                self.imgHeaderSideTitle.image = UIImage(named: "ic_PastEvent")
                                
//                                if type == .pastEvent{
//                                    //Past event
//                                    self.lblHeaderSideTitle.text = "PAST EVENTS"
//                                    self.imgHeaderSideTitle.image = UIImage(named: "ic_PastEvent")
//                                }else{
//                                    //Check In
//                                    self.lblHeaderSideTitle.text = "CHECK IN"
//                                    self.imgHeaderSideTitle.image = UIImage(named: "ic_Check-In")
//                                }
                            }else{
                                self.dataArray = []
                                self.lbl_NoData.isHidden = false
                            }
                        }else{
                            self.dataArray = []
                            self.lbl_NoData.isHidden = false
                        }
                    }else{
                        self.dataArray = []
                        self.lbl_NoData.isHidden = false
                    }
                    self.tableView.reloadData()
                } catch let error {
                    AlertViewController.openAlertView(title: "Error", message: error.localizedDescription, buttons: ["OK"])
                }
            }else{
                AlertViewController.openAlertView(title: "Error", message: message ?? "Something Went Wrong!, Try Again Later.", buttons: ["OK"])
            }
        }
    }
}
