//
//  EventRegistrationWebservice.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 25/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import Foundation

extension EventRegistrationViewController{
    
    func callGetSuperCarsListAPI(){
        FunctionConstants.getInstance().showLoader(message: "Loading", view: self)
        let urlPath = kBaseURL + kGetCarsAPI
        
        Network.shared.request(urlPath: urlPath, methods: .get, authType: .auth) { (response, message, statusCode, status) in
            FunctionConstants.getInstance().hideLoader(view: self)
            if status == .Success{
                do {
                    let responseModel = try JSONDecoder().decode(SuperCars_Model.self, from: response?.data ?? Data())
                    if let userDetails = responseModel.cars{
                        if let list = userDetails.list{
                            self.dataArray = []
                            if list.count > 0 {
                                self.selectedIndex = 0
                                self.btnReserve.isEnabled = true
                                for modelData in list{
                                    var superCars = SupercarsModel()
                                    superCars.car_Id = "\(modelData.id ?? 0)"
                                    superCars.brand = modelData.brand_name ?? ""
                                    superCars.model = modelData.model_name ?? ""
                                    if modelData.model_img ?? "" != ""{
                                        superCars.carImageURL = modelData.model_img ?? ""
                                    }else{
                                        superCars.carImageURL = modelData.brand_img ?? ""
                                    }
                                    self.dataArray.append(superCars)
                                }
                            }
                            self.collectionView.reloadData()
                        }else{}
                    }else{}
                } catch let error {
                    print(error)
                    AlertViewController.openAlertView(title: "Error", message: error.localizedDescription, buttons: ["OK"])
                }
            }else{
                AlertViewController.openAlertView(title: "Error", message: message!, buttons: ["OK"])
            }
        }
    }
    
    
    func  callEventRegisterAPI(car_Id: Int, event_Id: Int, guest: Int){
        FunctionConstants.getInstance().showLoader(message: "Loading", view: self)
        let urlPath = kBaseURL + kEventRegisterAPI
        
        let requestDict = ["car"     : car_Id,
                           "event"   : event_Id,
                           "guests"  : guest
            ] as [String : Any]
        
        Network.shared.request(urlPath: urlPath, methods: .post, authType: .auth, params: requestDict as [String : AnyObject]) { (response, message, statusCode, status) in
            FunctionConstants.getInstance().hideLoader(view: self)
            if status == .Success{
                AlertViewController.openAlertView(title: "Success", message: String(format: "You have successfully registered for %@.", self.eventName), buttons: ["Ok"]) { (index) in
                    self.navigationController?.popViewController(animated: true)
                }
            }else{
                AlertViewController.openAlertView(title: "Error", message: message!, buttons: ["OK"])
            }
        }
    }
}
