//
//  EventDetailWebservice.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 24/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import Foundation

extension EventDetailsViewController{
    
    func callGetEventDetailAPI(event_Id: Int){
        FunctionConstants.getInstance().showLoader(message: "Loading", view: self)
                let urlPath = kBaseURL + kEventListAPI + "?n=" + "\(1)" + "&limit=100" + "&id=" + "\(event_Id)"
                
                Network.shared.request(urlPath: urlPath, methods: .get, authType: .auth) { (response, message, statusCode, status) in
                    FunctionConstants.getInstance().hideLoader(view: self)
                    if status == .Success{
                        do {
                            let responseModel = try JSONDecoder().decode(HomeModel.self, from: response?.data ?? Data())
                            if let event = responseModel.events{
                                if let list = event.list{
                                    if list.count > 0{
                                        self.dataModel = list[0]
                                    }
                                }
                            }
                            self.setUpViewWithData()
                            self.callGetCheckPointAPI(event_Id: self.eventId)
                        } catch let error {
                            AlertViewController.openAlertView(title: "Error", message: error.localizedDescription, buttons: ["OK"])
                        }
                    }else{
                        AlertViewController.openAlertView(title: "Error", message: message ?? "Something Went Wrong!, Try Again Later.", buttons: ["OK"])
                    }
                }
    }
    
    func callGetCheckPointAPI(event_Id: Int){
        FunctionConstants.getInstance().showLoader(message: "Loading", view: self)
        let urlPath = kBaseURL + kGetCheckPointAPI + "?n=" + "\(1)" + "&limit=1000" + "&event=" + "\(event_Id)"
        
        Network.shared.request(urlPath: urlPath, methods: .get, authType: .auth) { (response, message, statusCode, status) in
            FunctionConstants.getInstance().hideLoader(view: self)
            if status == .Success{
                do {
                    let responseModel = try JSONDecoder().decode(CheckPointsModel.self, from: response?.data ?? Data())
                    print(responseModel)
                    if let checkPoints = responseModel.checkpoints{
                        if let list = checkPoints.list{
                            if list.count > 0{
                                self.checkPointsArray = list
                            }else{
                                self.checkPointsArray = []
                            }
                        }else{
                            self.checkPointsArray = []
                        }
                    }else{
                        self.checkPointsArray = []
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
    
    func callUnreserveAPI(event_Id: Int){
        FunctionConstants.getInstance().showLoader(message: "Loading", view: self)
        let urlPath = kBaseURL + kEventRegisterAPI
        var accessTokenModel: RegisterModel!
        if getAccessTokenModel() != nil{
            accessTokenModel = getAccessTokenModel()
        }
        let requestDict = ["event"    : event_Id,
                           "user"     : accessTokenModel.user!.id!
                   ] as [String : Any]
        
        Network.shared.request(urlPath: urlPath, methods: .delete, authType: .auth, params: requestDict as [String : AnyObject]) { (response, message, statusCode, status) in
            FunctionConstants.getInstance().hideLoader(view: self)
            if status == .Success{
                AlertViewController.openAlertView(title: "Success", message: "You have cancelled your registration successfully!", buttons: ["Ok"]) { (index) in
                    self.callGetEventDetailAPI(event_Id: self.eventId)
                }
            }else{
                AlertViewController.openAlertView(title: "Error", message: message!, buttons: ["OK"])
            }
        }
    }
    
    func callUpdateCheckPointAPI(checkPoint_Id: Int, lat: String, long: String){
        FunctionConstants.getInstance().showLoader(message: "Loading", view: self)
        let urlPath = kBaseURL + kUpdateCheckPointAPI

        let requestDict = ["checkpoint" : checkPoint_Id,
                           "lat"        : lat,
                           "lng"        : long
                   ] as [String : Any]
        
        Network.shared.request(urlPath: urlPath, methods: .post, authType: .auth, params: requestDict as [String : AnyObject]) { (response, message, statusCode, status) in
            FunctionConstants.getInstance().hideLoader(view: self)
            if status == .Success{
                AlertViewController.openAlertView(title: "Success", message: "You have checked-in successfully!", buttons: ["Ok"]) { (index) in
                    self.callGetEventDetailAPI(event_Id: self.eventId)
                }
            }else{
                AlertViewController.openAlertView(title: "Error", message: message!, buttons: ["OK"])
            }
        }
    }
}
