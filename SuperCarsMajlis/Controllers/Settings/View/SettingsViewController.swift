//
//  SettingsViewController.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 03/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    /*
     MARK: - Properties
     */
    @IBOutlet var tableView           : UITableView!
    @IBOutlet var lblUserName         : UILabel!
    @IBOutlet var lblUserId           : UILabel!
    @IBOutlet var lblDuration         : UILabel!
    var userModel                     : ApprovedUsersList!
    var dataArray                     : [String] = []
    //end
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dataArray = ["Profile",
                     "Change Password",
                     "Manage Supercars",
                     "Manage Documents",
                     "Contact",
                     "Terms and Conditions",
                     "Instagram",
                     "Logout"
                    ]
        
        self.setUpView()
        
        self.tableView.contentOffset = .zero
        
        self.callGetUserDetailAPI()
        
        //Firebase Analytics
        FirebaseAnalyticsManager.shared.logEvent(eventName: FirebaseEvent.SettingActivity.rawValue)
    }
    
    /*
     MARK: - SetUp View
     */
    func setUpView(){
        //Register TableView Cell
        self.tableView.register(UINib(nibName: "SettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingsTableViewCell")
        
        self.lblUserName.text = ""
        self.lblUserId.text = ""
        self.lblDuration.text = ""
    }

    func openInstagram(instagramHandle: String) {
        guard let url = URL(string: "https://instagram.com/\(instagramHandle)")  else { return }
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
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


/*
MARK: - MemberGoingListViewController: UITableViewDelegate and UITableViewDataSource
*/
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
        if indexPath.row == self.dataArray.count - 1{
            cell.bgView.layer.borderColor = UIColor.clear.cgColor
            cell.lblTitle.textAlignment = .center
            cell.lblTitle.textColor = UIColor.red
        }else{
            cell.bgView.layer.borderColor = UIColor(named: "customGreyColor")?.cgColor
            cell.lblTitle.textAlignment = .left
            cell.lblTitle.textColor = UIColor.white
        }
        cell.lblTitle.text = self.dataArray[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let vc = Constants.settingsStoryboard.instantiateViewController( withIdentifier: "ProfileViewController") as! ProfileViewController
            if self.userModel != nil{
                vc.model = self.userModel
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 1{
            let vc = Constants.settingsStoryboard.instantiateViewController( withIdentifier: "ChangePasswordViewController") as! ChangePasswordViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 2{
            let vc = Constants.settingsStoryboard.instantiateViewController( withIdentifier: "ManagerSuperCarsViewController") as! ManagerSuperCarsViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 3{
            let vc = Constants.homeStoryboard.instantiateViewController( withIdentifier: "DocumentViewController") as! DocumentViewController
            vc.openFrom = .sideMenu
            vc.arrayOfDocs = userModel.docs ?? []
            vc.arrayOfLicense = userModel.licenses ?? []
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 4{
            let viewController = Constants.homeStoryboard.instantiateViewController(withIdentifier: "FeedbackViewController") as! FeedbackViewController
            self.navigationController?.pushViewController(viewController, animated: true)
        }else if indexPath.row == 5{
            let viewController = Constants.commonStoryboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            viewController.urlString = "Terms"
            self.navigationController?.pushViewController(viewController, animated: true)
        }else if indexPath.row == 6{
            self.openInstagram(instagramHandle: "supercarsmajlis")
        }else{
            AlertViewController.openAlertView(title: "Logout", message: "Do you want to Logout?", buttons: ["LOGOUT", "CANCEL"]) { (index) in
                if index == 0{
                    setUserState(state: .pastEvent)
                    let viewController = Constants.loginAndSignupStoryboard.instantiateViewController(withIdentifier: "ChooseUserTypeViewController") as! ChooseUserTypeViewController
                    self.navigationController?.pushViewController( viewController, animated: true)
                }else{
                    
                }
            }
        }
    }
}
