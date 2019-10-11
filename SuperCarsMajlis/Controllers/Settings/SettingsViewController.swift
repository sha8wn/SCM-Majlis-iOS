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
    var dataArray                     = ["Profile",
                                         "Change Password",
                                         "Manage Supercars",
                                         "Manage Documents",
                                         "Terms and Conditions",
                                         "Social Media",
                                         "Logout"]
    //end
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        // Do any additional setup after loading the view.
    }
    
    /*
     MARK: - SetUp View
     */
    func setUpView(){
        //Register TableView Cell
        self.tableView.register(UINib(nibName: "SettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingsTableViewCell")
        
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
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 4{
            let viewController = Constants.commonStoryboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            viewController.urlString = "https://www.apple.com"
            self.navigationController?.pushViewController(viewController, animated: true)
        }else if indexPath.row == 5{
            
        }else{
            AlertViewController.openAlertView(title: "Logout", message: "Do you want to Logout?", buttons: ["OK", "CANCEL"]) { (index) in
                if index == 0{
                    
                }else{
                    
                }
            }
        }
    }
}
