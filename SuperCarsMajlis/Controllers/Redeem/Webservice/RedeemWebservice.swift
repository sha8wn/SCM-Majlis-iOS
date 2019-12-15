//
//  RedeemWebservice.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 05/11/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit

extension RedeemViewController {
    
    func callRedeemAPI(code: Int, promotionId: Int){
        FunctionConstants.getInstance().showLoader(message: "Loading", view: self)
        let urlPath = kBaseURL + kRedeemAPI
        
        let requestDict = ["code"        : code,
                           "promotion"   : promotionId
            ] as [String : Any]
        
        Network.shared.request(urlPath: urlPath, methods: .post, authType: .auth, params: requestDict as [String : AnyObject]) { (response, message, statusCode, status) in
            FunctionConstants.getInstance().hideLoader(view: self)
            if status == .Success{
                
                //Firebase Analytics
                FirebaseAnalyticsManager.shared.logEvent(eventName: FirebaseEvent.PromotionRedeemedSuccess.rawValue)
                
                AlertViewController.openAlertView(title: "Success", message: "Promotion coupon has be redeemed", buttons: ["Ok"]) { (index) in
                    let navigationController: UINavigationController = Constants.walkthroughStoryboard.instantiateInitialViewController() as! UINavigationController
                    let rootViewController: TabBarViewController = Constants.homeStoryboard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                    rootViewController.selectedIndex = 1
                    navigationController.viewControllers = [rootViewController]
                    navigationController.navigationBar.isHidden = true
                    Constants.kAppDelegate.window?.rootViewController = navigationController
                }
            }else{
                AlertViewController.openAlertView(title: "Error", message: "Invalid code entered", buttons: ["Ok"]) { (index) in
                    self.initializeOTPView()
                }
            }
        }
    }
    
}
