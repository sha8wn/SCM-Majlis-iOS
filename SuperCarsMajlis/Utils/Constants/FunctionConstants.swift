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
    
    /*
    MARK: - Get Instance
     - Singleton Class
    */
    class func getInstance() -> FunctionConstants {
        struct Static {
            static let instance : FunctionConstants = FunctionConstants()
        }
        return Static.instance
    }
    
    /*
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
    
    /*
     MARK: - Hide the loader
     */
    func hideLoader(view : UIViewController){
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: view.view, animated: true)
        }
    }
    
    /*
    MARK: - Valid Email Address
    */
    func isValidEmail(email:String) -> Bool {
        let emailRegEx = "[a-zA-Z0-9][a-zA-Z0-9\\.\\_\\-\\!\\#\\$\\'\\*\\+\\=\\?\\^\\`\\{\\}\\~\\/]{0,256}" +
            "\\@" +
            "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
            "(" +
            "\\." +
            "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }

    /*
    MARK: - Valid Phone Number
    */
    func isValidMobile(Mobile:String) -> Bool{
        let RegEx = "^[0-9]{10,16}$"
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: Mobile)
    }
    
    /*
    MARK: - Trim
    */
    func trimString(str: String) -> String{
        return str.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    /*
    MARK: - Valid Numeric
    */
    func isNumeric(string: String) -> Bool
    {
        let RegEx = "^[0-9]*$"
        let test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return test.evaluate(with: string)
    }

    /*
    MARK: - Valid URL
    */
    func isValidUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = URL(string: urlString) {
                return UIApplication.shared.canOpenURL(url)
            }
        }
        return false
    }
}
