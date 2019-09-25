//
//  FunctionConstant.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 25/09/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit
import Foundation
import MBProgressHUD


class FunctionConstants: NSObject {
    
    /**
    MARK: - Get Instance
     - Singleton Class
    */
    class func getInstance() -> FunctionConstants {
        struct Static {
            static let instance : FunctionConstants = FunctionConstants()
        }
        return Static.instance
    }
    
    /**
     MARK: - Show the loader
     */
    func showLoader(message: String?, view: UIViewController){
        DispatchQueue.main.async {
            let messageStr = message ?? ""
            let hud = MBProgressHUD.showAdded(to: view.view, animated: true)
            hud.label.text = messageStr
            hud.isUserInteractionEnabled = true
        }
    }
    
    /**
     MARK: - Hide the loader
     */
    func hideLoader(view : UIViewController){
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: view.view, animated: true)
        }
    }
    
}
