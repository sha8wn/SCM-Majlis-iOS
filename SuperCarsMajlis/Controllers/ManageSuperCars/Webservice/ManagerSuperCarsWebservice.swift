//
//  ManagerSuperCarsWebservice.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 21/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import Foundation

extension ManagerSuperCarsViewController{
    
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
                            for modelData in list{
                                var superCars = SupercarsModel()
                                superCars.car_Id = "\(modelData.id ?? 0)"
                                superCars.brand = modelData.brand_name ?? ""
                                superCars.brand_Id = modelData.brand ?? 0
                                superCars.model = modelData.model_name ?? ""
                                superCars.model_Id = modelData.model ?? 0
                                superCars.color = modelData.color_name ?? ""
                                superCars.color_Id = modelData.color ?? 0
                                superCars.isCarImageEdit = false
                                superCars.isCarRegistraionBackImageEdit = false
                                superCars.isCarRegistraionFrontImageEdit = false
                                if let imageArray = modelData.imgs{
                                    if imageArray.count > 0{
                                        superCars.carImageURL = imageArray[0].img ?? ""
                                        superCars.carImage_Id = "\(imageArray[0].n!)"
                                    }else{
                                        
                                    }
                                }else{
                                    
                                }
                                if let docsArray = modelData.docs{
                                    if docsArray.count > 0{
                                        superCars.carRegistraionFrontImageURL = docsArray[0].img ?? ""
                                        superCars.carRegistraionFront_Id = "\(docsArray[0].n!)"
                                        if docsArray.count > 1{
                                            superCars.carRegistraionBackImageURL = docsArray[1].img ?? ""
                                            superCars.carRegistraionBack_Id = "\(docsArray[1].n!)"
                                        }
                                    }else{
                                        
                                    }
                                }else{
                                    
                                }
                                self.dataArray.append(superCars)
                            }
                            self.tableView.reloadData()
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
    
    func callUpdateSuperCarsAPI(car_Id: String, brand_Id: Int, model_Id: Int, color_Id: Int, imageArray: [Any], docsArray: [Any], deletedImageArray: [Any], deletedDocArray: [Any]){
        
        self.dispatchGroup.enter()
        
        FunctionConstants.getInstance().showLoader(message: "Loading", view: self)
        let urlPath = kBaseURL + kGetCarsAPI + car_Id
        
        let requestDict = ["brand"     : brand_Id,
                           "model"     : model_Id,
                           "color"     : color_Id,
                           "imgs_add"  : imageArray,
                           "docs_add"  : docsArray,
                           "imgs_del"  : deletedImageArray,
                           "docs_del"  : deletedDocArray
            ] as [String : Any]
        
        Network.shared.request(urlPath: urlPath, methods: .put, authType: .auth, params: requestDict as [String : AnyObject]) { (response, message, statusCode, status) in
            FunctionConstants.getInstance().hideLoader(view: self)
            if status == .Success{
                self.dispatchGroup.leave()
            }else{
                AlertViewController.openAlertView(title: "Error", message: message!, buttons: ["OK"])
            }
        }
        
    }
    
    func callAddSuperCarsAPI(brand_Id: Int, model_Id: Int, color_Id: Int, imageArray: [Any], docsArray: [Any]){
        
        self.dispatchGroup.enter()
        
        FunctionConstants.getInstance().showLoader(message: "Loading", view: self)
        let urlPath = kBaseURL + kGetCarsAPI
        
        let requestDict = ["brand"     : brand_Id,
                           "model"     : model_Id,
                           "color"     : color_Id,
                           "imgs_add"  : imageArray,
                           "docs_add"  : docsArray
            ] as [String : Any]
        
        Network.shared.request(urlPath: urlPath, methods: .post, authType: .auth, params: requestDict as [String : AnyObject]) { (response, message, statusCode, status) in
            FunctionConstants.getInstance().hideLoader(view: self)
            if status == .Success{
                self.dispatchGroup.leave()
            }else{
                AlertViewController.openAlertView(title: "Error", message: message!, buttons: ["OK"])
            }
        }
    }
    
    func callDeleteSupercarAPI(carId: String){
        FunctionConstants.getInstance().showLoader(message: "Loading", view: self)
        let urlPath = kBaseURL + kGetCarsAPI + "\(carId)"
        
        Network.shared.request(urlPath: urlPath, methods: .delete, authType: .auth) { (response, message, statusCode, status) in
            FunctionConstants.getInstance().hideLoader(view: self)
            if status == .Success{
                AlertViewController.openAlertView(title: "Success", message: "Supercar has been successfully removed", buttons: ["Ok"]) { (index) in
                    self.callGetSuperCarsListAPI()
                }
            }else{
                AlertViewController.openAlertView(title: "Error", message: message!, buttons: ["OK"])
            }
        }
    }
}
