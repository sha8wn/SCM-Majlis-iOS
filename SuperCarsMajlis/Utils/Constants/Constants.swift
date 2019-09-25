//
//  Constants.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 25/09/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import Foundation
import UIKit



class Constants: NSObject {
    /**
    MARK: - App Constants
    */
    static let kAppDelegate    = UIApplication.shared.delegate as! AppDelegate
    static let kUserDefault    = UserDefaults.standard
    static let kScreenWidth    = UIScreen.main.bounds.width
    static let kScreenHeight   = UIScreen.main.bounds.height
        //end
    
    /**
    MARK: - Storyboard Constants
    */
    static let walkthroughStoryboard       = UIStoryboard(name: "Walkthrough", bundle: nil)
    static let loginAndSignupStoryboard    = UIStoryboard(name: "LoginAndSignup", bundle: nil)
    static let commonStoryboard            = UIStoryboard(name: "Common", bundle: nil)
    static let surveyStoryboard            = UIStoryboard(name: "Survey", bundle: nil)
    static let mainStoryboard              = UIStoryboard(name: "Main", bundle: nil)
    //end
}
