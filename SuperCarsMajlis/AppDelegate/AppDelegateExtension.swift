//
//  AppDelegateExtension.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 25/09/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift

/**
MARK: - AppDelegate extension
*/
extension AppDelegate{
    /**
       MARK: - Project SetUp
       - This function is used to setup the project
      */
    func setUp(){
        //IQKeyboard Manager Setup
        IQKeyboardManager.shared.enable = true
    }
}
