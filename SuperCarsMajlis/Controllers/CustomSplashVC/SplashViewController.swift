//
//  SplashViewController.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 25/09/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit
import Foundation

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.openWalkThroughScreen()
        // Do any additional setup after loading the view.
    }
    
    func openWalkThroughScreen(){
        let navigationController: UINavigationController = Constants.walkthroughStoryboard.instantiateInitialViewController() as! UINavigationController
        let rootViewController: UIViewController = Constants.walkthroughStoryboard.instantiateViewController(withIdentifier: "WalkthroughParentViewController") as UIViewController
        navigationController.viewControllers = [rootViewController]
        navigationController.navigationBar.isHidden = true
        Constants.kAppDelegate.window?.rootViewController = navigationController
    }
    
    func openRegisterFlowForApprovedUser(){
        let navigationController: UINavigationController = Constants.walkthroughStoryboard.instantiateInitialViewController() as! UINavigationController
        let rootViewController: UIViewController = Constants.walkthroughStoryboard.instantiateViewController(withIdentifier: "RegisterApprovedMemberViewController") as UIViewController
        navigationController.viewControllers = [rootViewController]
        navigationController.navigationBar.isHidden = true
        Constants.kAppDelegate.window?.rootViewController = navigationController
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
