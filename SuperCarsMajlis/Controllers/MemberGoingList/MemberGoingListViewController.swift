//
//  MemberGoingListViewController.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 07/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit
import SDWebImage

class MemberGoingListViewController: UIViewController {

    /*
     MARK: - Properties
     */
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblNoOfGoing: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    var dataModel: HomeList!
    var dataArray: [HomeUsers] = []
    
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
        self.tableView.register(UINib(nibName: "MemberGoingTableViewCell", bundle: nil), forCellReuseIdentifier: "MemberGoingTableViewCell")
        if self.dataModel != nil{
            self.lblTitle.text = self.dataModel.name ?? ""
            if let userArray = self.dataModel.users{
                self.lblNoOfGoing.text = "\(userArray.count) members going"
                self.dataArray = userArray
                self.tableView.reloadData()
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
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

/*
MARK: - MemberGoingListViewController: UITableViewDelegate and UITableViewDataSource
*/
extension MemberGoingListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.dataArray.count > 0{
            return dataArray.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.dataArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberGoingTableViewCell", for: indexPath) as! MemberGoingTableViewCell
        
        //Image
        cell.imgView.sd_imageIndicator = SDWebImageActivityIndicator.white
        cell.imgView.sd_setImage(with: URL(string: model.img ?? ""), completed: nil)
        
        //UserName
        cell.lblUserName.text = model.name ?? ""
        
        //Title
        cell.lblTitle.text = String(format: "%@-%@", model.brand_name ?? "", model.model_name ?? "")
        return cell
    }

}
