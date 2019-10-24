//
//  ChooseUserTypeViewController.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 26/09/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit

class ChooseUserTypeViewController: UIViewController {

    /*
     MARK: - Properties
     */
    @IBOutlet var btnContinueAsFan: UIButton!
    @IBOutlet var btnRegister: UIButton!
    @IBOutlet var btnLogin: UIButton!
    //end
    
    /*
    MARK: - UIViewController Life Cycle
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserState(state: .pastEvent)
        // Do any additional setup after loading the view.
    }
    //end

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnContinueAsFanTapped(_ sender: UIButton){
        let viewController = Constants.eventStoryboard.instantiateViewController(withIdentifier: "PastEventViewController") as! PastEventViewController
        viewController.openFrom = .chooseUser
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    @IBAction func btnRegisterTapped(_ sender: UIButton){
        let viewController = Constants.loginAndSignupStoryboard.instantiateViewController(withIdentifier: "BecomeMemberViewController") as! BecomeMemberViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func btnLoginTapped(_ sender: UIButton){
        let viewController = Constants.loginAndSignupStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController( viewController, animated: true)
    }
}
