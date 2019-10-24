//
//  HomeViewController.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 03/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import UIKit
import SDWebImage

enum HomeType{
    case pastEvent
    case checkIn
}

class HomeViewController: UIViewController {
    
    /*
     MARK: - Properties
     */
    @IBOutlet var tableView           : UITableView!
    @IBOutlet var btnHeader           : UIButton!
    @IBOutlet var lblHeaderSideTitle  : UILabel!
    @IBOutlet var imgHeaderSideTitle  : UIImageView!
    @IBOutlet weak var lbl_NoData     : UILabel!
    var homeType                      : HomeType!
    var dataArray                     : [HomeList]            = []
    var totalRecord                   : Int                   = 0
    var pageNumber                    : Int                   = 1
    //end
    
    /*
     MARK: - UIViewController Life Cycle
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.homeType = .pastEvent
        self.setUpView()
        self.dataArray = []
        self.callGetEventListAPi(page: 1)
    }
    //end
    
    /*
     MARK: - SetUp View
     */
    func setUpView(){
        if self.homeType == .pastEvent{
            //Past event
            self.lblHeaderSideTitle.text = "PAST EVENTS"
            self.imgHeaderSideTitle.image = UIImage(named: "ic_PastEvent")
        }else{
            //Check In
            self.lblHeaderSideTitle.text = "CHECK IN"
            self.imgHeaderSideTitle.image = UIImage(named: "ic_Check-In")
        }
        
        //Register TableView Cell
        self.tableView.register(UINib(nibName: "HomeEventTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeEventTableViewCell")
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
    
    @IBAction func btnHeaderTapped(_ sender: Any) {
        if self.homeType == .pastEvent{
            let viewController = Constants.eventStoryboard.instantiateViewController(withIdentifier: "PastEventViewController") as! PastEventViewController
            viewController.openFrom = .home
            self.navigationController?.pushViewController( viewController, animated: true)
        }else{
            
        }
    }
}

/*
 MARK: - HomeViewController- UITableViewDelegate and UITableViewDataSource
 */
extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeEventTableViewCell", for: indexPath) as! HomeEventTableViewCell
        cell.setUpCell(model: self.dataArray[indexPath.row])
        cell.memeberDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = Constants.eventStoryboard.instantiateViewController(withIdentifier: "EventDetailsViewController") as! EventDetailsViewController
        vc.dataModel = self.dataArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

/*
 MARK: - MemberGoingDelegate
 */
extension HomeViewController: MemberGoingDelegate{
    func memberGoingTapped(model: HomeList) {
        let vc = Constants.homeStoryboard.instantiateViewController(withIdentifier: "MemberGoingListViewController") as! MemberGoingListViewController
        vc.dataModel = model
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UIScrollView Delegate
extension HomeViewController: UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if(self.dataArray.count > 0){
            if self.totalRecord > self.dataArray.count{
                self.pageNumber = self.pageNumber + 1
                self.callGetEventListAPi(page: self.pageNumber)
            }
        }
    }
}
// end
