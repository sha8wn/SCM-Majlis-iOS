//
//  PromotionsViewController.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 04/11/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit
import SDWebImage

class PromotionsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblNoRecord: UILabel!
    var dataArray : [PromotionsList]   = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setUpView()
        
        self.callGetPromotionListAPI()
        
        //Firebase Analytics
        FirebaseAnalyticsManager.shared.logEvent(eventName: FirebaseEvent.PromotionActivity.rawValue)
    }
    
    /*
     MARK: - SetUp View
     */
    func setUpView(){
        //Register TableView Cell
        self.tableView.register(UINib(nibName: "MemberGoingTableViewCell", bundle: nil), forCellReuseIdentifier: "MemberGoingTableViewCell")
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
MARK: - PromotionsViewController: UITableViewDelegate and UITableViewDataSource
*/
extension PromotionsViewController: UITableViewDelegate, UITableViewDataSource{
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
        cell.imgView.sd_setImage(with: URL(string: model.partner_img ?? ""), completed: nil)

        //UserName
        cell.lblTitle.text = model.name ?? ""

        //Title
        cell.lblUserName.text = String(format: "%@, %@", model.partner_name ?? "", model.partner_location ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = Constants.homeStoryboard.instantiateViewController(withIdentifier: "PromotionDetailViewController") as! PromotionDetailViewController
        vc.dataModel = self.dataArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
