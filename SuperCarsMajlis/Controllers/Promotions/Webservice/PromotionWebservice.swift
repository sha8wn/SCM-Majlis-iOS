//
//  PromotionWebservice.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 04/11/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import Foundation
import UIKit

extension PromotionsViewController{
    
    func callGetPromotionListAPI(){
            FunctionConstants.getInstance().showLoader(message: "Loading", view: self)
            let urlPath = kBaseURL + kGetPromotionAPI + "?n=" + "\(1)" + "&limit=1000&type=1"
            
            Network.shared.request(urlPath: urlPath, methods: .get, authType: .auth) { (response, message, statusCode, status) in
                FunctionConstants.getInstance().hideLoader(view: self)
                if status == .Success{
                    do {
                        let responseModel = try JSONDecoder().decode(PromotionsModel.self, from: response?.data ?? Data())
                        
                        if let promotion = responseModel.promotions{
                            if let list = promotion.list{
                                if list.count > 0{
                                    self.lblNoRecord.isHidden = true
                                    self.dataArray = list
                                }else{
                                    self.lblNoRecord.isHidden = false
                                }
                            }else{
                                self.lblNoRecord.isHidden = false
                            }
                        }else{
                            self.lblNoRecord.isHidden = false
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
